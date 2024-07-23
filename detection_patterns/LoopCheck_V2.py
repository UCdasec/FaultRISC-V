from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class LoopCheck(Pattern):
    def __init__(self, check_gap_sensitivity: int):
        self.vulnerable_lines: List = []                    # All the vulnerabilities found for LoopCheck
        self.no_vulnerable = 0                              # No. of vulnerabilities
        self.no_vulnerable_lines = 0                        # No. of lines of code covered by the vulnerabilities found
        self.program_cache = []                             # Temporary program cache from topmost location in location_list

        self.detection_cache = {                            # Properties of the of loop being checked
            'Branch_Statement': None,                       # The branch statement that loops backwards
            'Looping_Location': None,                       # Location to which the branch loops back to
            'Increment_Statement': None,                    # The increment statement if found
            'iterating_Var': None,                          # The iterating variable (Either a register or a memory location)
            'Num_Iterations_var': None                      # The number of iterations (Either a register, memory location, or integer literal)
        }

        self.check_gap_sensitivity = check_gap_sensitivity  # How many lines to tolerate when checking for loop completion check statement
        self.location_list = []                             # Keeps track of all locations that have been visited thus far
        self.unseen_location_list = []                      # Keeps track of all locations that have not been visited but have been referenced

    def checkInstruction(self, line: Instruction | Location):
        if self.location_list and line.line_no > self.location_list[0].line_no:
            self.program_cache.append(line)

        if isinstance(line, Instruction):
            line_type = line.type

            if line_type in ['jr', 'ret']: # Remove all locations and clear program cache encased between returns
                self.location_list.clear()
                self.program_cache.clear()
                return

            elif line_type == 'j':  # Remove all locations from the jump reference until current line and clear program cache
                arg = line.args[0]
                if isinstance(arg, Label) and arg.label_type == LabelType.LOCATION:
                    matching_location = next((location for location in self.location_list if arg.arg_text[1:] == location.location_name), None)
                    if matching_location is not None:   # True if location found in location list, which means continuity broken
                        self.location_list.clear()
                        self.program_cache.clear()
                        return

                    else:   # Continuity potentially not broken, add to list of unseen locations
                        self.unseen_location_list.append(line)

            elif line_type in ['beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu', 'bleu']:   # A branch statement, check if loops backward
                loc_arg = line.args[2]
                if any(loc_arg.arg_text[1:] == location.location_name for location in self.location_list):

                    # To make sure that the location branched to does not exit the loop at some point
                    matching_location = next((location for location in self.location_list if loc_arg.arg_text[1:] == location.location_name), None)
                    if not any(unseen_location.line_no > matching_location.line_no for unseen_location in self.unseen_location_list):
                        self.detection_cache['Branch_Statement'] = line
                        self.detection_cache['Looping_Location'] = matching_location

                        # Next, to check whether an increment statement exists between looping location and branch
                        increment_line = next((cached_line for cached_line in self.program_cache[::-1] if cached_line.type in ['addi', 'addiw']), None)
                        if increment_line is not None and increment_line.args[0].arg_text == increment_line.args[1].arg_text:
                            self.detection_cache['Increment_Statement'] = increment_line

                            # Next, to determine the iterating variable. This can either be a register or a memory address
                            self.detection_cache['Iterating_Var'] = increment_line.args[0]
                            for cached_line in self.program_cache[increment_line.line_no - self.program_cache[0].line_no:]:

                                if (cached_line.type == 'sw' and   # If store, record memory address storing to
                                        cached_line.args[0].arg_text == self.detection_cache['Iterating_Var'].arg_text):
                                    self.detection_cache['Iterating_Var'] = cached_line.args[1]

                            # Next, to determine number of iterations variable
                            integer_arg = next((arg for arg in self.detection_cache['Branch_Statement'].args if isinstance(arg, IntegerLiteral)), None)
                            if integer_arg: # If it is an integer, record it
                                self.detection_cache['Num_Iterations_var'] = integer_arg.arg_value

                            else:   # If no integer found, try to find location stored to
                                target_vars = [self.detection_cache['Branch_Statement'].args[0].arg_text, self.detection_cache['Branch_Statement'].args[1].arg_text]
                                for cached_line in self.program_cache[::-1]:

                                    # Check to see if any of the registers from the branch statement loads from a memory address
                                    if (cached_line.type == 'lw' and cached_line.args[1].arg_text in target_vars and
                                        cached_line.args[1].arg_text != self.detection_cache['Iterating_Var'].arg_text):
                                        self.detection_cache['Num_Iterations_var'] = cached_line.args[1].arg_text

                                    # If a register swap happens, keep track of that
                                    if cached_line.type in ['mv', 'sext.w'] and cached_line.args[1].arg_text in target_vars:
                                        target_vars[target_vars.index(cached_line.args[1].arg_text)] = cached_line.args[1].arg_text

                                    if (cached_line.type == 'lw' and cached_line.args[1].arg_text in target_vars and
                                            cached_line.args[1].arg_text == self.detection_cache['Iterating_Var'].arg_text):
                                        target_vars.remove(cached_line.args[1].arg_text)

                                if self.detection_cache['Num_Iterations_var'] is None:
                                    

                        else:   # Loop is not a for-loop. Clear detection cache
                            self.clear_detection_cache()

        elif isinstance(line, Location):    # Adding to list of visited locations
            self.location_list.append(line)
            location_name = line.location_name

            # If an unseen location has been seen, remove it from the unseen location list
            unseen_location_seen = next((unseen_location for unseen_location in self.unseen_location_list if location_name == unseen_location.args[0].arg_text[1:]), None)
            if unseen_location_seen is not None:
                self.unseen_location_list.remove(unseen_location_seen)

    def clear_detection_cache(self):
        '''
        Clears detection cache
        '''
        self.detection_cache = {
            'Branch_Statement': None,
            'Looping_Location': None,
            'Increment_Statement': None,
            'iterating_var': None,
            'Num_iterations': None
        }