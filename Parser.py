import re, enum
from typing import List

def is_integer(candidate):
    '''
    Helper function to determine if a string can be an integer
    :param candidate: the string candidate to become an integer
    :return: true if error is not raised during  conversion else false
    '''
    try:
        int(candidate)
        return True
    except ValueError:
        return False
class Argument:
    def __init__(self, arg_text: str):
        self.arg_text = arg_text    # The text of the argument

class Register(Argument):

    register_pattern = r'(ra|sp|gp|tp|fp|t[0-6]|s(1[0-1]|[0-9])|a[0-7]|f[st]([0-9]|1[0-1])|fa[0-7])'
    def __init__(self, arg_text: str):
        super().__init__(arg_text)

class IntegerLiteral(Argument):
    def __init__(self, arg_text: str):
        super().__init__(arg_text)
        if arg_text == 'zero':
            self.arg_value = 0
        else:
            self.arg_value = int(self.arg_text)

class StringLiteral(Argument):
    def __init__(self, arg_text: str):
        super().__init__(arg_text)

class MemoryAddress(Argument):
    def __init__(self, arg_text: str):
        super().__init__(arg_text)
        self.reference: Register | Location # The location or register w.r.t which the the memory address is calculated
        self.offset: str | int  # the offset; int if pulling from stack, str if pulling from data segment.

    def resolve_offset_and_reference(self):
        '''
        We use the regex pattern that detects `offset(reference)`. Then, we determine whether the reference is
        to a location or to register. Similarly, we do the same for offset type as either integer or string.
        '''
        ref_offset_pattern = r'^(.*?)\((.*?)\)$'
        ref_offset_match = re.match(ref_offset_pattern, self.arg_text)

        raw_reference = ref_offset_match.group(2)
        raw_offset = ref_offset_match.group(1)

        self.reference = Location(raw_reference) if raw_reference.startswith('.') else Register(raw_reference)
        self.offset = str(raw_offset) if raw_offset.startswith('%') else int(raw_offset)

class Line:
    def __init__(self, line_no=None, line_text=None):
        self.line_no = line_no      # The line number of the line in question
        self.line_text = line_text  # The raw string of the line in question.

class Location(Line):
    def __init__(self, line_no=None, line_text=None):
        super().__init__(line_no, line_text)
        self.location_name: str # The name of the location

    def resolve_location_name(self):
        '''
        Removes the prefixed . and the suffixed : from the location line to leave the location name
        '''
        self.location_name = self.line_text[1:-1]

class Function(Line):
    def __init__(self, line_no=None, line_text=None):
        super().__init__(line_no, line_text)
        self.function_name: str # The name of the function

    def resolve_function_name(self):
        '''
        Removes the suffixed : if it exists from the function line to leave the function name
        '''
        self.function_name = self.line_text[:-1]

class VariableType(enum.Enum):
    INTEGER = 1
    STRING = 2

class GlobalVariable(Line):
    def __init__(self, line_no=None, line_text=None, variable_type=None):
        super().__init__(line_no, line_text)
        self.variable_name: str                         # The name of the variable
        self.variable_type = variable_type              # The data type of the variable
        self.variable_values: List[IntegerLiteral] = [] # The list of integer values associated with the variable

    def resolve_var_name(self):
        '''
        Gets the name of the global variable, assigns it a type, and if the type is either int/float or its array, assign
        the variable value.
        '''
        self.variable_name = self.line_text[:-1]

    def resolve_var_value(self, var_line: str):
        '''
        Updates the list of variable values for the global variable after parsing var_line
        :param var_line: The attribute line with the variable value associated with the global variable
        '''
        self.variable_values.append(IntegerLiteral(var_line.split()[1]))

class Attribute(Line):
    def __init__(self, line_no=None, line_text=None):
        super().__init__(line_no, line_text)
        self.type: str  # The name of the attribute type of a line
        self.args: List[StringLiteral | IntegerLiteral | Argument] = []  # The list of arguments of the line

    def parse_attributes(self):
        '''
        First, we get the extract the attribute type in the form .type
        Next, we proceed to making a list of all the different arguments of the line.

        Note that for arguments that are quotations (i.e., strings), a regex pattern is devised as a simple split
        will not be sufficient.
        '''
        self.type = self.line_text.partition(' ')[0][1:]
        raw_args_text = self.line_text.partition(' ')[1]
        quotation_pattern = r'"(.*?)"'

        '''
        We remove each argument from the raw text one-by-one left-to-right. If it is a quotation, we use the aforementioned
        regex pattern or else we use a split along ','. We do this until the raw text is empty. If the arg starts with @
        then it's a comment and we break the loop
        '''
        while raw_args_text != '':
            # Quotation arguments
            if raw_args_text[0] == '"':
                self.args.append(re.search(quotation_pattern, raw_args_text).group(1))
                raw_args_text = re.sub(quotation_pattern, '', raw_args_text)
            # Other type of arguments
            else:
                raw_arg = raw_args_text.split(',',1)[0].strip()
                if not raw_arg.startswith('@'):
                    if is_integer(raw_arg):
                        self.args.append(IntegerLiteral(raw_arg))
                    else:
                        self.args.append(Argument(raw_arg))
                    raw_args_text = raw_args_text.split(',', 1)[1].strip()
                else:
                    break


class Instruction(Line):
    def __init__(self, line_no=None, line_text=None):
        super().__init__(line_no, line_text)
        self.type: str  # The name of the instruction type
        self.args: List[IntegerLiteral | MemoryAddress | Register | Attribute] = []  # A list of the arguments of the instruction

    def parse_arguments(self):
        '''
        First, we get the extract the instruction type which is the first word in the string
        Next, we proceed to making a list of all the different arguments of the line which are trailing words separated
        by commas. Remove all args starting with a '@' as these are comments
        '''
        self.type = self.line_text.partition(' ')[0][1:]
        raw_args_text = self.line_text.partition(' ')[1].strip()
        raw_args_list = [arg.strip() for arg in raw_args_text.split(',') if arg.strip()[0] != '@']

        '''
        For each of the args in the raw_args_list, it is determined whether each is an Integer, Memory Address, Register
        or a general Attribute. Attribute is by default (this will be functions and program locations). The rest are
        determined as follows: IntegerLiteral if the string can be converted to an Integer, MemoryAddress if the string
        matches the regex pattern for a reference and an offset, and Register if it matches any of the sanctioned ABI
        register nomenclature for Risc-V.
        '''
        ref_offset_pattern = r'^(.*?)\((.*?)\)$'
        register_pattern = r'(ra|sp|gp|tp|fp|t[0-6]|s(1[0-1]|[0-9])|a[0-7]|f[st]([0-9]|1[0-1])|fa[0-7])'
        for arg in raw_args_list:
            if is_integer(arg):                     # IntegerLiteral
                self.args.append(IntegerLiteral(arg))

            elif re.match(ref_offset_pattern, arg): # MemoryAddress
                self.args.append(MemoryAddress(arg))
                self.args[-1].resolve_offset_and_reference()

            elif re.match(register_pattern, arg):   # Register
                self.args.append(Register(arg))

            else:                                   # Default: Function or Location
                self.args.append(Attribute(arg))

class Program:
    def __init__(self, raw_lines: List):
        self.no_lines = len(raw_lines)
        self.raw_lines = raw_lines
        self.lines: List[Location | Instruction | Function | GlobalVariable | Attribute] = []

    def parse_program(self):
        '''
        This function serves as the algorithm by which we parse and tokenize the raw lines into parsed lines with
        tokens that should in theory give the program some meaning useful to vulnerability detection.

        Location is determined by if the line starts with a . and ends with a :

        Function and GlobalVariable (INTEGER or STRING) are determined by if the line ends with a : but does not start
        with a .
            GlobalVariable of type INTEGER is determined by if the line is followed by 1 or more .word lines. Each
            .word line's value is added to the list of the global variable's value
            GlobalVariable of type STRING is determined by if the line is followed by at least 1 .dword line. The string's
            value is not added to the list of values.
            Function is determined if none of the above match after looking the first line after the current line.

        Attribute is determined if the line starts with a . but does not end with a :

        If none of the above match, it is determined that the line is an Instruction (default)
        '''
        for line_no, line in enumerate(self.raw_lines, start=1):
            line = line.strip()
            if line.startswith('.') and line.endswith(':'):             # Location
                self.lines.append(Location(line_no, line))
                self.lines[-1].resolve_location_name()
            elif not line.startswith('.') and line.endswith(':'):       # Function or GlobalVariable
                for word_count, next_line in enumerate(self.raw_lines[line_no:]):
                    if next_line.strip().startswith('.word'):
                        if word_count == 0:                             # GlobalVariable of type INTEGER
                            self.lines.append(GlobalVariable(line_no, line, VariableType.INTEGER))
                            self.lines[-1].resolve_var_name()
                            self.lines[-1].resolve_var_value(next_line.strip())

                        else:
                            self.lines[-1].resolve_var_value(next_line.strip())

                    elif next_line.strip().startswith('.dword'):        # GlobalVariable of type STRING
                        self.lines.append(GlobalVariable(line_no, line, VariableType.STRING))
                        self.lines[-1].resolve_var_name()
                        break

                    else:
                        if word_count == 0:
                            self.lines.append(Function(line_no, line))  # Function
                            self.lines[-1].resolve_function_name()
                        break

            elif line.startswith('.') and not line.endswith(':'):   # Attribute
                self.lines.append(Attribute(line_no, line))
                self.lines[-1].parse_attributes()
            else:                                                   # Instruction
                self.lines.append(Instruction(line_no, line))
                self.lines[-1].parse_arguments()


