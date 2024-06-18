from .Pattern import *
from .Vulnerable_Instruction_list import vulnerable_instruction_list
from enum import Enum

class DefaultFail(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines: List = []                                # All the vulnerabilities found for LoopCheck
        self.no_vulnerable = 0                                          # No. of vulnerabilities
        self.no_vulnerable_lines = 0                                    # No. of lines of code covered by the vulnerabilities found
        self.optimization_set = optimization_level                      # the optimization level of the risc-v program
        self.vulnerable_instruction_set = (
            vulnerable_instruction_list)['DefaultFail'][optimization_level]  # The vulnerable pattern set to look for
        


        self.detection_cache = []           # Stores the set of instructions that are currently being inspected for LoopCheck vulnerability.
        self.secure_cache = []              # Stores the expected secure pattern to follow the vulnerable pattern recorded in detection_cache
        self.vulnerable_pattern = []        # The specific vulnerable pattern that is being checked
        self.pattern_undetermined = True    # Flag for if the pattern has not yet been determined
        self.insecure_match = False         # If the first half of the pattern, i.e., the insecure first half is complete
        
        self.completed_flowcharts = []
        self.current_flowchart = Flowchart()
        self.function_name = ""
        self.function_line_number = 0

    def checkInstruction(self, line: Instruction):
        '''
        at the beginning of a function, start a new flowchart
        check if each line is part of a branch pattern
        -if yes, add to branch cache
        -if no, add branch cache and current line to line cache
        '''
        pass
    
    def addFunction(self, line : Function):
        if not self.current_flowchart.isEmpty():
            self.completed_flowcharts.append(self.current_flowchart)
        self.current_flowchart = Flowchart()
        self.function_name = line.function_name
        self.function_line_number = 1
        
    def addLocation(self, line : Location):
        pass

class Flowchart():
    def __init__(self, head_node = None):
        self.head = head_node
    
    def analyze(self):
        pass
    
    def isEmpty(self):
        return self.head_node != None
    
class NodeType(Enum):
    LOCATION = 1
    BRANCH = 2

class FlowchartNode():
    '''
    A node in the flowchart
    Can be either a branch or a location
    Do these need to be seperate classes or will an enum designator work?
    Decide based on how similarly they function
    '''
    def __init__(self, location, node_type, convergence = False):
        self.location_name = location
        self.type = node_type
        self.convergence_point = convergence
        self.line_nos = []
        self.lines = []
        self.children = []
        
    def addLine(self, line_no, line):
        self.line_nos.append(line_no)
        self.lines.append(line)