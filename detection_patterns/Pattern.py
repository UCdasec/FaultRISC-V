from abc import ABC, abstractmethod
from typing import List
import sys

sys.path.append('..')
from Parser import Instruction, GlobalVariable, OptimizationLevel, IntegerLiteral, Register, Attribute

class Pattern(ABC):
    vulnerable_lines: List[List[Instruction | GlobalVariable | Attribute | str]]
    no_vulnerable: int
    optimization_set: OptimizationLevel

    @abstractmethod
    def checkInstruction(self, line: Instruction):
        pass

    def printAllVulnerable(self, vulnerability_type: str):
        print(f"Vulnerabilities for {vulnerability_type}: \n")

        if len(self.vulnerable_lines) == 0:
            print(f"No vulnerabilities for {vulnerability_type}!\n")

        else:
            print("Line no.\tVulnerable Line\n")
            for line_set in self.vulnerable_lines:
                for line in line_set:
                    if line != '__IGNORE_LINE__':
                        print(f"{line.line_no}\t{line.line_text}")
                print('')

def calculate_hamming(x: int, y: int = 0):
    '''
    Calculates the hamming distance between integers x and y in their binary form.
    :param x: First integer
    :param y: second integer, default is 0
    :return: hamming weight, an integer
    '''
    x_bin = bin(x)[2:]
    y_bin = bin(y)[2:]

    x_bin = x_bin.zfill(max(len(x_bin), len(y_bin)))
    y_bin = y_bin.zfill(max(len(x_bin), len(y_bin)))

    hamming_weight = sum(bit_x != bit_y for bit_x, bit_y in zip(x_bin, y_bin))
    return hamming_weight