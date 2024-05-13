from abc import ABC, abstractmethod
from typing import List
import sys

sys.path.append('..')
from Parser import Instruction, GlobalVariable, OptimizationLevel

class Pattern(ABC):
    vulnerable_lines: List[Instruction | GlobalVariable]
    no_vulnerable: int
    optimization_set: OptimizationLevel

    @abstractmethod
    def checkInstruction(self):
        pass

    @abstractmethod
    def printAllVulnerable(self):
        pass