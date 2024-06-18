import glob, os, json, copy

# Template for entire analysis report
analysis = {
    'Total_no_lines': 0,
    'Total_no_vulnerable_lines': 0,
    'Total_no_vulnerabilities': 0,
    'Total_no_TP': 0,
    'Total_no_FP': 0,
    'Total_no_FN': 0,
    'Precision': 0.0,
    'Recall': 0.0,
    'F-1_score': 0.0,
    'Branch': {
        'Total_no_lines': 0,
        'Total_no_vulnerable_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'Bypass': {
        'Total_no_lines': 0,
        'Total_no_vulnerable_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'ConstantCoding': {
        'Total_no_lines': 0,
        'Total_no_vulnerable_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'LoopCheck': {
        'Total_no_lines': 0,
        'Total_no_vulnerable_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'files': []
}

# Template for specific asm file
file_analysis = {
    'Program_name': None,
    'Optimization_level': None,
    'No_lines': 0,
    'No_vulnerable_lines': 0,
    'No_vulnerabilities': 0,
    'No_TP': 0,
    'No_FP': 0,
    'No_FN': 0,
    'Precision': 0.0,
    'Recall': 0.0,
    'F-1_score': 0.0,
    'Branch': {
        'No_lines': 0,
        'No_vulnerabilities': 0,
        'No_TP': 0,
        'No_FP': 0,
        'No_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0,
        'True_positives': [],
        'False_positives': [],
        'False_negatives': []
    },
    'Bypass': {
        'No_lines': 0,
        'No_vulnerabilities': 0,
        'No_TP': 0,
        'No_FP': 0,
        'No_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0,
        'True_positives': [],
        'False_positives': [],
        'False_negatives': []
    },
    'ConstantCoding': {
        'No_lines': 0,
        'No_vulnerabilities': 0,
        'No_TP': 0,
        'No_FP': 0,
        'No_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0,
        'True_positives': [],
        'False_positives': [],
        'False_negatives': []
    },
    'LoopCheck': {
        'No_lines': 0,
        'No_vulnerabilities': 0,
        'No_TP': 0,
        'No_FP': 0,
        'No_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0,
        'True_positives': [],
        'False_positives': [],
        'False_negatives': []
    }
}

def match_fault(fault_lines, ground_truth_lines):
    '''
    This function determines if the two faults being compared (former from the report of the assembly file and the latter
    from the ground truth of the dataset) match perfectly, imperfectly, or not at all
    :param fault: The fault from the report
    :param ground_truth: The ground truth fault being compared against
    :return: Tuple of a pair boolean values. The former is whether the fault matches, the latter is whether the
    fault matches all lines)
    '''
    fault_set = set(fault_lines)
    ground_truth_set = set(ground_truth_lines)

    # line numbers match perfectly
    if fault_set == ground_truth_set:
        return (True, True)
    # Some line numbers match (imperfect)
    elif fault_set & ground_truth_set:
        return (True, False)
    # No line numbers match (False positive)
    else:
        return (False, False)

# locate latest report
latest_report_file = max(glob.glob(os.path.join('Results/Reports', '*.json')), key=os.path.getctime)

# report_data has results from FaultHunter run
with open(latest_report_file, 'r') as report_file:
    report_data = json.load(report_file)

# dataset holds ground truth
with open ('Results/dataset.json', 'r') as dataset_file:
    dataset = json.load(dataset_file)

for asm_file in report_data:
    # Make an instance of the file_analysis dictionary to be populated with the analysis of the report
    cur_file_analysis = copy.deepcopy(file_analysis)
    cur_file_analysis['Program_name'] = asm_file['Program_name']
    cur_file_analysis['Optimization_level'] = asm_file['Optimization_level']
    cur_file_analysis['No_lines'] = asm_file['No_lines']
    cur_file_analysis['No_vulnerable_lines'] = asm_file['No_vulnerable_lines']
    cur_file_analysis['No_vulnerabilities'] = asm_file['No_vulnerabilities']

    cur_file_analysis['Branch']['No_lines'] = asm_file['Branch']['No_lines']
    cur_file_analysis['Branch']['No_vulnerabilities'] = asm_file['Branch']['No_vulnerabilities']

    cur_file_analysis['Bypass']['No_lines'] = asm_file['Bypass']['No_lines']
    cur_file_analysis['Bypass']['No_vulnerabilities'] = asm_file['Bypass']['No_vulnerabilities']

    cur_file_analysis['ConstantCoding']['No_lines'] = asm_file['ConstantCoding']['No_lines']
    cur_file_analysis['ConstantCoding']['No_vulnerabilities'] = asm_file['ConstantCoding']['No_vulnerabilities']

    cur_file_analysis['LoopCheck']['No_lines'] = asm_file['LoopCheck']['No_lines']
    cur_file_analysis['LoopCheck']['No_vulnerabilities'] = asm_file['LoopCheck']['No_vulnerabilities']

    # to locate the asm_file from run in dataset
    dataset_file = next((file for file in dataset if file['Program_name'] == asm_file['Program_name']
                         and file['Optimization_level'] == asm_file['Optimization_level']), None)

    # Evaluating TP and FP for pattern
    pattern_groundtruth_iter = iter(dataset_file['Branch']['Vulnerabilities'])
    for fault in asm_file['Branch']['Vulnerabilities']:
        ground_truth = next(pattern_groundtruth_iter)
        fault_match = match_fault(fault['Line_nos'], ground_truth['Line_nos'])
        # Case TP
        if fault_match == (True, True) or fault_match == (True, False):
            cur_file_analysis['No_TP'] += 1
            cur_file_analysis['Branch']['No_TP'] += 1
            cur_file_analysis['Branch']['True_positives'].append(fault)
            dataset_file['Branch']['Vulnerabilities'].remove(dataset_file['Branch']['Vulnerabilities'][0])
        # Case FP
        elif fault_match == (False, False):
            cur_file_analysis['No_FP'] += 1
            cur_file_analysis['Branch']['No_FP'] += 1
            cur_file_analysis['Branch']['False_positives'].append(fault)

    # Evaluating FN for pattern
    for FN_fault in dataset_file['Branch']['Vulnerabilities']:
        cur


    # Evaluating TP, FP, and FN for Bypass
    for fault in asm_file['Bypass']['Vulnerabilities']:
        pass

    # Evaluating TP, FP, and FN for ConstantCoding
    for fault in asm_file['ConstantCoding']['Vulnerabilities']:
        pass

    # Evaluating TP, FP, and FN for LoopCheck
    for fault in asm_file['LoopCheck']['Vulnerabilities']:
        pass

