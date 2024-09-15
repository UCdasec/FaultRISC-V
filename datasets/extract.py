import re
import csv
import argparse
import os

# Function to check if line is a branch
def branch_match(line):
    return re.match(r'\t\bb', line)

# Function to check if line is a constant variable
def constant_match(line):
    pattern = r'^\t\.(word|byte|short|2byte|4byte|8byte|long|sleb128|uleb128|half)'
    return re.match(pattern, line)

# Input and output file paths
arg_parser = argparse.ArgumentParser()
arg_parser.add_argument('assembly_file', help='assembly file to extract lines from')
arg_parser.add_argument('line_type', help='Type of line to extract', choices=['branch', 'constant'], default=None)

program_args = arg_parser.parse_args()
input_file = program_args.assembly_file
input_file_name = os.path.basename(program_args.assembly_file)

# Read lines from input file and store matching lines
lines_to_store = []
with open(input_file, 'r') as f:
    for i, line in enumerate(f, start=1):
        if program_args.line_type == 'branch' and branch_match(line):
            lines_to_store.append((i, line.strip()))

        elif program_args.line_type == 'constant' and constant_match(line):
            lines_to_store.append((i, line.strip()))

# Write matching lines to CSV file
output_file = os.path.join('./extracted_lines', f'{input_file_name}_{program_args.line_type}.csv')
with open(output_file, 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerows(lines_to_store)