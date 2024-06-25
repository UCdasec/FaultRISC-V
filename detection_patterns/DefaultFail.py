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
        self.convergence_points = set()     # Stores all of the convergence points that have not been reached
        self.potential_conv_point = ""      # Holds the location of a potential convergence point
        self.encountered_labels = set()     # Stores all of the locations that have been reached
        self.branch_locations = []          # Stores all of the locations that branches go to, i.e. .L2 for bne a4,a5,.L2
        self.current_location = ""          # Stores the name of the current location
        self.branch_depth = 0               # Stores the depth of nested if statements
        self.needs_convergence = False      # Flag to indicate if the previous location had a branch that needs a convergence point
        self.location_blank = False         # Flag to indicate if a location was blank (indicates secure switch statement)
        self.last_was_nop = False           # Flag to indicate if the last instruction was a nop
        self.loop_present = False           # Flag to indicate if a loop is present in the current location
        self.at_convergence_point = False   # Flag to indicate if the current location is a convergence point

    def checkInstruction(self, line: Instruction):
        """
        This algorithm detects vulnerabilties to DefaultFail by making sure that each convergence point has the right
        number of branches/jumps leading to it based on the depth of the branching structure. A convergence point is a place 
        in the assembly where different branches of the code come together again. The depth is how many if statements are 
        nested inside of each other. If the number of branches to the convergence point is not equal to the depth, that means
        that the branching structure is vulberable to DefaultFail.
        
        This function looks for three different types of instructions and handles them seperately:
        1. Branch Instructions:
            These are instructions that either jump to a new location, or continue the path of execution, based on a 
            comparison
            
            If the location it points to has already been passed, this means it is a loop and is not relevent
            
            Otherwise the location to which it points is recorded
            
        2. 'j' Instructions:
            These instructions are indiscriminant jumps to a new location.
            
            If no branch instructions have been found in that location, this could be a jump to a convergence points
            
            Otherwise it is used as the location of a potential convergence point
            
        3. 'nop' Instructions:
            These are found at the end of every switch statement, keep track of them to help analyze
        """
        self.location_blank = False
        line_type = line.type
        
        for instruction_set in self.vulnerable_instruction_set:
            if line_type in instruction_set[0][0]:  #Branch instruction
                location = line.args[-1].arg_text
                self.needs_convergence = True
                if location in self.encountered_labels: #This branch is a loop
                    self.loop_present = True
                else:   #This is not a loop
                    self.branch_cache.append(line)
                    self.detection_cache.append(line)
                    self.branch_locations.append(location)
                    
                    #Ensure the branch depth is accurate
                    if self.branch_depth == 0:
                        self.branch_depth = 1
                    if len(self.branch_cache) > 1:
                        self.branch_depth += 1

            elif line_type in instruction_set[1][0]:    #'j' instruction
                self.needs_convergence = False
                location = line.args[-1].arg_text
                if not location in self.convergence_points and (len(self.branch_cache) > 0 or self.loop_present):
                    self.potential_conv_point = location
                elif len(self.branch_cache) == 0 and not self.at_convergence_point: #not self.last_was_convergence and
                    self.branch_locations.append(location)
                    
            elif line_type in instruction_set[2][0]:    #'nop' instruction
                self.last_was_nop = True
                
    def addFunction(self, line: Function):
        self.encountered_labels.add(line.function_name)
        self.current_location = line.function_name
        self.branch_cache.clear()          
        self.needs_convergence = False
        self.at_convergence_point = False
        self.branch_depth = 0
        self.branch_locations.clear()
        self.detection_cache.clear()
        self.convergence_points.clear()
    
    def addLocation(self, line: Location):
        new_location = f".{line.location_name}"
        previous_location = self.current_location
        
        if self.last_was_nop:
            self.branch_locations.append(new_location)
            
        if self.needs_convergence:
            self.convergence_points.add(new_location)
        
        if new_location in self.branch_locations and self.potential_conv_point != "": #not a loop, can add the potential convergence point
            self.convergence_points.add(self.potential_conv_point)
            
        self.potential_conv_point = ""

        self.at_convergence_point = False
        if new_location in self.convergence_points:    
            self.at_convergence_point = True
            self.checkConvergencePoint(new_location)
            
        #this handles rare switch statement case where there are two consecutive labels
        if self.location_blank:
            self.branch_locations.append(new_location) #add one for the transition from one to the next
            while previous_location in self.branch_locations:
                self.branch_locations.remove(previous_location)
                self.branch_locations.append(new_location)
        
        self.encountered_labels.add(new_location)
        self.current_location = new_location
        
        self.branch_cache.clear()
            
        self.needs_convergence = False
        self.location_blank = True
        self.last_was_nop = False
        self.loop_present = False
                    
    def checkConvergencePoint(self, location):
        if len(self.convergence_points) == 1: #This is the final convergence point in the branching structure
            if self.branch_locations.count(location) < self.branch_depth:                           
                self.no_vulnerable += 1
                self.vulnerable_lines.append(self.detection_cache.copy())
                self.no_vulnerable_lines += len(self.detection_cache)
            self.branch_depth = 0
            self.detection_cache.clear()
        else:
            self.branch_depth -= self.branch_locations.count(location)
        self.convergence_points.remove(location)
            