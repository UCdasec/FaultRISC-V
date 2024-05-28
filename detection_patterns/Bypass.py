from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class Bypass(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for Branch
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['Bypass'][optimization_level][0]  # The vulnerable pattern set to look for
        self.detection_cache = []    # Stores the set of instructions that are currently being inspected for Branch vulnerability.
        self.vulnerable_pattern = [] # The specific vulnerable pattern that is being checked
        self.is_secure = [False, False, False]  # To check if the two (optionally three) secure lines have been seen
        self.secure_mem_address: MemoryAddress = None   # Stores the memory address of function return value if it is stored in stack

    def checkInstruction(self, line: Instruction):
        '''

        :param line:
        '''
        line_type = line.type
        line_pattern_match = False
        line_no = len(self.detection_cache)

        if line_no == len(self.vulnerable_pattern) and line_no >= 1: # Marking the vulnerability
            if not (self.is_secure == [True, True, True] or self.is_secure == [True, True, False]): # Only if the two main secure lines are present is it secure, or else we mark it as vulnerable
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable += 1
                self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' and line != '__SECURE__' for line in self.detection_cache])
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()
                self.is_secure = [False, False, False]
                self.secure_mem_address = None

            else:
                self.cleanup(line)

        elif self.optimization_set == OptimizationLevel.O0:   # O-0 Detection
            if line_no == 0:    # Checking for call to initiate pattern (1st requirement)
                first_line = self.vulnerable_instruction_set[0]
                if line_type in first_line[0]:
                    for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                        if not any(isinstance(arg, first_line_arg) for first_line_arg in first_line[arg_no]):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # The line matches the pattern, so we initiate the pattern and add current line to detection cache
                        self.vulnerable_pattern = self.vulnerable_instruction_set.copy()
                        self.detection_cache.append(line)
                        line_no += 1

                else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                    self.cleanup(line)

            elif line_no == 1:  # Checking for mv to initiate pattern (2nd requirement)
                second_line = self.vulnerable_pattern[1]
                if line_type in second_line[0]:
                    has_a0 = False  # Boolean to check if one of the args is the a0 or fa0 register
                    for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                        if not any(isinstance(arg, first_line_arg) for first_line_arg in second_line[arg_no]):
                            line_pattern_match = False
                            break

                        if isinstance(arg, Register) and arg.arg_text in ['a0', 'fa0']: # checking if one of the args is the a0 or fa0 register
                            has_a0 = True

                        line_pattern_match = True

                    if line_pattern_match and has_a0:  # line matches so we add the current line to detection cache
                        self.detection_cache.append(line)
                        line_no += 1

                    else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                        self.cleanup(line)

                else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                    self.cleanup(line)

            elif '__IGNORE_LINE__' in self.vulnerable_pattern[line_no][0]:
                if line_type in self.vulnerable_pattern[line_no][1]:    # Check if current line is an IGNORE line
                    for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # if the line matches, adding to cache as IGNORE LINE
                        self.detection_cache.append('__IGNORE_LINE__')
                        line_no += 1

                    else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                        self.cleanup(line)

                else:   # IGNORE line not present in this case
                    self.vulnerable_pattern.pop(line_no)    # First, remove the IGNORE line from the pattern
                    self.checkInstruction(line)

            elif '__SECURE__' in self.vulnerable_pattern[line_no][0]:   # Checking if line matches SECURE pattern
                if '__OPTIONAL__' in self.vulnerable_pattern[line_no][0]: # Check if line is optional
                    if line_type in self.vulnerable_pattern[line_no][1]:
                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break

                            line_pattern_match = True

                        if line_pattern_match:
                            self.is_secure[2] = True    # 3rd secure line (the optional one) is true
                            self.detection_cache.append('__SECURE__')
                            line_no += 1

                        else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                            self.cleanup(line)

                    else:   # Optional line not present; remove from pattern
                        self.vulnerable_pattern.pop(line_no)
                        self.checkInstruction(line)

                else:   # Not optional
                    if line_type in self.vulnerable_pattern[line_no][1]:
                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(isinstance(arg, pattern_arg_type)
                                       for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break

                            if isinstance(arg, Register) and line_type.startswith('s'): # To make sure the register whose value is being stored in stack is same as one in mv
                                if not any(arg.arg_text == cache_arg.arg_text for cache_instruction in self.detection_cache for cache_arg in cache_instruction.args):
                                    line_pattern_match = False
                                    break
                                else:
                                    self.is_secure[0] = True

                            if isinstance(arg, MemoryAddress) and line_type.startswith('s') and self.is_secure[0]: # Keep track of memory address return value is stored at.
                                self.secure_mem_address = arg

                            if isinstance(arg, MemoryAddress) and line_type.startswith('l'):    # To make sure the address in stack being loaded from is the same as one in above store
                                if self.secure_mem_address is not None and not (arg.arg_text == self.secure_mem_address.arg_text):
                                    line_pattern_match = False
                                    break
                                else:
                                    self.is_secure[1] = True

                            line_pattern_match = True

                        if line_pattern_match:  # Secure line present; remove from pattern
                            self.detection_cache.append('__SECURE__')
                            line_no += 1

                        else:   # depending on if there is the mv instruction, we continue the vulnerability if there isn't or else we continue assuming insecure
                            if self.detection_cache[1].type == 'mv' and self.is_secure[1] is False:
                                self.cleanup(line)

                    else:   # Secure line not present; remove from pattern and try again
                        self.vulnerable_pattern.pop(line_no)
                        self.checkInstruction(line)

            elif line_type in self.vulnerable_pattern[line_no][0]:  # Standard line
                for arg_no, arg in enumerate(line.args, start=1):   # making sure all line parameters align with pattern
                    if not any(arg is pattern_arg_type or (pattern_arg_type is not None and isinstance(arg, pattern_arg_type)) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                        line_pattern_match = False
                        break

                    if isinstance(arg, Register):   # The register MUST be the same the one in the mv instruction else pattern is not Bypass
                        if not any(arg.arg_text == cache_arg.arg_text for cache_instruction in self.detection_cache for cache_arg in cache_instruction.args):
                            line_pattern_match = False
                            break

                    line_pattern_match = True

                if line_pattern_match:  # if the line matches, adding to cache
                    self.detection_cache.append(line)
                    line_no += 1

            else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                self.cleanup(line)

        elif self.optimization_set in [OptimizationLevel.O1, OptimizationLevel.O2]: # O-1 and O-2 have a similar pattern
            if line_no == 0:    # Checking for call to initiate pattern (1st requirement)
                first_line = self.vulnerable_instruction_set[0][0]
                if line_type == first_line.type:
                    for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                        if not any(isinstance(arg, first_line_arg) for first_line_arg in first_line[arg_no]):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # The line matches the pattern, so we initiate the pattern and add current line to detection cache
                        self.vulnerable_pattern = self.vulnerable_instruction_set[0].copy()
                        self.detection_cache.append(line)
                        line_no += 1

            elif '__OPTIONAL__' in self.vulnerable_pattern[line_no][0]: # Check if line is optional
                if line_type in self.vulnerable_pattern[line_no][1]:
                    for arg_no, arg in enumerate(line.args, start=2):   # Making sure all the other parameters align
                        if not any(isinstance(arg, first_line_arg) for first_line_arg in self.vulnerable_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        if not (isinstance(arg, Register) and arg_no == 3 and arg.arg_text == 'a0'):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # if the line matches, adding to cache
                        self.detection_cache.append(line)
                        line_no += 1

                else:   # if the instruction type does not match and any of the args is register a0, the pattern is broken
                    for arg in line.args:
                        if isinstance(arg, Register) and arg.arg_text == 'a0':
                            self.cleanup(line)

            elif '__IGNORE_LINE__' in self.vulnerable_pattern[line_no][0]:  # Check if line is an IGNORE line
                if line_type in self.vulnerable_pattern[line_no][1]:
                    for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # if the line matches, adding to cache as IGNORE LINE
                        self.detection_cache.append('__IGNORE_LINE__')
                        line_no += 1

                elif line_type in self.vulnerable_pattern[line_no+1][0]:    # Check if current line is line after IGNORE line
                    self.vulnerable_pattern.pop(line_no)    # First, remove the IGNORE line from the pattern
                    self.checkInstruction(line)

            elif line_type in self.vulnerable_pattern[line_no][0]:  # If line is integral to pattern (only applies to branch statement)
                register_match = False  # For checking if the register with the return value is in the branch statement
                for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                    if not any(isinstance(arg, first_line_arg) for first_line_arg in self.vulnerable_pattern[line_no][arg_no]):
                        line_pattern_match = False
                        break

                    line_pattern_match = True

                    if isinstance(arg, Register) and line_no >= 2 and self.detection_cache[1].type == 'mv' and arg.arg_text == self.detection_cache[1].args[0]:
                        # if mv instruction passed, we check if the register moved to exists
                        register_match = True

                    elif isinstance(arg, Register) and not arg.arg_text == 'a0': # if mv instruction is not passed, we check if it contains a0
                        register_match = True

                if line_pattern_match and register_match:
                    self.detection_cache.append(line)
                    line_no += 1

            elif line_no >= 2 and self.detection_cache[1].type == 'mv': # if mv instruction passed, we make sure the current line doesn't have register moved to.
                if any(isinstance(arg, Register) and arg.arg_text == self.detection_cache[1].args[0] for arg in line.args):
                    # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                    self.cleanup(line)

            elif not any(arg.arg_text == 'a0' for arg in line.args):    # if no mv instruction, we assume it is a0 as that holds the return value
                if any(isinstance(arg, Register) and arg.arg_text == 'a0' for arg in line.args):
                    # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                    self.cleanup(line)

            else: # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                self.cleanup(line)

    def cleanup(self, line: Instruction):
        self.detection_cache = list(filter(lambda line: not isinstance(line, str), self.detection_cache))   # Removing all IGNORE LINES as those do not count
        last_line_no = self.detection_cache[-1].line_no if len(self.detection_cache) > 0 else None
        self.detection_cache.clear()
        self.vulnerable_pattern.clear()
        self.is_secure = [False, False, False]
        self.secure_mem_address = None
        if last_line_no == line.line_no - 1 or line.type == 'call':
            self.checkInstruction(line)