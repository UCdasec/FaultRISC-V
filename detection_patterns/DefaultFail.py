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
        self.branches_needing_conv = []     # Stores all of the branch instructions whose convergence point has not been identified, to be used as FILO stack
        #self.convergence_points = set()     # Stores all of the convergence points that have not been reached
        #self.potential_conv_point = ""      # Holds the location of a potential convergence point
        self.encountered_labels = set()     # Stores all of the locations that have been reached
        self.branch_locations = []          # Stores all of the locations that branches go to, i.e. .L2 for bne a4,a5,.L2
        self.current_location = ""          # Stores the name of the current location
        self.location_blank = False         # Flag to indicate if a location was blank (rare switch statement case)
        self.last_was_branch = False        # Flag to indicate if the last instruction was a branch
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
        self.last_was_branch = False
        line_type = line.type
        
        for instruction_set in self.vulnerable_instruction_set:
            if line_type in instruction_set[0][0]:  #Branch instruction
                self.last_was_branch = True
                location = line.args[-1].arg_text
                if location in self.encountered_labels: #This branch is a loop
                    self.loop_present = True
                else:   #This is not a loop
                    self.branch_cache.append(line)
                    self.detection_cache.append(line)
                    self.branch_locations.append(location)
                    if (len(self.branches_needing_conv) == 0 or (self.branches_needing_conv[-1] != location and \
                                                                 self.branches_needing_conv[-1] != self.current_location)):
                        self.branches_needing_conv.append(location)
                        print(f"adding branch to {location}")

            elif line_type in instruction_set[1][0]:    #'j' instruction
                self.last_was_branch = True
                location = line.args[-1].arg_text
                if len(self.branch_cache) == 0:
                    if not self.current_location in self.branch_locations:
                        self.branches_needing_conv.append(location)
                    else:
                        self.branch_locations.append(location)
                
                #replace all references to the current location with the next location
                self.branches_needing_conv = [location if item == self.current_location else item for item in self.branches_needing_conv]
                #KEEP THE FOLLOWING, DIFFICULT TO DETERMINE ORIGINALLY
                #if not location in self.convergence_points and (len(self.branch_cache) > 0 or self.loop_present):
                #    self.potential_conv_point = location
                #elif len(self.branch_cache) == 0 and not self.at_convergence_point: #not self.last_was_convergence and
                #    self.branch_locations.append(location)
                
    def addFunction(self, line: Function):
        self.encountered_labels.add(line.function_name)
        self.current_location = line.function_name
        self.branch_cache.clear()
        self.at_convergence_point = False
        self.branch_locations.clear()
        self.detection_cache.clear()
        #self.convergence_points.clear()
    
    def addLocation(self, line: Location):
        new_location = f".{line.location_name}"
        previous_location = self.current_location
        
        if new_location[2] == 'C': #This is memory, no need to handle it
            return
            
        if not self.last_was_branch:# and self.branch_locations.count(previous_location) > 0: #If this works, there is no need for the above, or last_was_nop at all
            location_present = new_location in self.branch_locations
            print(location_present)
            self.branch_locations.append(new_location) #and could probably find a way out of the rare loop below
            self.branches_needing_conv = [new_location if item == previous_location else item for item in self.branches_needing_conv]
            if location_present:
                self.checkConvergencePoint(new_location)

        """print(f"len: {len(self.branches_needing_conv)}")
        if not self.last_was_branch and len(self.branches_needing_conv) > 0:
            self.convergence_points.add(new_location)
            if new_location == ".L2":
                print("Added .L2 from needs_convergence")
        
        if new_location in self.branch_locations and self.potential_conv_point != "": #not a loop, can add the potential convergence point
            self.convergence_points.add(self.potential_conv_point)
            
        self.potential_conv_point = """""
        
        #while len(self.branches_needing_conv) > 0 and self.branches_needing_conv[-1].args[-1].arg_text == new_location:
        #    self.branches_needing_conv.pop()
        
        """self.at_convergence_point = False
        if new_location in self.convergence_points:    
            self.at_convergence_point = True
            self.checkConvergencePoint(new_location)"""   
            
        """#this handles rare switch statement case where there are two consecutive labels
        if self.location_blank:
            self.branch_locations.append(new_location) #add one for the transition from one to the next
            while previous_location in self.branch_locations:
                self.branch_locations.remove(previous_location)
                self.branch_locations.append(new_location)"""
        
        self.encountered_labels.add(new_location)
        self.current_location = new_location
        
        if not self.last_was_branch:
            self.branch_cache.clear()

        self.location_blank = True
        self.loop_present = False
                    
    def checkConvergencePoint(self, location):
        count = self.branch_locations.count(location)
        print(f"At location {location}, count is {count}")
        #pop off one for each that you know it covers? figure out what the right comp is, check out the n vs n+1 branches.
        #if count - 1 == len(self.branches_needing_conv):
        while count - 1 > 0:
            self.branches_needing_conv.pop()
            count -= 1
        if len(self.branches_needing_conv) > 0 and self.branches_needing_conv[-1] == location:
            self.no_vulnerable += 1
            self.vulnerable_lines.append(self.detection_cache.copy())
            self.no_vulnerable_lines += len(self.detection_cache)
            self.detection_cache.clear() #TODO: this isn't quite right...
            self.branches_needing_conv.pop()
            