import re
from typing import List

class Argument:
    def __init__(self, arg_text):
        self.arg_text = arg_text    # The text of the argument

class Register(Argument):
    def __init__(self, arg_text):
        super().__init__(arg_text)

class IntegerLiteral(Argument):
    def __init__(self, arg_text):
        super().__init__(arg_text)
        if arg_text == 'zero':
            self.arg_value = 0
        else:
            self.arg_value = int(self.arg_text)

class StringLiteral(Argument):
    def __init__(self, arg_text):
        super().__init__(arg_text)

class MemoryAddress(Argument):
    def __init__(self, arg_text):
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
        Removes the suffixed : from the function line to leave the function name
        '''
        self.function_name = self.line_text[:-1]

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
                    self.args.append(raw_args_text.split(',',1)[0])
                    raw_args_text = raw_args_text.split(',', 1)[1].strip()
                else:
                    break

class Instruction(Line):
    def __init__(self, line_no=None, line_text=None):
        super().__init__(line_no, line_text)
        self.type: str  # The name of the instruction type
        self.args: List[IntegerLiteral | StringLiteral | Location | Function] = []  # A list of the arguments of the instruction

    def parse_attributes(self):
        '''
        First, we get the extract the instruction type which is the first word in the string
        Next, we proceed to making a list of all the different arguments of the line which are trailing words separated
        by commas. Remove all args starting with a '@' as these are comments
        '''
        self.type = self.line_text.partition(' ')[0][1:]
        raw_args_text = self.line_text.partition(' ')[1].strip()
        self.args = raw_args_text.split(',')
        self.args = [arg for arg in self.args if arg.strip()[0] != '@']

class Program:
    def __init__(self):
        self.no_lines: int
        self.lines: List[Location | Instruction | MemoryAddress | Function | Attribute] = []


