from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class ConstantCoding(Pattern):
    def __init__(self, optimization_level: OptimizationLevel, tolerance: int):
        self.vulnerable_lines: List = []  # All the vulnerabilities found for Branch
        self.no_vulnerable = 0  # No. of vulnerabilities
        self.optimization_set = optimization_level  # the optimization level of the risc-v program
        self.tolerance = tolerance  # hamming distance tolerance
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['ConstantCoding'][optimization_level]  # The vulnerable pattern set to look for

    detection_cache = []  # Stores the set of instructions that are currently being inspected for Branch vulnerability.
    vulnerable_pattern = []  # The specific vulnerable pattern that is being checked

    def checkInstruction(self, line: Instruction | GlobalVariable | Attribute):
        '''
        This function inspects the given instruction to see if it matches the right position in any of the vulnerable
        instruction sets for ConstantCoding at the specific optimization level.
        :param line: The instruction to be inspected for branch vulnerability
        '''
        line_type = line.type if any([isinstance(line, Instruction), isinstance(line, Attribute)]) else line.variable_type
        line_pattern_match = False
        line_no = len(self.detection_cache)

        if line_no == 0:    # 1.Initiating the vulnerable instruction pattern
            for instruction_set in self.vulnerable_instruction_set:
                if (line_type in instruction_set[0][0] and  # Instruction or Attribute
                        any([isinstance(line, Instruction), isinstance(line, Attribute)])): # making sure all line parameters align with pattern

                    for arg_no, arg in enumerate(line.args, start=1):
                        if not any(isinstance(arg, pattern_arg_type) for pattern_arg_type in instruction_set[0][arg_no]):
                            line_pattern_match = False
                            break

                        if isinstance(arg, IntegerLiteral):
                            if isinstance(line, Instruction):
                                if calculate_hamming(arg.arg_value, 0) > self.tolerance:
                                    line_pattern_match = False
                                    break

                                '''
                                In case of an attribute, we want to make sure that the attribute hasn't already been marked
                                vulnerable by a previous global variable, as there is room for overlap as a result of a 
                                (questionable) design choice of the code author. We check this by comparing the line numbers
                                and verifying whether the attribute is within the range of lines covered by the global variable.
                                '''
                            elif isinstance(line, Attribute):   # In case of attribute, we must check that it doesn't overlap with a previous global variable
                                if len(self.vulnerable_lines) >=1 and isinstance(self.vulnerable_lines[-1], GlobalVariable):
                                    attribute_line_no = line.line_no
                                    global_var_reach = self.vulnerable_lines[-1].line_no + len(self.vulnerable_lines[-1].variable_values)
                                    if attribute_line_no > global_var_reach:
                                        if calculate_hamming(arg.arg_value, 0) > self.tolerance:
                                            line_pattern_match = False
                                            break
                                    else:
                                        line_pattern_match = False
                                        break

                                elif calculate_hamming(arg.arg_value, 0) > self.tolerance:
                                    line_pattern_match = False
                                    break

                elif line_type in instruction_set[0][0] and isinstance(line, GlobalVariable):   # Global Variable
                    pass # TODO: remove all non-trivial values for line global variable and then continue


        elif line_type in self.vulnerable_pattern[line_no][0]:
            pass
        else:   # Pattern broken; no vulnerability
            self.detection_cache.clear()
            self.vulnerable_pattern.clear()
