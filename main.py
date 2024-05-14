import Parser
from Parser import *
import argparse, os

from detection_patterns import Branch

def analyze_program(program: Program):
    '''
    This function is the main driver of the Fault detection program. For each line in the riscv program, it runs the
    line through each of the different fault pattern detectors. After each line is run through, the result of each
    detector is printed out.

    :param program: the riscv program being fed to analyze
    :return: Nothing
    '''
    branch_detector = Branch(program.optimization, 4)

    for line in program.lines:
        branch_detector.checkInstruction(line)

    branch_detector.printAllVulnerable()

if __name__ == "__main__":
    program_arg_parser = argparse.ArgumentParser()
    program_arg_parser.add_argument("target_file", help="Target RISC-V Assembly file to run vulnerability assessment on")
    program_args = program_arg_parser.parse_args()

    riscv_program: Program
    with open(program_args.target_file, 'r') as asm_file:
        riscv_program = Program(os.path.basename(program_args.target_file), asm_file.readlines())

    print(f"Parsing program {os.path.basename(program_args.target_file)}...")
    riscv_program.parse_program()
    print(f"Parsing complete!")

    print(f"Analyzing program {os.path.basename(program_args.target_file)}...")
    analyze_program(riscv_program)
    print(f"All vulnerabilities printed!")

