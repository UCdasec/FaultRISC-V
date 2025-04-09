from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class ConstantCoding(Pattern):
    def __init__(self, optimization_level: OptimizationLevel, tolerance: int):
        self.vulnerable_lines: List = []                                        # All the vulnerabilities found for ConstantCoding
        self.no_vulnerable = 0                                                  # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                            # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                              # the optimization level of the risc-v program
        self.tolerance = tolerance                                              # hamming distance tolerance
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['ConstantCoding'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []                                               # Stores the set of instructions that are currently being inspected for ConstantCoding vulnerability.
        self.vulnerable_pattern = []                                            # The specific vulnerable pattern that is being checked

    def checkInstruction(self, line: GlobalVariable | Attribute):
        '''
        This function inspects the given line to see if it matches the right position in any of the vulnerable
        instruction sets for ConstantCoding at the specific optimization level.
        The detection is handled differently in case it's an attribute or a Global Variable.

        In case it's an attribute, We match to see if the lines being streamed in match any one of the
        vulnerable instruction sets for ConstantCoding line-by-line. We also check to see that the attribute doesn't 
        already fall under the range of a global variable that has already been marked vulnerable.

        A global variable is handled in a single run of the ConstantCoding detector even if there are multiple vulnerable
        constants in that global variable. The global variable object already contains information of all its values,
        so we simply shave off those that are not constant coding vulnerable and add the whole vulnerability in one run.
        :param line: The instruction to be inspected for branch vulnerability
        '''
        line_type = line.type if isinstance(line, Attribute) else line.variable_type
        line_pattern_match = False
        line_no = len(self.detection_cache)

        if line_no == 0:    # Initiating the vulnerable instruction pattern
            for instruction_set in self.vulnerable_instruction_set:
                if (line_type in instruction_set[0][0] and  # Instruction or Attribute
                        any([isinstance(line, Instruction), isinstance(line, Attribute)])): # making sure all line parameters align with pattern

                    for arg_no, arg in enumerate(line.args, start=1):
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in instruction_set[0][arg_no]):
                            line_pattern_match = False
                            break

                        if isinstance(arg, IntegerLiteral):
                            # if isinstance(line, Instruction):
                            #     hamming_weight_0, hamming_weight_1 = calculate_hamming(arg.arg_value)
                            #     if hamming_weight_0 > self.tolerance and hamming_weight_1 > self.tolerance:
                            #         line_pattern_match = False
                            #         break

                            '''
                            In case of an attribute, we want to make sure that the attribute hasn't already been marked
                            vulnerable by a previous global variable, as there is room for overlap as a result of a 
                            (questionable) design choice of the code author. We check this by comparing the line numbers
                            and verifying whether the attribute is within the range of lines covered by the global variable.
                            '''
                            if isinstance(line, Attribute):   # In case of attribute, we must check that it doesn't overlap with a previous global variable
                                if len(self.vulnerable_lines) >=1 and isinstance(self.vulnerable_lines[-1][0], GlobalVariable):
                                    attribute_line_no = line.line_no
                                    global_var_reach = self.vulnerable_lines[-1][0].variable_values[-1].line_no
                                    if attribute_line_no > global_var_reach:
                                        hamming_weight_0, hamming_weight_1 = calculate_hamming(arg.arg_value)
                                        if hamming_weight_0 > self.tolerance and hamming_weight_1 > self.tolerance:
                                            line_pattern_match = False
                                            break
                                    else:
                                        line_pattern_match = False
                                        break

                                # NOTE: Unindent by 1 tabspace if errors in code (If it ain't broke don't fix it philosophy)
                                hamming_weight_0, hamming_weight_1 = calculate_hamming(arg.arg_value)
                                if hamming_weight_0 > self.tolerance and hamming_weight_1 > self.tolerance:
                                        line_pattern_match = False
                                        break

                            line_pattern_match = True

                    '''
                    For global variables, we replace each non-low hamming weight integer from the list of var values with 
                    IGNORE LINE. Then, if the list is not all IGNORE LINE after (i.e., there is at least one constant coding 
                    vulnerability), we add the global variable label and its constituent remaining attribute lines 
                    (which are all vulnerable) to the list of vulnerable lines.
                    '''
                elif line_type in instruction_set[0][0] and isinstance(line, GlobalVariable):   # Global Variable
                    for var in line.variable_values:
                        hamming_weight_0, hamming_weight_1 = calculate_hamming(var.args[0].arg_value)
                        if hamming_weight_0 <= self.tolerance or hamming_weight_1 <= self.tolerance:
                            self.detection_cache.append(line)
                            self.detection_cache.append(var)

                            self.vulnerable_lines.append(self.detection_cache.copy())
                            self.no_vulnerable += 1
                            self.no_vulnerable_lines += 1
                            self.detection_cache.clear()

                    break

                if line_pattern_match:  # if the line matches, adding to cache and confirming vulnerable pattern type
                    self.vulnerable_pattern = instruction_set.copy()
                    self.detection_cache.append(line)
                    line_no += 1
                    break

            if line_no == len(self.vulnerable_pattern) and line_no >= 1: # Marking the vulnerability
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable += 1
                self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()

        elif (line_type in self.vulnerable_pattern[line_no][0] or
              (self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__' and
               line_type in self.vulnerable_pattern[line_no+1][0])):  # Completing the pattern. Only applicable to Instruction or Attribute

            if (self.vulnerable_pattern[line_no][0] == '__IGNORE_LINE__' and    # Optional IGNORE LINE not present, remove from pattern
                    line_type in self.vulnerable_pattern[line_no+1][0]):
                self.vulnerable_pattern.pop(line_no)

            for arg_no, arg in enumerate(line.args, start=1):
                if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in self.vulnerable_pattern[line_no][arg_no]):
                    line_pattern_match = False
                    break

                if isinstance(arg, Register) and arg_no == 1:   # Cross-checking the registers between the two lines
                    previous_register = self.detection_cache[0].args[0]
                    if arg.arg_text != previous_register.arg_text:
                        line_pattern_match = False
                        break

                line_pattern_match = True

            if line_pattern_match:  # if the line matches, adding to cache
                self.detection_cache.append(line)
                line_no += 1

            else:   # Pattern broken; no vulnerability, and try pattern detection again from current line if last line in detection cache was previous line
                last_line_no: int = 0
                if isinstance(self.detection_cache[-1], Instruction):
                    last_line_no = self.detection_cache[-1].line_no
                elif isinstance(self.detection_cache[-2], Instruction):
                    last_line_no = self.detection_cache[-2].line_no
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()
                if last_line_no == line.line_no - 1:
                    self.checkInstruction(line)

            if line_no == len(self.vulnerable_pattern) and line_no >= 1: # 3.Marking the vulnerability
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable += 1
                self.no_vulnerable_lines += sum([line != '__IGNORE_LINE__' for line in self.detection_cache])
                self.detection_cache.clear()
                self.vulnerable_pattern.clear()

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
            last_line_type = Instruction if isinstance(self.detection_cache[-1], Instruction) else str
            last_line_no = self.detection_cache[-1].line_no if isinstance(self.detection_cache[-1], Instruction) else self.detection_cache[-2].line_no
            self.detection_cache.clear()
            self.vulnerable_pattern.clear()
            if ((last_line_no == line.line_no - 1 and last_line_type is Instruction)    # Only if the current line is the very next line or one after if previous line was IGNORE
                    or (last_line_no == line.line_no - 2 and last_line_type is str)):
                self.checkInstruction(line)

