import re

from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list

class LoopCheck_V2(Pattern):
    def __init__(self, check_gap_sensitivity: int):
        self.vulnerable_lines: List = []                    # All the vulnerabilities found for LoopCheck
        self.no_vulnerable = 0                              # No. of vulnerabilities
        self.no_vulnerable_lines = 0                        # No. of lines of code covered by the vulnerabilities found
        self.program_cache = []                             # Temporary program cache from topmost location in location_list

        self.insecure_cache = {                             # Properties of the of loop being checked
            'Branch_Statement': None,                       # The branch statement that loops backwards
            'Looping_Location': None,                       # Location to which the branch loops back to
            'Increment_Statement': None,                    # The increment statement if found
            'Iterating_Var': None,                          # The iterating variable (Either a register or a memory location)
            'Num_Iterations_Var': None                      # The variable holding the number of iterations (Either a register, memory location, or integer literal)
        }
        
        self.loop_found = False                             # Whether a for loop has been identified or not

        self.secure_cache = {                               # To keep track of a potential loop check following the loop
            'Branch_Statement': None,                       # The branch statement that verified completion of the loop
            'Num_Iterations_Var': None                      # The variable holding the number of iterations
        }

        self.check_gap_sensitivity = check_gap_sensitivity  # How many lines to tolerate when checking for loop completion check statement
        self.location_list = []                             # Keeps track of all locations that have been visited thus far
        self.unseen_location_list = []                      # Keeps track of all locations that have not been visited but have been referenced

    def checkInstruction(self, line: Instruction | Location):

        if isinstance(line, Instruction):
            if self.location_list and line.line_no > self.location_list[0].line_no:
                self.program_cache.append(line)

            line_type = line.type

            if line_type in ['jr', 'ret', 'jal', 'jalr']: # Remove all locations and clear program cache encased between returns
                if self.loop_found: # In case the loop was found, we know for certain it will not checked
                    self.add_vulnerable(self.insecure_cache['Branch_Statement'])

                self.location_list.clear()
                self.program_cache.clear()
                return

            elif line_type == 'j':  # Remove all locations from the jump reference until current line and clear program cache
                if self.loop_found: # In case the loop was found, we know for certain it will not checked
                    self.add_vulnerable(self.insecure_cache['Branch_Statement'])

                arg = line.args[0]
                if isinstance(arg, Label) and arg.label_type == LabelType.LOCATION:
                    matching_location = next((location for location in self.location_list if arg.arg_text[1:] == location.location_name), None)
                    if matching_location is not None:   # True if location found in location list, which means continuity broken
                        self.location_list.clear()
                        self.program_cache.clear()
                        return

                    else:   # Continuity potentially not broken, add to list of unseen locations
                        self.unseen_location_list.append(line)

            if not self.loop_found:
                if line_type in ['beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu', 'bleu']:   # A branch statement, check if loops backward
                    loc_arg = line.args[2]
                    if any(loc_arg.arg_text[1:] == location.location_name for location in self.location_list):

                        # To make sure that the location branched to does not exit the loop at some point
                        matching_location = next((location for location in self.location_list if loc_arg.arg_text[1:] == location.location_name), None)
                        if not any(unseen_location.line_no > matching_location.line_no for unseen_location in self.unseen_location_list):
                            self.insecure_cache['Branch_Statement'] = line
                            self.insecure_cache['Looping_Location'] = matching_location
                            target_vars = [self.insecure_cache['Branch_Statement'].args[0].arg_text, self.insecure_cache['Branch_Statement'].args[1].arg_text]

                            # Next, to check whether an increment statement exists between looping location and branch
                            increment_line = None
                            potential_overwrite = None

                            for cached_line in self.program_cache[::-1]:
                                if cached_line.type == 'call' and 'a0' in target_vars:  # Stop search if a call statement was called and a0 was overwritten
                                    break

                                if cached_line.type in ['mv', 'sext.w'] and cached_line.args[0].arg_text in target_vars:    # If value is moved, keep track of
                                    if not cached_line.args[0].arg_text == cached_line.args[1].arg_text:
                                        potential_overwrite = next((arg for arg in cached_line.args if arg.arg_text in target_vars), None)

                                # To check for andi that truncates the number of 0's in a register
                                if cached_line.type in ['andi'] and cached_line.args[0].arg_text in target_vars and isinstance(cached_line.args[1], IntegerLiteral):
                                    if not re.fullmatch(r'0x[f]+', cached_line.args[1].arg_text):
                                        target_vars.remove(next(target_var for target_var in target_vars if target_var == cached_line.args[0].arg_text))
                                        if not target_vars:
                                            break

                                # To check for which of target variables is being overwritten with an and
                                if cached_line.type in ['and'] and cached_line.args[0].arg_text in target_vars: # Stop search if target variable is overwritten at any point
                                    target_vars.remove(next(target_var for target_var in target_vars if target_var == cached_line.args[0].arg_text))
                                    if not target_vars:
                                        break

                                if (cached_line.type in ['addi', 'addiw'] and
                                        cached_line.args[0].arg_text == cached_line.args[1].arg_text and
                                        cached_line.args[0].arg_text in target_vars and
                                        cached_line.line_no > self.insecure_cache['Looping_Location'].line_no):

                                    # If in case the register being added to will be overwritten at a later instruction, it does not qualify
                                    if potential_overwrite is not None and potential_overwrite.arg_text == cached_line.args[0].arg_text:
                                        break

                                    increment_line = cached_line
                                    break

                            if increment_line is not None:
                                self.insecure_cache['Increment_Statement'] = increment_line

                                # Next, to determine the iterating variable. This can either be a register or a memory address
                                self.insecure_cache['Iterating_Var'] = increment_line.args[0]
                                for cached_line in self.program_cache[increment_line.line_no - self.program_cache[0].line_no:]:
                                    if (cached_line.type == 'sw' and   # If store, record memory address storing to
                                            cached_line.args[0].arg_text == self.insecure_cache['Iterating_Var'].arg_text):
                                        self.insecure_cache['Iterating_Var'] = cached_line.args[1]

                                # Next, to determine number of iterations variable
                                integer_arg = next((arg for arg in self.insecure_cache['Branch_Statement'].args if isinstance(arg, IntegerLiteral)), None)
                                if integer_arg: # If it is an integer, record it
                                    self.insecure_cache['Num_Iterations_Var'] = integer_arg.arg_text
                                    self.loop_found = True

                                else:   # If no integer found, try to find location stored to
                                    for cached_line in self.program_cache[::-1]:
                                        # If we reach the loop branch statement, break
                                        if cached_line.line_no < self.insecure_cache['Looping_Location'].line_no:
                                            break

                                        # Check to see if any of the registers from the branch statement loads from a memory address
                                        if (cached_line.type in ['lw', 'lb'] and cached_line.args[0].arg_text in target_vars and
                                            cached_line.args[1].arg_text != self.insecure_cache['Iterating_Var'].arg_text):
                                            self.insecure_cache['Num_Iterations_Var'] = cached_line.args[1]
                                            self.loop_found = True
                                            break

                                        # In case any of the registers from the branch statement loads from an integer literal
                                        if cached_line.type == 'li' and cached_line.args[0].arg_text in target_vars:
                                            self.insecure_cache['Num_Iterations_Var'] = cached_line.args[1].arg_text
                                            self.loop_found = True
                                            break

                                        # If a register swap happens, keep track of that
                                        if cached_line.type in ['mv', 'sext.w'] and cached_line.args[1].arg_text in target_vars:
                                            target_vars[target_vars.index(cached_line.args[1].arg_text)] = cached_line.args[0].arg_text

                                        # If the iterating variable is found, disregard from target_vars
                                        if (cached_line.type == 'lw' and cached_line.args[0].arg_text in target_vars and
                                                cached_line.args[1].arg_text == self.insecure_cache['Iterating_Var'].arg_text):
                                            target_vars.remove(cached_line.args[0].arg_text)

                                    # Num_Iterations was not assigned and target vars is not empty. Choose register that is not
                                    # common between branch line and increment line
                                    if self.insecure_cache['Num_Iterations_Var'] is None and target_vars:
                                        increment_var = self.insecure_cache['Increment_Statement'].args[0]
                                        num_iterations_var_text = list({increment_var.arg_text} ^ set(target_vars))[0]
                                        num_iterations_var = next((arg for arg in self.insecure_cache['Branch_Statement'].args if arg.arg_text == num_iterations_var_text), None)
                                        self.insecure_cache['Num_Iterations_Var'] = num_iterations_var
                                        self.loop_found = True

                                    elif not target_vars:   # Loop is not a for-loop. Clear detection cache
                                        self.clear_secure_insecure_cache()

                            else:   # Loop is not a for-loop. Clear detection cache
                                self.clear_secure_insecure_cache()

            elif self.loop_found:   # Loop found
                if line.line_no <= self.insecure_cache['Branch_Statement'].line_no + self.check_gap_sensitivity:   # Line within gap sensitivity

                    # First, we look for a branch line
                    if line_type in ['beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu', 'bleu']:

                        # First, check that the branching location has never been seen before
                        loc_arg = line.args[2]
                        if not any(loc_arg.arg_text[1:] == location.location_name for location in self.location_list):

                            # Check if it has an integer literal
                            if isinstance(self.insecure_cache['Num_Iterations_Var'], int):
                                integer_arg = next((arg for arg in line.args if isinstance(arg, IntegerLiteral)), None)
                                if integer_arg and integer_arg.arg_text == self.insecure_cache['Num_Iterations_Var']:
                                    self.secure_cache = {
                                        'Branch_Statement': line,
                                        'Num_Iterations_Var': integer_arg.arg_text
                                    }

                            # Otherwise, search through program cache to see if the same num iterations var is checked
                            for cached_line in self.program_cache[-2::-1]:
                                # If we reach the loop branch statement, break
                                if cached_line.line_no == self.insecure_cache['Branch_Statement'].line_no:
                                    break

                                # If any of the variables of the potentially secure branch line load from an unknown location
                                if (cached_line.type in ['lw']
                                        and not any(arg.arg_text == self.insecure_cache['Num_Iterations_Var'] for arg in cached_line.args)):
                                    line_args = [line.args[0].arg_text, line.args[1].arg_text]
                                    if cached_line.args[0].arg_text in line_args:
                                        self.add_vulnerable(self.insecure_cache['Branch_Statement'])
                                        return

                                # If the Num_Iterations_Var is found, we know we are comparing the right variable
                                if any(arg.arg_text == self.insecure_cache['Num_Iterations_Var'] for arg in cached_line.args):
                                    self.secure_cache['Num_Iterations_Var'] = self.insecure_cache['Num_Iterations_Var']

                            # Since the variable was not found, Check the branch statement itself
                            if self.secure_cache['Num_Iterations_Var'] is None:
                                self.secure_cache['Num_Iterations_Var'] = next((arg.arg_text for arg in line.args if
                                    any(b_arg.arg_text == arg.arg_text for b_arg in self.insecure_cache['Branch_Statement'].args)), None)

                            if self.secure_cache['Num_Iterations_Var'] is None:   # If it is still indeterminate
                                self.add_vulnerable(self.insecure_cache['Branch_Statement'])
                                return

                            self.clear_secure_insecure_cache()

                        else:   # Insecure, since it's also a loop, and recheck current line
                            self.add_vulnerable(self.insecure_cache['Branch_Statement'])
                            self.checkInstruction(line)

                    # The iterating variable has been modified, mark vulnerable
                    elif line.args and self.insecure_cache['Iterating_Var'].arg_text == line.args[0].arg_text:
                        self.add_vulnerable(self.insecure_cache['Branch_Statement'])

                else:   # Loop Check not found, mark vulnerable
                    self.add_vulnerable(self.insecure_cache['Branch_Statement'])

        elif isinstance(line, Location):    # Adding to list of visited locations
            self.location_list.append(line)
            location_name = line.location_name

            # If an unseen location has been seen, remove it from the unseen location list
            unseen_location_seen = next((unseen_location for unseen_location in self.unseen_location_list if location_name == unseen_location.args[0].arg_text[1:]), None)
            if unseen_location_seen is not None:
                self.unseen_location_list.remove(unseen_location_seen)

    def add_vulnerable(self, line: Instruction):
        '''
        Updates list of vulnerabilities with given line
        :param line: Given vulnerable line
        '''
        self.vulnerable_lines.append([self.insecure_cache['Branch_Statement']])
        self.no_vulnerable_lines += 1
        self.no_vulnerable += 1
        self.clear_secure_insecure_cache()

    def clear_secure_insecure_cache(self):
        '''
        Clears detection cache
        '''
        self.insecure_cache = {
            'Branch_Statement': None,
            'Looping_Location': None,
            'Increment_Statement': None,
            'Iterating_Var': None,
            'Num_Iterations_Var': None
        }

        self.secure_cache = {
            'Branch_Statement': None,
            'Num_Iterations_Var': None
        }

        self.loop_found = False