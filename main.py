from Parser import *
import argparse

if __name__ == "__main__":
    program_arg_parser = argparse.ArgumentParser()
    program_arg_parser.add_argument("target_file", help="Target RISC-V Assembly file to run vulnerability assessment on")
    program_args = program_arg_parser.parse_args()

    with open(program_args.target_file, 'r') as asm_file:
        riscv_program = Program(asm_file.readlines())