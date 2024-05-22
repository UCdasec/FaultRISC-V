from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class LoopCheck(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for LoopCheck
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['LoopCheck'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []           # Stores the set of instructions that are currently being inspected for LoopCheck vulnerability.
        self.secure_cache = []              # Stores the expected secure pattern to follow the vulnerable pattern recorded in detection_cache
        self.vulnerable_pattern = []        # The specific vulnerable pattern that is being checked
        self.pattern_undetermined = True   # Flag for if the pattern has not yet been determined
        self.insecure_match = False         # If the first half of the pattern, i.e., the insecure first half is complete
        self.location_list = []             # Keeps track of all locations that have been visited thus far

    def checkInstruction(self, line: Instruction | Location):
        '''
        This function handles a variety of cases. The first is if the line given is an instruction or a location. If it
        is the former, then we decide where in the pattern we are -- either in the first insecure half or the latter
        secure half.

        if it is the first insecure half, we detect the pattern as we have with the other patterns.
        It has 3 parts -
        1. Initiating a vulnerable instruction pattern : The pattern that is triggered if the line given is the first
        line in any of the vulnerable instruction sets. Since there are two patterns with the same first line, both
        patterns are added initially.

        1.5 Disqualifying the incorrect pattern. Only one pattern is ultimately true, so the second line is compared
        to see which of the possible patterns doesn't match, and that one is removed.

        2. Completing the pattern : This can either be a relevant line or an IGNORE LINE. If it is the former, then we
        ensure that all the parameters line up and for LoopCheck specifically, either in the 4th line or in 2nd/3rd, the
        branch instruction has registers that were previously referenced and the label being branched to has been previously
        visited (i.e., found in the location_list).
            If it is an IGNORE LINE, like other patterns, we check if the line after it is relevant to the current line,
        (i.e., the IGNORE LINE is not present in this case) and remove the IGNORE LINE from the current pattern or
        if it is present, we simply make sure that it matches the pattern and proceed without updating the detection
        cache.

        3. Marking the vulnerability : In case the number of lines in the detection cache is the same as the no. of lines
        expected in the vulnerable instruction set, we assert the first half of the pattern is complete, so we move
        into insecure_match mode - where we start looking for the secure half to complete the insecure half.

        Detecting the second secure half is similar to detecting the first insecure half - as we are essentially looking
        to see the insecure pattern repeated to a different Location as the branch point. The main difference is that we
        already know what pattern to look for. We match the second half with the first half (in default cache) to see
        if the instructions align. The only instruction that shouldn't align is the final branch instruction. It is not
        necessary for the branch type to be the same as the first half and the branch location/label must be different.
        The other args should align.

        If the second half matches the first half, there is no vulnerability and all parameters are cleared without
        adding detection cache to the list of vulnerable lines. If the second half breaks at any point (i.e., it does not
        align with the former half in detection cache), it is vulnerable and we add whatever is in the detection cache
        to the list of vulnerabilities.

        :param line: Either an instruction part of the actual vulnerability or a location to add to the list of locations
            seen thus far.
        '''
        if isinstance(line, Instruction):
            line_type = line.type
            line_pattern_match = False
            line_no = len(self.detection_cache) if not self.insecure_match else len(self.secure_cache)

            if not self.insecure_match: # Detecting the first half

                if self.pattern_undetermined and line_no >= 1:  # Step 1.5: Determining the correct pattern with the second line
                    if len(self.vulnerable_pattern) == 1:   # If there is only one qualified pattern, that is set as the only pattern
                        self.vulnerable_pattern = self.vulnerable_pattern[0]
                        self.pattern_undetermined = False

                    else:
                        set_no = 0
                        while set_no < len(self.vulnerable_pattern): # If there are multiple candidates
                            instruction_set = self.vulnerable_pattern[set_no]
                            if not((line_type in instruction_set[1][0] or # If the next line is neither an IGNORE line or a matching line
                                    (instruction_set[1][0] == '__IGNORE_LINE__' and
                                     line_type in instruction_set[2][0]))
                                   or (line_type in instruction_set[1][1] and
                                       instruction_set[1][0] == '__IGNORE_LINE__')):

                                self.vulnerable_pattern.remove(instruction_set)
                                self.detection_cache.pop()
                                line_no -= 1

                            else:   # Move on to next set
                                set_no += 1


                        if line_no == 1:
                            self.vulnerable_pattern = self.vulnerable_pattern[0]
                            self.pattern_undetermined = False

                        else:   # Pattern broken; no vulnerability, and try pattern detection again from current line
                            self.pattern_undetermined = True
                            self.checkInstruction(line)

                if line_no == 0:
                    for instruction_set in self.vulnerable_instruction_set: # Determining correct LoopCheck pattern
                        first_instruction = instruction_set[0]
                        if line_type in first_instruction[0] and len(line.args) == len(first_instruction) - 1:
                            for arg_no, line_arg in enumerate(line.args, start=1):
                                if any(isinstance(line_arg, pattern_arg) for pattern_arg in first_instruction[arg_no]):
                                    line_pattern_match = True

                                else:
                                    line_pattern_match = False
                                    break

                            if line_pattern_match:  # Suspected pattern type added to list of vulnerable patterns to try
                                self.vulnerable_pattern.append(instruction_set.copy())
                                self.detection_cache.append(line)
                                line_no += 1

                    if line_no == 1 and line_no == len(self.vulnerable_pattern[0]): # Checks if the insecure half of the pattern is complete
                        self.insecure_match = True
                        self.vulnerable_pattern = self.vulnerable_pattern[0]
                        self.pattern_undetermined = False

                elif (line_type in self.vulnerable_pattern[line_no][0] or   # Completing the pattern
                      (self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__' and
                       (line_no + 1 < len(self.vulnerable_pattern) and line_type in self.vulnerable_pattern[line_no+1][0]))):

                    if (self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__' and    # Optional IGNORE LINE not present, remove from pattern
                            line_type in self.vulnerable_pattern[line_no+1][0]):
                        self.vulnerable_pattern.pop(line_no)

                    for arg_no, arg in enumerate(line.args, start=1):   # making sure all line parameters align with pattern
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        if line_no >= 3 or ((line_no == 1 or line_no == 2) and line_type.startswith('b')): # Former is for 4-line pattern and latter is for 2-line pattern (see vulnerable_instruction_list.py)
                            if isinstance(arg, Register) and arg_no >= 1:   # Making sure register(s) line up
                                if not any(arg.arg_text == cache_arg.arg_text for cache_instruction in self.detection_cache for cache_arg in cache_instruction.args):
                                    line_pattern_match = False
                                    break

                            elif isinstance(arg, Label) and arg.label_type == LabelType.LOCATION and arg_no == 3:   # Making sure location branching to has already been visited
                                if not any(arg.arg_text[1:] == location.location_name for location in self.location_list):
                                    line_pattern_match = False
                                    break

                        line_pattern_match = True

                    if line_pattern_match:
                        self.detection_cache.append(line)
                        line_no += 1

                    if line_no == len(self.vulnerable_pattern) and line_no >= 1:
                        self.insecure_match = True

                elif (line_type in self.vulnerable_pattern[line_no][1] and
                      self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__'):  # 2.Completing the pattern IGNORE LINE case

                    for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                            line_pattern_match = False
                            break

                        line_pattern_match = True

                    if line_pattern_match:  # if the line matches, adding to detection cache as IGNORE LINE
                        self.detection_cache.append('__IGNORE_LINE__')
                        if line_no + 1 < len(self.vulnerable_pattern):
                            line_no += 1
                        else:
                            self.insecure_match = True

                    else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                        last_line_no = self.detection_cache[-1].line_no
                        self.detection_cache.clear()
                        self.vulnerable_pattern.clear()
                        self.pattern_undetermined = True
                        if last_line_no == line.line_no - 1:
                            self.checkInstruction(line)

                else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                    last_line_no = self.detection_cache[-1].line_no \
                        if not isinstance(self.detection_cache[-1], str) else self.detection_cache[-2].line_no
                    self.detection_cache.clear()
                    self.vulnerable_pattern.clear()
                    self.pattern_undetermined = True
                    if last_line_no == line.line_no - 1:
                        self.checkInstruction(line)

            elif self.insecure_match:   # Detecting the second half
                insecure_line = self.detection_cache[line_no]

                if insecure_line == '__IGNORE_LINE__':
                    if (line_type in self.vulnerable_pattern[line_no][1] and
                            self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__'):

                        for arg_no, arg in enumerate(line.args, start=2):   # making sure all line parameters align with pattern
                            if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                                line_pattern_match = False
                                break

                        line_pattern_match = True

                    if line_pattern_match:  # if the line matches, adding to secure cache as IGNORE LINE
                        self.secure_cache.append('__IGNORE_LINE__')
                        line_no += 1

                    else:   # Secure pattern broken; vulnerable
                        self.vulnerable_lines.append(self.detection_cache.copy())
                        self.no_vulnerable += 1
                        self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                        self.detection_cache.clear()
                        self.secure_cache.clear()
                        self.pattern_undetermined = True
                        self.insecure_match = False
                        self.vulnerable_pattern.clear()

                elif not line_type.startswith('b'): # Making sure line matches exactly with insecure line
                    if line.line_text == insecure_line.line_text:
                        self.secure_cache.append(line)
                        line_no += 1

                    else:   # Secure pattern broken; vulnerable
                        self.vulnerable_lines.append(self.detection_cache.copy())
                        self.no_vulnerable += 1
                        self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                        self.detection_cache.clear()
                        self.secure_cache.clear()
                        self.pattern_undetermined = True
                        self.insecure_match = False
                        self.vulnerable_pattern.clear()

                elif line_type.startswith('b'): # Making sure the register and/or integer value match exactly. Label and branch type can vary
                    args_match = False

                    if line_type in self.vulnerable_pattern[line_no][0] and len(line.args) == len(insecure_line.args):
                        for arg_no in range(len(line.args)):
                            if isinstance(line.args[arg_no], Register) and isinstance(insecure_line.args[arg_no], Register):
                                if any(line.args[arg_no].arg_text == insecure_arg.arg_text for insecure_arg in insecure_line.args): # pass if same
                                    args_match = True

                                else:   # Fail - secure half not found
                                    args_match = False
                                    break

                            elif isinstance(line.args[arg_no], IntegerLiteral) and isinstance(insecure_line.args[arg_no], IntegerLiteral):
                                if line.args[arg_no].arg_text == insecure_line.args[arg_no].arg_text: # pass if same
                                    args_match = True

                                else:   # Fail - secure half not found
                                    args_match = False
                                    break

                            elif isinstance(line.args[arg_no], Label) and isinstance(insecure_line.args[arg_no], Label):
                                if line.args[arg_no].arg_text != insecure_line.args[arg_no].arg_text: # pass if NOT same
                                    args_match = True

                                else:   # Fail - secure half not found
                                    args_match = False
                                    break

                            else:   # Fail - secure half not found
                                args_match = False
                                break

                        if not args_match:  # Secure pattern broken; vulnerable
                            self.vulnerable_lines.append(self.detection_cache.copy())
                            self.no_vulnerable += 1
                            self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])

                        self.detection_cache.clear()
                        self.secure_cache.clear()
                        self.pattern_undetermined = True
                        self.insecure_match = False
                        self.vulnerable_pattern.clear()

                else:   # Secure pattern broken; vulnerable
                    self.vulnerable_lines.append(self.detection_cache.copy())
                    self.no_vulnerable += 1
                    self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                    self.detection_cache.clear()
                    self.secure_cache.clear()
                    self.pattern_undetermined = True
                    self.insecure_match = False
                    self.vulnerable_pattern.clear()

        elif isinstance(line, Location):    # Adding to list of visited locations
            self.location_list.append(line)
