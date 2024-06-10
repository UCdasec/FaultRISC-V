from abc import ABC, abstractmethod
from typing import List, Optional
import sys

sys.path.append('..')
from Parser import *

class Pattern(ABC):
    vulnerable_lines: List[List[Instruction | GlobalVariable | Attribute | str]]
    no_vulnerable: int
    no_vulnerable_lines: int
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
                    if line not in ['__IGNORE_LINE__', '__SECURE__', '__OPTIONAL__']:
                        print(f"{line.line_no}\t\t\t{line.line_text}")
                print('')

def calculate_hamming(x: int, y: int = 0):
    '''
    Calculates the hamming distance between integers x and y in their binary form.
    :param x: First integer
    :param y: second integer, default is 0
    :return: hamming weight, an integer
    '''
    x_bin = bin(x)[bin(x).find('b') + 1:]
    y_bin = bin(y)[bin(y).find('b') + 1:]

    x_bin = x_bin.zfill(max(len(x_bin), len(y_bin)))
    y_bin = y_bin.zfill(max(len(x_bin), len(y_bin)))

    hamming_weight = sum(bit_x != bit_y for bit_x, bit_y in zip(x_bin, y_bin))
    return hamming_weight

def is_bit_maximum(x: int):
    '''
    Checks if the number is at any of the RISC-V bit maximums (largest 8-bit, 16-bit, 32-bit, 64-bit, or 128-bit). These
    are all the variable sizes defined in RISC-V
    :param x: the integer value checked to see if it is at the bit maximum
    :return: True if it is at a bit maximum else False
    '''
    for no_bits in [8, 16, 32, 64]:
        if x == pow(2, no_bits) - 1:
            return True

    return False