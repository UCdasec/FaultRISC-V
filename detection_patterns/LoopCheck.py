from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class LoopCheck(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for LoopCheck
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['LoopCheck'][optimization_level]  # The vulnerable pattern set to look for

    detection_cache = []    # Stores the set of instructions that are currently being inspected for LoopCheck vulnerability.
    vulnerable_pattern = [] # The specific vulnerable pattern that is being checked

    def checkInstruction(self, line: Instruction):
        pass