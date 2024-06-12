from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class Branch(Pattern):
    def __init__(self, optimization_level: OptimizationLevel, tolerance: int):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for Branch
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.tolerance = tolerance                                      # hamming distance tolerance
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['Branch'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []    # Stores the set of instructions that are currently being inspected for Branch vulnerability.
        self.vulnerable_pattern = [] # The specific vulnerable pattern that is being checked

    def checkInstruction(self, line: Instruction):
        '''
        This function inspects the given instruction to see if it matches the right position in any of the vulnerable
        instruction sets for Branch at the specific optimization level.

        It has 3 parts -
        1. Initiating a vulnerable instruction pattern : The pattern that is triggered if the line given is the first
            line in any of the vulnerable instruction sets. For Branch, this includes verifying that the integer if any
            has a hamming weight below the tolerance as only then is branch triggered.

        2. Completing the pattern : There are two cases for this, when we have a regular line to inspect or an IGNORE LINE
            For the IGNORE LINE, we are only making sure that the instruction type and the arg types match up with what
            we expect. For a regular line, we check the same, but we also make sure that the register in the previous
            vulnerable line is the same as the second register argument in the current line, as this connects the two lines.
            This does not apply in the case the vulnerability spans a single line.

        3. Marking the vulnerability : In case the number of lines in the detection cache is the same as the no. of lines
            expected in the vulnerable instruction set, we assert the pattern is complete, so we clear the cache into
            the list of vulnerable lines, increase the no. of vulnerabilities, and empty the vulnerable pattern we
            are detecting for.

        :param line: The instruction to be inspected for branch vulnerability
        '''
        line_type = line.type
        line_pattern_match = False
        line_no = len(self.detection_cache)

        if line_no == 0:    # 1.Initiating the vulnerable instruction pattern
            for instruction_set in self.vulnerable_instruction_set:
                if line_type in instruction_set[0][0]:                  # making sure all line parameters align with pattern
                    for arg_no, arg in enumerate(line.args, start=1):
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in instruction_set[0][arg_no]):
                            line_pattern_match = False
                            break

                        if isinstance(arg, IntegerLiteral): # Hamming weight check
                            if calculate_hamming(arg.arg_value, 0) > self.tolerance and not is_bit_maximum(arg.arg_value):
                                line_pattern_match = False
                                break

                        line_pattern_match = True

                if line_pattern_match:  # if the line matches, adding to cache and confirming vulnerable pattern type
                    self.vulnerable_pattern = instruction_set.copy()
                    self.detection_cache.append(line)
                    line_no += 1
                    break

            if line_no == len(self.vulnerable_pattern) and line_no >= 1: # 3.Marking the vulnerability
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable += 1
                self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()

        # 2. Completing the pattern
        elif (line_type in self.vulnerable_pattern[line_no][0] or # if line type matches current pattern line
              (len(self.vulnerable_pattern) > line_no+2 and line_type in self.vulnerable_pattern[line_no+2][0]) or # if line type matches pattern line skipping IGNORE and OPTIONAL
              (self.vulnerable_pattern[line_no][0] == '__OPTIONAL__' and line_type in self.vulnerable_pattern[line_no+1][0]) or # if line type matches OPTIONAL
              (self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__' and line_type in self.vulnerable_pattern[line_no+1][1])): # if line type matches IGNORE

            if self.vulnerable_pattern[line_no][0] == '__OPTIONAL__': # Optional LINE not present, remove from pattern
                self.vulnerable_pattern.pop(line_no)

            elif self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__':  #IGNORE LINE not present, remove from pattern and test optional
                self.vulnerable_pattern.pop(line_no)
                self.checkInstruction(line)
                return

            register_match = True   # To manage whether either of the registers match
            for arg_no, arg in enumerate(line.args, start=1):   # making sure all line parameters align with pattern
                if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                    line_pattern_match = False
                    break

                if isinstance(arg, Register) and arg_no == 1:   # Cross-checking the registers between the two lines (1st register case)
                    if len(self.detection_cache) == 1:
                        previous_register = self.detection_cache[0].args[0]
                        if arg.arg_text != previous_register.arg_text:  # Just marking the register was not matched instead of breaking the line pattern
                            register_match = False

                    else:   # In case of multiple registers being compared
                        previous_registers = [cache_instruction.args[0] for cache_instruction in
                                              filter(lambda x: isinstance(x, Instruction), self.detection_cache)]
                        if not any (arg.arg_text == previous_register.arg_text for previous_register in previous_registers):
                            register_match = False
                            if isinstance(self.detection_cache[line_no-1], str) or self.detection_cache[line_no-1].type in ['lbu', 'lui']: # the lbu/lui line is irrelevant (or is an IGNORE line) to pattern if register does not match
                                self.detection_cache.pop(line_no-1)
                                self.vulnerable_pattern.pop(line_no-1)
                                line_no -= 1

                            elif self.detection_cache[line_no-1].type == 'li':    # restart pattern with previous li line
                                first_line = self.detection_cache[line_no-1]
                                self.detection_cache.clear()
                                self.vulnerable_pattern.clear()
                                self.checkInstruction(first_line)
                                self.checkInstruction(line)
                                return


                elif isinstance(arg, Register) and arg_no == 2 and not register_match: # 2nd register case
                    if len(self.detection_cache) == 1:   # if register was not matched in 1st arg
                        previous_register = self.detection_cache[0].args[0]
                        if arg.arg_text != previous_register.arg_text:
                            line_pattern_match = False
                            break

                        else:
                            register_match = True

                    else:   # In case of multiple registers being compared
                        previous_registers = [cache_instruction.args[0] for cache_instruction in self.detection_cache]
                        if not any(arg.arg_text == previous_register.arg_text for previous_register in previous_registers):
                            line_pattern_match = False
                            break

                        else:
                            register_match = True

                line_pattern_match = True if register_match else False

            if line_pattern_match:  # if the line matches, adding to cache
                self.detection_cache.append(line)
                line_no += 1

            else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                last_line_type = Instruction if isinstance(self.detection_cache[-1], Instruction) else str
                last_line_no = self.detection_cache[-1].line_no if isinstance(self.detection_cache[-1], Instruction) else self.detection_cache[-2].line_no
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()
                if ((last_line_no == line.line_no - 1 and last_line_type is Instruction)    # Only if the current line is the very next line or one after if previous line was IGNORE
                        or (last_line_no == line.line_no - 2 and last_line_type is str)):
                    self.checkInstruction(line)

            if line_no == len(self.vulnerable_pattern) and line_no >= 1: # 3.Marking the vulnerability
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable += 1
                self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()

        elif (line_type in self.vulnerable_pattern[line_no][1] and
              self.vulnerable_pattern[line_no][0] == '__OPTIONAL__'):  # 2.Completing the pattern OPTIONAL LINE case

            for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                    line_pattern_match = False
                    break

                line_pattern_match = True

            if line_pattern_match:  # if the line matches, adding to cache
                self.detection_cache.append(line)
                line_no += 1

            else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                last_line_no = self.detection_cache[-1].line_no
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()
                if last_line_no == line.line_no - 1:
                    self.checkInstruction(line)

        elif (line_type in self.vulnerable_pattern[line_no][1] and
              self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__'):  # Completing the pattern IGNORE LINE case
            for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                    line_pattern_match = False
                    break

                line_pattern_match = True

            if line_pattern_match:  # if the line matches, adding to cache as IGNORE LINE
                self.detection_cache.append('__IGNORE_LINE__')
                line_no += 1

            else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                last_line_no = self.detection_cache[-1].line_no
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()
                if last_line_no == line.line_no - 1:
                    self.checkInstruction(line)

        else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
            self.detection_cache = list(filter(lambda line: not isinstance(line, str), self.detection_cache))   # Removing all IGNORE LINES as those do not count
            last_line_no = self.detection_cache[-1].line_no
            self.detection_cache.clear()
            self.vulnerable_pattern.clear()
            if last_line_no == line.line_no - 1:
                self.checkInstruction(line)
