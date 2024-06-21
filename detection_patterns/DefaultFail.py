from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class DefaultFail(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for DefaultFail
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['DefaultFail'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []           # Stores all of the branch instructions in the current branching pattern
        self.branch_cache = []              # Stores all of the branch instructions in the current location
        self.convergence_points = set()
        self.encountered_labels = set()
        self.current_label = ""
        self.branch_depth = 0
        self.branch_in_location = False
        self.branches_to_convergence = 0
        self.needs_convergence = False

    def checkInstruction(self, line: Instruction):
        line_type = line.type
        for instruction_set in self.vulnerable_instruction_set:
            if line_type in instruction_set[0][0]:
                self.branch_cache.append(line)
                self.detection_cache.append(line)
                self.needs_convergence = True
                if self.branch_depth == 0:
                    self.branch_depth = 1
                if len(self.branch_cache) > 1:
                    self.branch_depth += 1
                location = line.args[-1].arg_text
                if location in self.convergence_points:
                    self.branches_to_convergence += 1

            elif line_type in instruction_set[1][0]:
                self.needs_convergence = False
                location = line.args[-1].arg_text
                if not location in self.encountered_labels:
                    self.convergence_points.add(location)
                
    def addFunction(self, line: Function):
        self.encountered_labels.add(line.function_name)
        self.current_label = line.function_name
        self.branch_cache.clear()          
        self.needs_convergence = False
    
    def addLocation(self, line: Location):
        if len(self.branch_cache) == 0 and f".{line.location_name}" in self.convergence_points:
            self.branches_to_convergence += 1

        self.encountered_labels.add(line.location_name)
        self.current_label = line.location_name
        self.branch_cache.clear()
        
        if self.needs_convergence:
            self.convergence_points.add(line.location_name)
            
        self.needs_convergence = False
        
        if f".{line.location_name}" in self.convergence_points:
            if self.branches_to_convergence < self.branch_depth:
                self.no_vulnerable += 1
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable_lines += len(self.detection_cache)
                self.detection_cache.clear()
                self.branch_depth = 0
                self.branches_to_convergence = 0