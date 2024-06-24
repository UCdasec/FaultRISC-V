from dataclasses import dataclass
from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class Bypass(Pattern):
    @dataclass
    class LocalCache:
        detection_cache: List   # Stores the set of instructions that are currently being inspected for Branch vulnerability.
        active_pattern: List    # The specific vulnerable pattern that is being checked
        is_secure: List[bool]   # To check if the two (optionally three) secure lines have been seen
        secure_mem_address: Optional['MemoryAddress']   # Stores the memory address of function return value if it is stored in stack

    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for Branch
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['Bypass'][optimization_level][0]  # The vulnerable pattern set to look for

        self.caches: List[Bypass.LocalCache] = []  # List holding all the different caches

    def checkInstruction(self, line: Instruction):
        '''
        Due to the nature of the pattern at O-1 and O-2, the Bypass detector can concurrently check a line for multiple
        detection streams by storing multiple caches, hence for each cache (detection stream), it does the following:

        Pre-Case: The first thing to check is to see if the pattern is already fulfilled (line_no = len(cache.active_pattern).
        If this is true, we check if the necessary secure lines were found (we keep track of this with a bool). If yes, then
        we 'clean up' the cache (a cache is a single instance of a detection stream). If not, then we add it to the list of
        vulnerabilities and then remove the cache.

        Case A O-0: For the first line (i.e., call), we simply make sure the parameters match with the pattern.
        For the second line (i.e., mv), we simply make sure the parameters match with the pattern and the line has the
        a0 (fa0 for floats) as this register holds the return value by default.
            If we encounter an IGNORE line, we are simply checking that the IGNORE line is as expected. If yes, we 
        add __IGNORE_LINE__ to the detection cache or we remove it from the active pattern and run the algorithm for that line again.
        The same is true for the OPTIONAL line but we add __OPTIONAL__ instead and there are more constraints (like register being seen before).
            For __SECURE__, we want to make sure that the register being stored actually holds the return value (either a0
        or whatever register it is moved to prior). When a register is being loaded into, we make sure it is loading
        for a memory address that was previously recorded in the detection cache.
            For the final branch instruction, we expect that the registers being compared with each other to have been seen
        before in the detection cache.

        Case B O-1 and O-2: The whole reason the multiple caches exist is for O-1 and O-2, as vulnerabilities can be interspersed
            with each other. The primary difference in detection (aside from the line set for the pattern being different) is
            that the mv instruction is optional. So we conditionally look for either a0 in the branch if the mv instruction
            does not exist, or else we check the register it was moved to. One point to note is that mv copies the value
            so a0 could still be used in branching (as is the case sometimes in O-1 and O-2).

        One thing I'm still debating is whether the pattern should be restarted if a register in the cache is worked
        upon before the branch in the pattern. While it is entirely possible to branch past this in execution and retain
        the return value in the register, it is also possible that the register gets repurposed in between, in which
        case we should be able to identify the correct vulnerable line. Right now, such "sophisticated" tracking of
        return values does not exist. Currently, it is set to discard the pattern if the register occurs in an unrelated
        line (Not to be confused with an IGNORE line). This reduces potential false positives but raises potential false
        negatives. The latter, where the unrelated line effectively acts as an IGNORE line, may lead to greater false
        positives and lower false negatives.

        :param line: the current instruction being analyzed for the pattern
        '''
        line_type = line.type
        line_pattern_match = False
        if line_type == 'call':
            self.caches.append(self.LocalCache([], [], [False, False, False], None))

        for cache in self.caches:

            line_no = len(cache.detection_cache)
    
            if line_no == len(cache.active_pattern) and line_no >= 1: # Marking the vulnerability
                if not (cache.is_secure == [True, True, True] or cache.is_secure == [True, True, False]): # Only if the two main secure lines are present is it secure, or else we mark it as vulnerable
                    self.vulnerable_lines.append(cache.detection_cache.copy())
                    self.no_vulnerable += 1
                    self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' and line != '__SECURE__' for line in cache.detection_cache])
                    self.caches.remove(cache)
    
                else:
                    self.cleanup(cache, line)
    
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
                            cache.active_pattern = self.vulnerable_instruction_set.copy()
                            cache.detection_cache.append(line)
                            line_no += 1
    
                    else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                        self.cleanup(cache, line)
    
                elif line_no == 1:  # Checking for mv to initiate pattern (2nd requirement)
                    second_line = cache.active_pattern[1]
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
                            cache.detection_cache.append(line)
                            line_no += 1
    
                        else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                            self.cleanup(cache, line)

                    elif line_type == 'call':   # If call, we want to start a new detection stream
                        self.caches.append(self.LocalCache([], [], [False, False, False], None))
                        continue

                    else:   # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                        self.cleanup(cache, line)
    
                elif '__IGNORE_LINE__' in cache.active_pattern[line_no][0]:
                    if line_type in cache.active_pattern[line_no][1]:    # Check if current line is an IGNORE line
                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(pattern_arg_type is None or (pattern_arg_type is not None and isinstance(arg, pattern_arg_type)) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break
    
                            line_pattern_match = True
    
                        if line_pattern_match:  # if the line matches, adding to cache as IGNORE LINE
                            cache.detection_cache.append('__IGNORE_LINE__')
                            line_no += 1

                        elif line_type == 'call':
                            self.caches.append(self.LocalCache([], [], [False, False, False], None))
                            continue

                        else:
                            # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                            self.cleanup(cache, line)
    
                    else:   # IGNORE line not present in this case
                        cache.active_pattern.pop(line_no)    # First, remove the IGNORE line from the pattern
                        self.checkInstruction(line)
    
                elif '__SECURE__' in cache.active_pattern[line_no][0]:   # Checking if line matches SECURE pattern
                    if '__OPTIONAL__' in cache.active_pattern[line_no][0]: # Check if line is optional
                        if line_type in cache.active_pattern[line_no][1]:
                            for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                                if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                                    line_pattern_match = False
                                    break
    
                                line_pattern_match = True

                            if line_pattern_match:
                                cache.is_secure[2] = True    # 3rd secure line (the optional one) is true
                                cache.detection_cache.append('__SECURE__')
                                line_no += 1

                            elif line_type == 'call':
                                self.caches.append(self.LocalCache([], [], [False, False, False], None))
                                continue

                            else:
                                # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                                self.cleanup(cache, line)
    
                        else:   # Optional line not present; remove from pattern
                            cache.active_pattern.pop(line_no)
                            self.checkInstruction(line)
    
                    else:   # Not optional
                        if line_type in cache.active_pattern[line_no][1]:
                            for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                                if not any(isinstance(arg, pattern_arg_type)
                                           for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                                    line_pattern_match = False
                                    break
    
                                if isinstance(arg, Register) and line_type.startswith('s'): # To make sure the register whose value is being stored in stack is same as one in mv
                                    if not any(arg.arg_text == cache_arg.arg_text for cache_instruction in cache.detection_cache for cache_arg in cache_instruction.args):
                                        line_pattern_match = False
                                        break
                                    else:
                                        cache.is_secure[0] = True
    
                                if isinstance(arg, MemoryAddress) and line_type.startswith('s') and cache.is_secure[0]: # Keep track of memory address return value is stored at.
                                    cache.secure_mem_address = arg
    
                                if isinstance(arg, MemoryAddress) and line_type.startswith('l'):    # To make sure the address in stack being loaded from is the same as one in above store
                                    if cache.secure_mem_address is not None and not (arg.arg_text == cache.secure_mem_address.arg_text):
                                        line_pattern_match = False
                                        break
                                    else:
                                        cache.is_secure[1] = True
    
                                line_pattern_match = True
    
                            if line_pattern_match:  # Secure line present
                                cache.detection_cache.append('__SECURE__')
                                line_no += 1
    
                            else:   # depending on if there is the mv instruction, we continue the vulnerability if there isn't or else we assume insecure
                                if cache.detection_cache[1].type == 'mv' and cache.is_secure[1] is False:
                                    self.cleanup(cache, line)
    
                        else:   # Secure line not present; remove from pattern and try again
                            cache.active_pattern.pop(line_no)
                            self.checkInstruction(line)

                elif '__OPTIONAL__' in cache.active_pattern[line_no][0]: # Check if line is optional
                    if line_type in cache.active_pattern[line_no][1]:
                        has_matching_register = False
                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break

                            line_pattern_match = True

                            if isinstance(arg, Register):
                                for cache_instruction in cache.detection_cache:
                                    if isinstance(cache_instruction, Instruction):
                                        if any(arg.arg_text == cache_arg.arg_text for cache_arg in cache_instruction.args):
                                            has_matching_register = True

                        if line_pattern_match and has_matching_register:  # Optional line present
                            cache.detection_cache.append('__OPTIONAL__')
                            line_no += 1

                        else:   # Remove optional line from pattern
                            cache.active_pattern.pop(line_no)
                            self.checkInstruction(line)

                    else:   # Remove optional line from pattern
                        cache.active_pattern.pop(line_no)
                        self.checkInstruction(line)

                elif line_type in cache.active_pattern[line_no][0]:  # Standard line
                    for arg_no, arg in enumerate(line.args, start=1):   # making sure all line parameters align with pattern
                        if not any(arg is pattern_arg_type or (pattern_arg_type is not None and isinstance(arg, pattern_arg_type)) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        if isinstance(arg, Register):   # The register MUST be the same the one in the mv instruction else pattern is not Bypass
                            for cache_instruction in cache.detection_cache:
                                if isinstance(cache_instruction, Instruction):
                                    if any(arg.arg_text == cache_arg.arg_text for cache_arg in cache_instruction.args):
                                        line_pattern_match = False
                                        break

                        line_pattern_match = True
    
                    if line_pattern_match:  # if the line matches, adding to cache
                        cache.detection_cache.append(line)
                        line_no += 1
    
                else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                    self.cleanup(cache, line)
    
            elif self.optimization_set in [OptimizationLevel.O1, OptimizationLevel.O2]: # O-1 and O-2 have a similar pattern
                if line_no == 0:    # Checking for call to initiate pattern (1st requirement)
                    first_line = self.vulnerable_instruction_set[0]
                    if line_type in first_line[0]:
                        for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                            if not any(isinstance(arg, first_line_arg) for first_line_arg in first_line[arg_no]):
                                line_pattern_match = False
                                break
    
                            line_pattern_match = True
    
                        if line_pattern_match:  # The line matches the pattern, so we initiate the pattern and add current line to detection cache
                            cache.active_pattern = self.vulnerable_instruction_set.copy()
                            cache.detection_cache.append(line)
                            line_no += 1
    
                elif '__OPTIONAL__' in cache.active_pattern[line_no][0]: # Check if line is optional
                    if line_type in cache.active_pattern[line_no][1]:
                        for arg_no, arg in enumerate(line.args, start=2):   # Making sure all the other parameters align
                            if not any(isinstance(arg, first_line_arg) for first_line_arg in cache.active_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break
    
                            if arg_no == 3 and isinstance(arg, Register) and arg.arg_text != 'a0':
                                line_pattern_match = False
                                break
    
                            line_pattern_match = True
    
                        if line_pattern_match:  # if the line matches, adding to cache
                            cache.detection_cache.append(line)
                            line_no += 1

                        elif line_type == 'call':
                            self.caches.append(self.LocalCache([], [], [False, False, False], None))
                            continue

                        else:
                            # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                            self.cleanup(cache, line)

                    elif line_type == 'call':
                        self.caches.append(self.LocalCache([], [], [False, False, False], None))
                        continue

                    else:   # if the instruction type does not match and any of the args is register a0, remove the optional line
                        cache.active_pattern.pop(line_no)
                        self.checkInstruction(line)

                elif '__IGNORE_LINE__' in cache.active_pattern[line_no][0]:  # Check if line is an IGNORE line
                    if line_type in cache.active_pattern[line_no][1]:
                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break
    
                            line_pattern_match = True
    
                        if line_pattern_match:  # if the line matches, adding to cache as IGNORE LINE
                            cache.detection_cache.append('__IGNORE_LINE__')
                            line_no += 1

                        elif line_type == 'call':
                            self.caches.append(self.LocalCache([], [], [False, False, False], None))
                            continue

                        else:
                            # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                            self.cleanup(cache, line)

                    elif line_type == 'call':
                        self.caches.append(self.LocalCache([], [], [False, False, False], None))
                        continue

                    else:   # IGNORE line not present, remove from pattern and try again
                        cache.active_pattern.pop(line_no)    # First, remove the IGNORE line from the pattern
                        self.checkInstruction(line)
    
                elif line_type in cache.active_pattern[line_no][0]:  # If line is integral to pattern (only applies to branch statement)
                    register_match = False  # For checking if the register with the return value is in the branch statement
                    for arg_no, arg in enumerate(line.args, start=1):   # Making sure all the other parameters align
                        if not any(arg is pattern_arg_type or (pattern_arg_type is not None and isinstance(arg, pattern_arg_type)) for pattern_arg_type in cache.active_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break
    
                        line_pattern_match = True
    
                        if (isinstance(arg, Register) and line_no >= 2 and
                                (isinstance(cache.detection_cache[1], Instruction) and cache.detection_cache[1].type in ['mv','sext.w']) and
                                ((arg.arg_text == cache.detection_cache[1].args[0].arg_text) or
                                 (arg.arg_text == 'a0' and cache.detection_cache[1].args[1].arg_text == 'a0'))):
                            # if mv instruction passed, we check if the register moved to exists or if it's a0, we check that it wasn't overwritten in the mv instruction
                            register_match = True
    
                        elif isinstance(arg, Register) and arg.arg_text == 'a0': # if mv instruction is not passed, we check if it contains a0
                            register_match = True
    
                    if line_pattern_match and register_match:
                        cache.detection_cache.append(line)
                        line_no += 1
    
                elif line_no >= 2 and (isinstance(cache.detection_cache[1], Instruction) and cache.detection_cache[1].type == 'mv'): # if mv instruction passed, we make sure the current line doesn't have register moved to.
                    if any(isinstance(arg, Register) and arg.arg_text == cache.detection_cache[1].args[0].arg_text for arg in line.args):
                            # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                            self.cleanup(cache, line)

    
                else: # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                    if line_type == 'call':
                        self.caches.append(self.LocalCache([], [], [False, False, False], None))
                        continue

                    else:
                        # The line does not match the pattern, so this is not an example of Bypass (secure or Insecure)
                        self.cleanup(cache, line)

    def cleanup(self, cache: LocalCache, line: Instruction):
        '''
        The cleanup occurs whenever a pattern is broken by a line. When this happens, we check if the last actual
        line in the cache is the line right before this one (so that we can restart the detection fresh from this line if it is)
        The other reason we'd start the detection again is if the line type is call (this is the main trigger for Bypass).

        :param cache: The cache of choice to be removed
        :param line: The instruction that triggered the cleanup
        '''
        cache.detection_cache = list(filter(lambda line: not isinstance(line, str), cache.detection_cache))   # Removing all IGNORE/SECURE/OPTIONAL lines as those do not count
        last_line_no = cache.detection_cache[-1].line_no if len(cache.detection_cache) > 0 else None
        self.caches.remove(cache)
        if last_line_no == line.line_no - 1 or line.type == 'call':
            self.checkInstruction(line)