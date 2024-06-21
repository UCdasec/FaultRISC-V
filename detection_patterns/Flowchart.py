from enum import Enum
from typing import List

class FlowchartError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)

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
    def __init__(self, location : str, node_type : NodeType, children : List[str], convergence = False):
        self.location_name = location
        self.type = node_type
        self.convergence_point = convergence
        self.lines : List[Line] = []
        self.children = children #for branch: 0 is the true child, 1 is the false child
        
    def __str__(self):
        result = f"{self.location_name}\n"
        for line in self.lines:
            result += f"\t{line}\n" 
        for child in self.children:
            result += f"\t-{child}\n" 
        return result
        
    def addLine(self, line_no, line):
        self.line_nos.append(line_no)
        self.lines.append(line)

class Flowchart():
    def __init__(self, head_node = None):
        '''
        This class is used to build a flowchart containing nodes that are either branches or locations.
        It functions like a linked graph, but the underlying data structure is a dictionary with keys that
        are the names of locations and values that are the nodes at that location. It is implemented this way 
        so that you can have a node's child be the name of a location that has yet to be added.
        '''
        self.head = head_node
        self.locations = {}
    
    def addNode(self, new_node: FlowchartNode):
        if new_node.location_name in self.locations.keys():
            raise FlowchartError("That location has already been created!")
        self.locations[new_node.location_name] = new_node

    def analyze(self):
        pass
    
    def isEmpty(self):
        return self.head_node != None