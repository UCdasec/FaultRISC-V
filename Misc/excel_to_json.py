import pandas as pd
import json
import argparse

# arg to be used to determine which optimization level the dataset is being compiled for
parser = argparse.ArgumentParser()
parser.add_argument('optimization_level')
parser.add_argument('--no_append', action='store_true', help='Mention to not append to existing ground truth')
args = parser.parse_args()

# dataset to be populated with programs and vulnerabilities
dataset = []

# Dataset pulled from excel labeling
excel_df = pd.read_excel('Dataset_Labeling_RISC-V.xlsx', sheet_name=args.optimization_level)

program = {
    'Program_name': '',
    'Optimization_level': args.optimization_level,
    'Branch': {
        'Vulnerabilities': []
    },
    'Bypass': {
        'Vulnerabilities': []
    },
    'ConstantCoding': {
        'Vulnerabilities': []
    },
    'LoopCheck': {
        'Vulnerabilities': []
    },
}

def get_line_nos(no_range: str):
    '''
    Creates a list of line numbers from a given string range consisting of comma seperated values (csv's) and hyphen
    separated ranges
    :param no_range: the string of numbers
    :return: a list of integer numbers corresponding to the range specified in string
    '''
    if isinstance(no_range, int):   # Also singular line number (when cell only contains singular number)
        return [no_range]

    elif '-' in no_range and not ',' in no_range: # Only a singular range (hyphen)
        start_no = no_range.split('-')[0]
        fin_no = no_range.split('-')[1]
        line_nos = [*range(int(start_no), int(fin_no)+1)]
        return line_nos

    elif ',' in no_range and not '-' in no_range:   # Only csv's
        _line_nos = no_range.split(',')
        line_nos = [int(no) for no in _line_nos]
        return line_nos

    elif '-' in no_range and ',' in no_range:   # Combination of both ranges and csv's
        _line_nos = no_range.split(',')
        line_nos = [line_no for __line_nos in _line_nos for line_no in get_line_nos(__line_nos)]
        return line_nos

    else:   # Just a singular line number (when recursive call gives a single number string)
        return [int(no_range)]


for index, row in excel_df.iterrows():
    if not pd.isna(row.iloc[0]): # if the rightmost column is not empty, we know it's a file name
        if index != 0:  # Only push each time it isn't the first file
            dataset.append(program.copy())
            program = {
                'Program_name': '',
                'Optimization_level': args.optimization_level,
                'Branch': {
                    'Vulnerabilities': []
                },
                'Bypass': {
                    'Vulnerabilities': []
                },
                'ConstantCoding': {
                    'Vulnerabilities': []
                },
                'LoopCheck': {
                    'Vulnerabilities': []
                },
            }

        program['Program_name'] = row.iloc[0]

    if not pd.isna(row.iloc[1]): # Condition to make sure this isn't an empty divider row
        vulnerability = {
            'Line_nos': get_line_nos(row.iloc[1]),
            'Lines': row.iloc[2].split('\n')
        }
        if row.iloc[3] == 1:
            program['Branch']['Vulnerabilities'].append(vulnerability.copy())

        elif row.iloc[4] == 1:
            program['ConstantCoding']['Vulnerabilities'].append(vulnerability.copy())

        elif row.iloc[5] == 1:
            program['LoopCheck']['Vulnerabilities'].append(vulnerability.copy())

        elif row.iloc[6] == 1:
            program['Bypass']['Vulnerabilities'].append(vulnerability.copy())

dataset.append(program) # Append last program

if not args.no_append:
    with open('../Results/ground_truth.json', 'r') as f:
        og_dataset = json.load(f)

    og_dataset.extend(dataset)

    with open('../Results/ground_truth.json', 'w') as f:
        json.dump(og_dataset, f, indent=4)

else:
    og_dataset = dataset
    with open('../Results/_ground_truth.json', 'w') as f:
        json.dump(og_dataset, f, indent=4)