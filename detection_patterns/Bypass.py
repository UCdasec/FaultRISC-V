from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class Bypass(Pattern):
    def __init__(self, optimization_level: OptimizationLevel, tolerance: int):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for Branch
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['Bypass'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []    # Stores the set of instructions that are currently being inspected for Branch vulnerability.
        self.vulnerable_pattern = [] # The specific vulnerable pattern that is being checked

