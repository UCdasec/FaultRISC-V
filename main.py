import Parser
from Parser import *
import argparse, os

from detection_patterns import *

def calc_no_vulnerable_lines(*detectors):
    '''
    Calculates the actual number of lines marked vulnerable by at least one detector. Duplicates are not counted
    :param detectors: Each of the detectors included in the calculation
    :return: The number of vulnerable lines, without any duplicates
    '''
    all_vulnerable_lines = []
    for detector in detectors:
        dvulnerable_lines = [dline for dvulnerables in detector.vulnerable_lines for dline in dvulnerables]
        for dline in dvulnerable_lines:
            if isinstance(dline, Instruction) and not any(dline.line_no == vline.line_no for vline in all_vulnerable_lines):
                all_vulnerable_lines.append(dline)

    return len(all_vulnerable_lines)

def analyze_program(program: Program):
    '''
    This function is the main driver of the Fault detection program. For each line in the riscv program, it runs the
    line through each of the different fault pattern detectors. After each line is run through, the result of each
    detector is printed out.

    :param program: the riscv program being fed to analyze
    :return: Nothing
    '''
    Branch_detector = Branch(program.optimization, 4)
    ConstantCoding_detector = ConstantCoding(program.optimization, 4)
    LoopCheck_detector = LoopCheck(program.optimization)
    Bypass_detector = Bypass(program.optimization)

    for line in program.lines:
        if isinstance(line, Instruction):
            Branch_detector.checkInstruction(line)
            ConstantCoding_detector.checkInstruction(line)
            LoopCheck_detector.checkInstruction(line)
            Bypass_detector.checkInstruction(line)

        elif isinstance(line, Attribute):
            ConstantCoding_detector.checkInstruction(line)

        elif isinstance(line, GlobalVariable):
            ConstantCoding_detector.checkInstruction(line)

        elif isinstance(line, Location):
            LoopCheck_detector.checkInstruction(line)


    Branch_detector.printAllVulnerable('Branch')
    ConstantCoding_detector.printAllVulnerable('ConstantCoding')
    LoopCheck_detector.printAllVulnerable('LoopCheck')
    Bypass_detector.printAllVulnerable('Bypass')
    print(f"All vulnerabilities printed.\n")

    total_no_vulnerabilities = sum([
            Branch_detector.no_vulnerable,
            ConstantCoding_detector.no_vulnerable,
            LoopCheck_detector.no_vulnerable,
            Bypass_detector.no_vulnerable
        ])

    total_no_vulnerable_lines = calc_no_vulnerable_lines(Branch_detector, ConstantCoding_detector, LoopCheck_detector, Bypass_detector)

    percentage_vulnerable = (total_no_vulnerable_lines/program.no_lines) * 100

    print('STATISTICS:\n')
    print(f'Total no. of Branch vulnerabilities: {Branch_detector.no_vulnerable}')
    print(f'Total no. of ConstantCoding vulnerabilities: {ConstantCoding_detector.no_vulnerable}')
    print(f'Total no. of LoopCheck vulnerabilities: {LoopCheck_detector.no_vulnerable}')
    print(f'Total no. of Bypass vulnerabilities: {Bypass_detector.no_vulnerable}')
    print(f'Total no. of vulnerabilities: {total_no_vulnerabilities}\n')
    print(f'Total no. of vulnerable lines: {total_no_vulnerable_lines}')
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