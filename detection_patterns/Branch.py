from Pattern import *

class Branch(Pattern):
    def __init__(self, optimization_level: OptimizationLevel):
        self.vulnerable_lines = []
        self.no_vulnerable = 0
        self.optimization_set = optimization_level
    def checkInstruction(self):
        pass

    def printAllVulnerable(self):
        pass