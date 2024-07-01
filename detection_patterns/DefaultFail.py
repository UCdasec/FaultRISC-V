from hmac import new
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
        self.branches_needing_conv = []     # Stores all of the branch instructions whose convergence point has not been identified, to be used as FILO stack
        self.encountered_labels = set()     # Stores all of the locations that have been reached
        self.branch_locations = []          # Stores all of the locations that branches go to, i.e. .L2 for bne a4,a5,.L2
        self.current_location = ""          # Stores the name of the current location
        self.last_was_branch = False        # Flag to indicate if the last instruction was a branch
        self.last_was_jump = False          # Flag to indicate if the last instruction was a jump
        self.branch_present = False         # Flag to indicate if a branch has been found in the current location
        self.last_branch_location = ""      # Stores the location that the last branch statement pointed to

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
        self.last_was_branch = False
        self.last_was_jump = False
        line_type = line.type
        
        for instruction_set in self.vulnerable_instruction_set:
            if line_type in instruction_set[0][0]:  #Branch instruction
                self.last_was_branch = True
                self.branch_present = True
                location = line.args[-1].arg_text
                if not location in self.encountered_labels: #Ensure that it isn't a loop
                    self.branch_locations.append(location)
                    if len(self.branches_needing_conv) == 0 or self.last_branch_location != self.current_location: #indicates else if
                        self.branches_needing_conv.append(location)
                        self.detection_cache.append([])
                    self.detection_cache[-1].append(line)
                    self.last_branch_location = location

            elif line_type in instruction_set[1][0]:    #'j' instruction
                location = line.args[-1].arg_text
                self.last_was_jump = True
                if not self.branch_present:
                    if not self.current_location in self.branch_locations:
                        self.branches_needing_conv.append(location)
                        self.detection_cache.append([])
                    else:
                        self.branch_locations.append(location)
                
                #replace all references to the current location with the next location
                self.branches_needing_conv = [location if item == self.current_location else item for item in self.branches_needing_conv]
                
    def addFunction(self, line: Function):
        self.encountered_labels.add(line.function_name)
        self.current_location = line.function_name
        self.branch_present = False
        self.branch_locations.clear()
        self.branch_locations.append(self.current_location)
        self.last_branch_location = ""
        self.detection_cache.clear()
    
    def addLocation(self, line: Location):
        new_location = f".{line.location_name}"
        previous_location = self.current_location
        
        if new_location[2] == 'C': #This is memory, no need to handle it
            return
        
        if self.last_was_branch: #The last statement was a branch, so this is part of an 'or' in an if statement
            self.branches_needing_conv.pop()
            self.detection_cache[-2].extend(self.detection_cache[-1])

        if not self.last_was_jump and not self.last_was_branch: #This is a convergence point
            self.branch_locations.append(new_location)
            self.branches_needing_conv = [new_location if item == previous_location else item for item in self.branches_needing_conv]
            self.checkConvergencePoint(new_location)

        self.current_location = new_location
        self.encountered_labels.add(new_location)
        
        if not self.last_was_branch:
            self.branch_present = False

        self.loop_present = False
                    
    def checkConvergencePoint(self, location):
        """
        When you reach a convergence point, if there are one more branches leading to that convergence point that its depth,
        it is secure. If there are the same number of branches leading to it as the depth, then it is vulnerable.
        """
        #First remove every branch that needs a convergence point that is guaranteed to be covered
        count = self.branch_locations.count(location)
        while count - 1 > 0:
            if self.branches_needing_conv:
                self.branches_needing_conv.pop()
                self.detection_cache.pop()
            count -= 1
            
        if self.detection_cache: #Get the last index so that as lines are popped off the stack they get put back in order
            end_of_list = len(self.vulnerable_lines)
        else:
            end_of_list = 0
            
        #Then, if there are more branches that should lead to this point, mark the appropriate lines as vulnerable
        while self.branches_needing_conv and (self.branches_needing_conv[-1] == location \
                                                or self.branches_needing_conv[-1] in self.encountered_labels):
            self.no_vulnerable += 1
            self.vulnerable_lines.insert(end_of_list, self.detection_cache[-1].copy())
            self.no_vulnerable_lines += len(self.detection_cache[-1])
            self.detection_cache.pop()
            self.branches_needing_conv.pop()
        if len(self.branches_needing_conv) > 0:
            self.last_branch_location = self.branches_needing_conv[-1] #To account for else ifs
        else:
            self.last_branch_location = ""            
            