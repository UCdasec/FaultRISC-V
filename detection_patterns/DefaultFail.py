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
        self.current_detection_cache = []   # Used to preserve the old detection cache as a new location is being analyzed
        self.branch_cache = []              # Stores all of the branch instructions in the current location
        self.potential_convergence_points = set()   # Stores all of the locations that could be convergence points
        self.encountered_labels = set()     # Stores all of the locations that have been reached
        self.branch_locations = []          # Stores all of the locations that branches go to, i.e. .L2 for bne a4,a5,.L2
        self.current_location = ""          # Stores the name of the current locations
        self.branch_depth = 0               # Stores the depth of nested if statements
        self.current_location_depth = 0     # Stores the depth at the current location
        self.last_was_convergence = False   # Flag to indicate if the last location was truly a convergence point
        self.needs_convergence = False      # Flag to indicate if the previous location had a branch that needs a convergence point
        self.location_blank = False         # Flag to indicate if a location was blank (indicates secure switch statement)
        self.last_was_nop = False

    def checkInstruction(self, line: Instruction):
        """
        This algorithm detects vulnerabilties to DefaultFail by making sure that each convergence point has the right
        number of branches/jumps leading to it based on the depth of the branching structure. A convergence point is a place 
        in the assembly where different branches of the code come together again. The depth is how many if statements are 
        nested inside of each other. If the number of branches to the convergence point is not equal to the depth, that means
        that the branching structure is vulberable to DefaultFail.
        
        This function looks for four different types of instructions and handles them seperately:
        1. Branch Instructions:
            These are instructions that either jump to a new location, or continue the path of execution, based on a 
            comparison
            
            If the location it points to has already been passed, this means it is a loop and is not relevent
            
            Otherwise the location to which it points is recorded
            
        2. 'j' Instructions:
            These instructions are indiscriminant jumps to a new location.
            
            If no branch instructions have been found in that location, this could be a jump to a convergence points
            
            Otherwise it is used as the location of a potential convergence point
            
        3. 'jr' Instructions:
            These instructions indicate the end of a functions. Because a location cannot be fully analyzed until all of
            its lines have been inspected, this is used to analyze the final location.
            
        4. 'nop' Instructions:
            These are found at the end of every switch statement, keep track of them to help analyze
        """
        self.location_blank = False
        line_type = line.type
        
        for instruction_set in self.vulnerable_instruction_set:
            if line_type in instruction_set[0][0]:  #Branch instruction
                location = line.args[-1].arg_text
                self.needs_convergence = True
                if location in self.encountered_labels: #This branch is a loop
                    self.last_was_convergence = False
                    self.potential_convergence_points.remove(self.current_location)
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
                #if not location in self.encountered_labels and len(self.branch_cache) > 0:
                if not location in self.potential_convergence_points:
                    self.potential_convergence_points.add(location)
                elif len(self.branch_cache) == 0:
                    self.branch_locations.append(location)
                    
            elif line_type in instruction_set[2][0]:    #'jr' instruction
                self.checkConvergencePoint(self.current_location)
                
            elif line_type in instruction_set[3][0]:    #'nop' instruction
                self.last_was_nop = True
                
    def addFunction(self, line: Function):
        self.encountered_labels.add(line.function_name)
        self.current_location = line.function_name
        self.branch_cache.clear()          
        self.needs_convergence = False
        self.branch_depth = 0
        self.branch_locations.clear()
        self.detection_cache.clear()
    
    def addLocation(self, line: Location):
        new_location = f".{line.location_name}"
        previous_location = self.current_location

        #can only tell if a location was a convergence point (as opposed to a location in a loop) after it has been
        #analyzed completely
        if self.last_was_convergence:
            self.checkConvergencePoint(previous_location)
            
        #this handles rare switch statement case where there are two consecutive labels
        if self.location_blank:
            self.branch_locations.append(new_location) #add one for the transition from one to the next
            while previous_location in self.branch_locations:
                self.branch_locations.remove(previous_location)
                self.branch_locations.append(new_location)
                
        if self.last_was_nop:
            self.branch_locations.append(new_location)
        
        self.encountered_labels.add(new_location)
        self.current_location = new_location
        self.current_detection_cache = self.detection_cache.copy()
        self.current_location_depth = self.branch_depth
        self.branch_cache.clear()
        
        if self.needs_convergence:
            self.potential_convergence_points.add(new_location)
            
        self.needs_convergence = False
        self.location_blank = True
        self.last_was_nop = False
        
        if new_location in self.potential_convergence_points: #assume it is a true convergence point, disprove later
            self.last_was_convergence = True
        else:
            self.last_was_convergence = False
            
    def checkConvergencePoint(self, location):
        print(f"Location: {location}, count: {self.branch_locations.count(location)}, depth {self.current_location_depth}")
        if self.branch_locations.count(location) < self.current_location_depth:
            self.no_vulnerable += 1
            self.vulnerable_lines.append(self.current_detection_cache.copy())
            self.no_vulnerable_lines += len(self.detection_cache)
        self.detection_cache.clear()
        self.branch_depth = 0
            