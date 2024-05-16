import Parser
from Parser import *
import argparse, os

from detection_patterns import *

def analyze_program(program: Program):
    '''
    This function is the main driver of the Fault detection program. For each line in the riscv program, it runs the
    line through each of the different fault pattern detectors. After each line is run through, the result of each
    detector is printed out.

    :param program: the riscv program being fed to analyze
    :return: Nothing
    '''
    branch_detector = Branch(program.optimization, 4)
    constantCoding_detector = ConstantCoding(program.optimization, 4)

    for line in program.lines:
        if isinstance(line, Instruction):
            branch_detector.checkInstruction(line)
            constantCoding_detector.checkInstruction(line)

        elif isinstance(line, Attribute):
            constantCoding_detector.checkInstruction(line)

        elif isinstance(line, GlobalVariable):
            constantCoding_detector.checkInstruction(line)


    branch_detector.printAllVulnerable('Branch')
    constantCoding_detector.printAllVulnerable('ConstantCoding')
    print(f"All vulnerabilities printed!\n")

    total_no_vulnerabilities = sum([branch_detector.no_vulnerable, constantCoding_detector.no_vulnerable])
    percentage_vulnerable = (total_no_vulnerabilities/program.no_lines) * 100

    print('STATISTICS:\n')
    print(f'Total no. of Branch vulnerabilities: {branch_detector.no_vulnerable}')
    print(f'Total no. of ConstantCoding vulnerabilities: {constantCoding_detector.no_vulnerable}\n')
    print(f'Total no. of vulnerabilities: {total_no_vulnerabilities}')
    print(f'Total no. of lines: {program.no_lines}')
    print(f'Percentage of lines vulnerable: {percentage_vulnerable:.2f}%\n')

if __name__ == "__main__":
    program_arg_parser = argparse.ArgumentParser()
    program_arg_parser.add_argument("target_file", help="Target RISC-V Assembly file to run vulnerability assessment on")
    program_args = program_arg_parser.parse_args()

    riscv_program: Program
    with open(program_args.target_file, 'r') as asm_file:
        riscv_program = Program(os.path.basename(program_args.target_file), asm_file.readlines())

    program_name = os.path.basename(program_args.target_file)
    containing_folder = os.path.basename(os.path.dirname(program_args.target_file))
    print(f"Parsing program {containing_folder}/{program_name}...")
    riscv_program.parse_program()
    print(f"Parsing complete!")

    print(f"Analyzing program {containing_folder}/{program_name}...\n")
    analyze_program(riscv_program)