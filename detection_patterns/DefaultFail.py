from hmac import new
from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class DefaultFail(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        #Variables for all optimization levels
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for DefaultFail
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['DefaultFail'][optimization_level]  # The vulnerable pattern set to look for
        self.detection_cache = []           # Stores all of the branch instructions in the current branching pattern
        self.encountered_labels = set()     # Stores all of the locations that have been reached
        self.current_location = ""          # Stores the name of the current location
        self.last_was_branch = False        # Flag to indicate if the last instruction was a branch
        self.last_was_jump = False          # Flag to indicate if the last instruction was a jump
        
        #O0 variables
        self.branches_needing_conv = []     # Stores all of the branch instructions whose convergence point has not been identified, to be used as FILO stack
        self.branch_locations = []          # Stores all of the locations that branches go to, i.e. .L2 for bne a4,a5,.L2
        self.branch_present = False         # Flag to indicate if a branch has been found in the current location
        self.last_branch_location = ""      # Stores the location that the last branch statement pointed to
        
        #O1 and O2 variables
        self.fall_through_locations = set() # Stores all of the locations that follow a branch instruction
        self.potentially_vulnerable_ftls = {}   # Stores all fall through locations along with their detection cache
        self.branch_cache = []              # Stores the branches in a location
        self.unencountered_branch_locs = [] # Stores all branches to unencountered locations that occur in the current location
        self.encountered_non_ftl_branches = []  #Stores all branches to encountered non-FTL locations that occur in the current location
        self.modified_registers = []        # List of all registers modified after a branch to unencountered location
        self.jumped_locations = []          # Stores all of the locations that have been jumped to

    def checkInstruction(self, line: Instruction):
        """
        O0 Method:
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
                
        O1 and O2 Method:
            There are three different ways a DefaultFail vulnerablility can present itself in O1 and O2:
            
            1. Code immediately following a branch to an unencountered label (i.e. the next line is not a label):
                Any instructions that are run after a branch instruction but before a new location is met show that the branch
                instructions are vulnerable. If there are 'else if' statements there can be multiple consecutive branch instructions, so
                only after the final one does the vulnerability need to be checked for. Additionally, if there is an 'if' statement within
                another if's 'else' block, the branch instruction for that 'if' will appear before there are any new labels. To 
                distinguish between the 'else if' situation (where there are multiple branches in a location, but the only instructions
                between them are loading the data that is to be compared) and the 'if' within 'else' situation (where there will be 
                multiple branch instructions and "meaningful" instructions between them), all modified registers will be tracked in a list.
                When a branch instruction occurs, the registers it uses will be removed from the list. Then, if there are any left in the
                list at the end of that location, there were "meaningful" instructions run after a branch statement, so they are 
                vulnerable
                
            2. Code immediately following a branch to an already-encountered location that is not a fall through location without a matchin jump:
                A fall through location (FTL) is defined as the first location encountered after one or more branch instructions within a 
                previous location. It is called as such because the flow of execution "fell through" the branch instructions and ended up
                at that location. This means that if there is a branch instruction, some other instuctions, a jump, and then a new location,
                is not an FTL because it is not reached by that flow of execution. Using this concept, if a branch leads to a previous
                location that is not an FTL, this means that it is an if statement within a loop. After one or more of these branches
                appears, they will be followed by either a jump or a final branch that leads to the current location. If there is a jump
                and it leads to the same location as the final branch statement, then it is not vulnerable, but if it leads somewhere else,
                then these branch instructions are vulnerable. If these branches are terminated by another branch that leads to the current
                location, the branches are vulnerable if any code appeared between them and the final branch (as tracked through the 
                modified registers), and not vulnerable if there were no instructions between them.
                
            3. The presence of an FTL that is never jumped to:
                An FTL is typically the convergence point for a branching structure. However, if there is an && (AND) within the if 
                statement, it may not be. If it is a convergence point, there will be at least one jump instruction occuring later that 
                leads to it. Therefore, the branches occuring before any FTL that is never jumped to are considered vulnerable. This is 
                tracked using a dictionary, where the keys are the name of every FTL and the value is the branches before that FTL. Then,
                when a jump instruction is found, that location is removed from the dictionary. At the completion of the file, if any
                FTLs are left in the dictionary, their branches are marked as vulnerable.
        """
        line_type = line.type
        self.last_was_branch = False
        self.last_was_jump = False

        if self.optimization_set == OptimizationLevel.O0:
            for instruction_set in self.vulnerable_instruction_set:
                if line_type in instruction_set[0][0]:  #Branch instruction
                    self.branch_present = True
                    location = line.args[-1].arg_text
                    if not location in self.encountered_labels: #Ensure that it isn't a loop
                        self.last_was_branch = True
                        self.branch_locations.append(location)
                        if len(self.branches_needing_conv) == 0 or self.last_branch_location != self.current_location: #indicates else if
                            self.branches_needing_conv.append(location)
                            self.detection_cache.append([])
                        self.detection_cache[-1].append(line)
                        self.last_branch_location = location

                elif line_type in instruction_set[1][0]:    #'j' instruction
                    location = line.args[-1].arg_text
                    if not location in self.encountered_labels: #Ensure that it isn't a loop
                        self.last_was_jump = True
                    if not self.branch_present:
                        self.branch_locations.append(location)
        
        elif self.optimization_set == OptimizationLevel.O1 or self.optimization_set == OptimizationLevel.O2:
            for instruction_set in self.vulnerable_instruction_set:
                if line_type in instruction_set[0][0]:      #Branch instruction
                    self.last_was_branch = True
                    location = line.args[-1].arg_text
                    self.branch_cache.append(location)
                    if not location in self.encountered_labels: #Branch goes to a location not yet reached
                        self.unencountered_branch_locs.append(location)
                        self.detection_cache.append(line)
                        for arg in line.args: #Remove the registers used by this instruction from the list of modified registers
                            if isinstance(arg, Register):
                                while arg.arg_text in self.modified_registers:
                                    self.modified_registers.remove(arg.arg_text)
                    else:   #Branch goes to a location that has already been reached
                        if not location in self.fall_through_locations: #It does not go to a fall through location
                            for arg in line.args: #Remove the registers in the branch instruction from the list of modified registers
                                if isinstance(arg, Register) and arg.arg_text in self.modified_registers:
                                    self.modified_registers.remove(arg.arg_text)
                            if location == self.current_location:
                                if self.encountered_non_ftl_branches and self.modified_registers:
                                    self.markVulnerableO1() #This is a loop going to the start of the current location. If there are modified registers, any previous branches are vulnerable
                                else: #If there were not any modified registers, the branch statements can be cleared
                                    self.unencountered_branch_locs.clear()
                                    self.encountered_non_ftl_branches.clear()
                            else: #Non-FTL previous location, this is the start of the second vulnerability
                                self.encountered_non_ftl_branches.append(location)
                                self.detection_cache.append(line)
                        else: #This branch leads to an ftl, so previous lines are clear
                            self.detection_cache.clear()
                            self.unencountered_branch_locs.clear()
                            if location in self.potentially_vulnerable_ftls.keys(): #If the ftl is vulnerable, then this line is also
                                self.potentially_vulnerable_ftls[location].append(line)

                elif line_type in instruction_set[1][0]:    #'j' instruction
                    self.last_was_jump = True
                    location = line.args[-1].arg_text
                    self.jumped_locations.append(location)
                    if location in self.potentially_vulnerable_ftls.keys(): #This means that the ftl was truly a convergence point, and not the result of an AND in the C source code
                        self.potentially_vulnerable_ftls.pop(location)
                
                elif line_type in instruction_set[2][0]:    #'ret' instruction
                    self.last_was_jump = True #For the case of a single 'if' within a function
                    
                elif line_type in instruction_set[3][0]:    #'call' instruction
                    if self.unencountered_branch_locs or self.encountered_non_ftl_branches:
                        self.modified_registers.append("a0")
                
                else: #All other instruction types
                    if self.unencountered_branch_locs or self.encountered_non_ftl_branches:
                        if len(line.args) > 1:
                            second = line.args[1]
                            if isinstance(second, Register):
                                self.modified_registers.append(second.arg_text)
                            for arg in line.args[2:]:
                                if isinstance(arg, Register):
                                    while arg in self.modified_registers:
                                        self.modified_registers.remove(arg)
                
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

        if self.optimization_set == OptimizationLevel.O0:
            if self.last_was_branch and len(self.detection_cache) > 1: #The last statement was a branch, so this is part of an 'or' in an if statement.
                # Also, there must be 2 branch statements in the detection cache for this to be trye
                self.branches_needing_conv.pop()
                self.detection_cache[-2].extend(self.detection_cache.pop())

            self.encountered_labels.add(new_location)

            if not self.last_was_jump and not self.last_was_branch: #This is a convergence point
                self.branch_locations.append(new_location)
                #self.branches_needing_conv = [new_location if item == previous_location else item for item in self.branches_needing_conv]
                self.checkConvergencePoint(new_location)
        
            if not self.last_was_branch:
                self.branch_present = False

            self.loop_present = False
            
        elif self.optimization_set == OptimizationLevel.O1 or self.optimization_set == OptimizationLevel.O2:              
            #First vulnerable pattern: code after a branch to an unencountered location before a new label is met
            if self.unencountered_branch_locs and self.modified_registers:
                next_location = new_location
                if self.last_was_jump:
                    next_location = self.jumped_locations[-1]
                if not next_location in self.unencountered_branch_locs: #For switch statements
                    self.markVulnerableO1()
                    
            #Second vulnerablility: code after a branch to an encountered non-ftl location with a mismatching jump
            elif self.encountered_non_ftl_branches and self.modified_registers and self.last_was_jump:
                if self.jumped_locations[-1] != self.encountered_non_ftl_branches[-1]:
                    #Remove all of the branches to a secure location
                    for line in self.detection_cache:
                        if line.args[-1].arg_text == self.jumped_locations[-1]:
                            self.detection_cache.remove(line)
                    self.markVulnerableO1()
                    
            #Track fall through locations
            if self.unencountered_branch_locs and not self.last_was_jump:
                self.fall_through_locations.add(new_location)
                self.potentially_vulnerable_ftls[new_location] = self.detection_cache.copy()
                
            #Clear all of the lists used for detection
            self.branch_cache.clear()
            self.unencountered_branch_locs.clear()
            self.encountered_non_ftl_branches.clear()
            self.modified_registers.clear()
            self.detection_cache.clear()
            
            self.encountered_labels.add(new_location)
            
        self.current_location = new_location
                    
    def checkConvergencePoint(self, location):
        """
        When you reach a convergence point, if there is one or more branches leading to that convergence point than its depth,
        it is secure. If there are the same number of branches leading to it as the depth, then it is vulnerable.
        """
        #First remove every branch that needs a convergence point that is guaranteed to be covered
        count = self.branch_locations.count(location) - 1
        remaining_to_pop = 0
        while count:
            if self.branches_needing_conv:
                if self.branches_needing_conv[-1] == location and not remaining_to_pop:
                    self.detection_cache.pop()
                else:
                    remaining_to_pop += 1
                self.branches_needing_conv.pop()
            count -= 1
            
        #Get the last index so that as lines are popped off the stack they get put back in order
        end_of_list = len(self.vulnerable_lines)
            
        #Then, if there are more branches that should lead to this point, mark the appropriate lines as vulnerable
        while self.branches_needing_conv and self.branches_needing_conv[-1] in self.encountered_labels:
            self.no_vulnerable += 1
            self.vulnerable_lines.insert(end_of_list, self.detection_cache[-1].copy())
            self.no_vulnerable_lines += len(self.detection_cache[-1])
            self.detection_cache.pop()
            self.branches_needing_conv.pop()
            
        if len(self.branches_needing_conv) > 0:
            self.last_branch_location = self.branches_needing_conv[-1] #To account for else ifs
        else:
            self.last_branch_location = ""      
            
        while remaining_to_pop:
            self.detection_cache.pop()
            remaining_to_pop -= 1
            
    def markVulnerableO1(self):
        self.no_vulnerable += 1
        self.no_vulnerable_lines += len(self.detection_cache)
        self.vulnerable_lines.append(self.detection_cache.copy())
        self.detection_cache.clear()
        
    def finishAnalysis(self):
        for ftl in self.potentially_vulnerable_ftls:
            cache = self.potentially_vulnerable_ftls[ftl]
            self.no_vulnerable += 1
            self.no_vulnerable_lines += len(cache)
            self.vulnerable_lines.append(cache.copy())
            