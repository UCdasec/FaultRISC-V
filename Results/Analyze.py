import glob, os, json, copy

# TP = True Positives
# FP = False Positives
# FN = False Negatives

# Template for entire analysis report
analysis = {
    'Total_no_lines': 0,
    'Ground_truth': {
        'Total_no_vulnerable_lines': 0,
        'Total_no_vulnerabilities': 0
    },
    'Total_no_vulnerable_lines': 0,
    'Total_no_vulnerabilities': 0,
    'Total_no_TP': 0,
    'Total_no_FP': 0,
    'Total_no_FN': 0,
    'Precision': 0.0,
    'Recall': 0.0,
    'F-1_score': 0.0,
    'Branch': {
        'Ground_truth': {
            'Total_no_lines': 0,
            'Total_no_vulnerabilities': 0
        },
        'Total_no_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'Bypass': {
        'Ground_truth': {
            'Total_no_lines': 0,
            'Total_no_vulnerabilities': 0
        },
        'Total_no_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'ConstantCoding': {
        'Ground_truth': {
            'Total_no_lines': 0,
            'Total_no_vulnerabilities': 0
        },
        'Total_no_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'LoopCheck': {
        'Ground_truth': {
            'Total_no_lines': 0,
            'Total_no_vulnerabilities': 0
        },
        'Total_no_lines': 0,
        'Total_no_vulnerabilities': 0,
        'Total_no_TP': 0,
        'Total_no_FP': 0,
        'Total_no_FN': 0,
        'Precision': 0.0,
        'Recall': 0.0,
        'F-1_score': 0.0
    },
    'Files': []
}

# Template for specific asm file
file_analysis = {
    'Program_name': None,
    'Optimization_level': None,
    'No_lines': 0,
    'Ground_truth': {
        'No_vulnerable_lines': 0,
        'No_vulnerabilities': 0
    },
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
        'Ground_truth': {
            'No_vulnerable_lines': 0,
            'No_vulnerabilities': 0
        },
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
        'Ground_truth': {
            'No_vulnerable_lines': 0,
            'No_vulnerabilities': 0
        },
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
        'Ground_truth': {
            'No_vulnerable_lines': 0,
            'No_vulnerabilities': 0
        },
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
        'Ground_truth': {
            'No_vulnerable_lines': 0,
            'No_vulnerabilities': 0
        },
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

    # line numbers match perfectly or imperfectly
    if fault_set == ground_truth_set or fault_set & ground_truth_set:
        return True
    # line numbers do not match at all
    else:
        return False

def analyze_pattern(pattern: str):
    '''
    Updates the tally for True Positive, False Positive and False Negative for given pattern
    :param pattern: The fault pattern being assessed
    :return: N/A
    '''
    # Evaluating TP and FP for pattern
    for fault in asm_file[pattern]['Vulnerabilities']:
        # Identifying if any of the ground truth match current vulnerability
        fault_match = False
        matched_ground_truth = None
        for ground_truth in dataset_file[pattern]['Vulnerabilities']:
            if match_fault(fault['Line_nos'], ground_truth['Line_nos']):
                fault_match = True
                matched_ground_truth = ground_truth
                break
        # Case TP
        if fault_match:
            cur_file_analysis['No_TP'] += 1
            cur_file_analysis[pattern]['No_TP'] += 1
            cur_file_analysis[pattern]['True_positives'].append(fault)
            dataset_file[pattern]['Vulnerabilities'].remove(matched_ground_truth)
        # Case FP
        else:
            cur_file_analysis['No_FP'] += 1
            cur_file_analysis[pattern]['No_FP'] += 1
            cur_file_analysis[pattern]['False_positives'].append(fault)

    # The remaining vulnerabilities in ground truth are FN
    cur_file_analysis['No_FN'] += len(dataset_file[pattern]['Vulnerabilities'])
    cur_file_analysis[pattern]['No_FN'] += len(dataset_file[pattern]['Vulnerabilities'])
    cur_file_analysis[pattern]['False_negatives'] = copy.deepcopy(dataset_file[pattern]['Vulnerabilities'])

    # Updating the overall analysis
    analysis['Total_no_TP'] += cur_file_analysis[pattern]['No_TP']
    analysis['Total_no_FP'] += cur_file_analysis[pattern]['No_FP']
    analysis['Total_no_FN'] += cur_file_analysis[pattern]['No_FN']

    analysis[pattern]['Total_no_TP'] += cur_file_analysis[pattern]['No_TP']
    analysis[pattern]['Total_no_FP'] += cur_file_analysis[pattern]['No_FP']
    analysis[pattern]['Total_no_FN'] += cur_file_analysis[pattern]['No_FN']

def update_analyses(asm_file):
    '''
    Updates broader details of the program analysis and the overall analysis
    :param asm_file: The current assembly file report being analyzed
    :return: N/A
    '''
    # Updating current file analysis
    cur_file_analysis['Program_name'] = asm_file['Program_name']
    cur_file_analysis['Optimization_level'] = asm_file['Optimization_level']
    cur_file_analysis['No_lines'] = asm_file['No_lines']

    No_vulnerabilities = (len(dataset_file['Branch']['Vulnerabilities']) + len(dataset_file['Bypass']['Vulnerabilities'])
                          + len(dataset_file['ConstantCoding']['Vulnerabilities'])) + len(dataset_file['LoopCheck']['Vulnerabilities'])

    No_vulnerable_lines = len(set([line_no for pattern in [dataset_file['Branch'], dataset_file['Bypass'], dataset_file['ConstantCoding'], dataset_file['LoopCheck']]
                                   for vulnerability in pattern['Vulnerabilities'] for line_no in vulnerability['Line_nos']]))

    cur_file_analysis['Ground_truth']['No_vulnerable_lines'] = No_vulnerable_lines
    cur_file_analysis['Ground_truth']['No_vulnerabilities'] = No_vulnerabilities

    cur_file_analysis['No_vulnerable_lines'] = asm_file['No_vulnerable_lines']
    cur_file_analysis['No_vulnerabilities'] = asm_file['No_vulnerabilities']

    cur_file_analysis['Branch']['No_lines'] = asm_file['Branch']['No_lines']
    cur_file_analysis['Branch']['No_vulnerabilities'] = asm_file['Branch']['No_vulnerabilities']
    cur_file_analysis['Branch']['Ground_truth']['No_vulnerable_lines'] = sum([len(vulnerability['Line_nos']) for vulnerability in dataset_file['Branch']['Vulnerabilities']])
    cur_file_analysis['Branch']['Ground_truth']['No_vulnerabilities'] = len(dataset_file['Branch']['Vulnerabilities'])

    cur_file_analysis['Bypass']['No_lines'] = asm_file['Bypass']['No_lines']
    cur_file_analysis['Bypass']['No_vulnerabilities'] = asm_file['Bypass']['No_vulnerabilities']
    cur_file_analysis['Bypass']['Ground_truth']['No_vulnerable_lines'] = len(set([line_no for fault in dataset_file['Bypass']['Vulnerabilities'] for line_no in fault['Line_nos']]))
    cur_file_analysis['Bypass']['Ground_truth']['No_vulnerabilities'] = len(dataset_file['Bypass']['Vulnerabilities'])

    cur_file_analysis['ConstantCoding']['No_lines'] = asm_file['ConstantCoding']['No_lines']
    cur_file_analysis['ConstantCoding']['No_vulnerabilities'] = asm_file['ConstantCoding']['No_vulnerabilities']
    cur_file_analysis['ConstantCoding']['Ground_truth']['No_vulnerable_lines'] = sum([len(vulnerability['Line_nos']) for vulnerability in dataset_file['ConstantCoding']['Vulnerabilities']])
    cur_file_analysis['ConstantCoding']['Ground_truth']['No_vulnerabilities'] = len(dataset_file['ConstantCoding']['Vulnerabilities'])

    cur_file_analysis['LoopCheck']['No_lines'] = asm_file['LoopCheck']['No_lines']
    cur_file_analysis['LoopCheck']['No_vulnerabilities'] = asm_file['LoopCheck']['No_vulnerabilities']
    cur_file_analysis['LoopCheck']['Ground_truth']['No_vulnerable_lines'] = sum([len(vulnerability['Line_nos']) for vulnerability in dataset_file['LoopCheck']['Vulnerabilities']])
    cur_file_analysis['LoopCheck']['Ground_truth']['No_vulnerabilities'] = len(dataset_file['LoopCheck']['Vulnerabilities'])

    # Updating overall analysis
    analysis['Total_no_lines'] += cur_file_analysis['No_lines']

    analysis['Ground_truth']['Total_no_vulnerable_lines'] += cur_file_analysis['Ground_truth']['No_vulnerable_lines']
    analysis['Ground_truth']['Total_no_vulnerabilities'] += cur_file_analysis['Ground_truth']['No_vulnerabilities']

    analysis['Total_no_vulnerable_lines'] += cur_file_analysis['No_vulnerable_lines']
    analysis['Total_no_vulnerabilities'] += cur_file_analysis['No_vulnerabilities']

    analysis['Branch']['Total_no_lines'] += cur_file_analysis['Branch']['No_lines']
    analysis['Branch']['Total_no_vulnerabilities'] += cur_file_analysis['Branch']['No_vulnerabilities']
    analysis['Branch']['Ground_truth']['Total_no_lines'] += cur_file_analysis['Branch']['Ground_truth']['No_vulnerable_lines']
    analysis['Branch']['Ground_truth']['Total_no_vulnerabilities'] += cur_file_analysis['Branch']['Ground_truth']['No_vulnerabilities']

    analysis['Bypass']['Total_no_lines'] += cur_file_analysis['Bypass']['No_lines']
    analysis['Bypass']['Total_no_vulnerabilities'] += cur_file_analysis['Bypass']['No_vulnerabilities']
    analysis['Bypass']['Ground_truth']['Total_no_lines'] += cur_file_analysis['Bypass']['Ground_truth']['No_vulnerable_lines']
    analysis['Bypass']['Ground_truth']['Total_no_vulnerabilities'] += cur_file_analysis['Bypass']['Ground_truth']['No_vulnerabilities']

    analysis['ConstantCoding']['Total_no_lines'] += cur_file_analysis['ConstantCoding']['No_lines']
    analysis['ConstantCoding']['Total_no_vulnerabilities'] += cur_file_analysis['ConstantCoding']['No_vulnerabilities']
    analysis['ConstantCoding']['Ground_truth']['Total_no_lines'] += cur_file_analysis['ConstantCoding']['Ground_truth']['No_vulnerable_lines']
    analysis['ConstantCoding']['Ground_truth']['Total_no_vulnerabilities'] += cur_file_analysis['ConstantCoding']['Ground_truth']['No_vulnerabilities']

    analysis['LoopCheck']['Total_no_lines'] += cur_file_analysis['Bypass']['No_lines']
    analysis['LoopCheck']['Total_no_vulnerabilities'] += cur_file_analysis['LoopCheck']['No_vulnerabilities']
    analysis['LoopCheck']['Ground_truth']['Total_no_lines'] += cur_file_analysis['LoopCheck']['Ground_truth']['No_vulnerable_lines']
    analysis['LoopCheck']['Ground_truth']['Total_no_vulnerabilities'] += cur_file_analysis['LoopCheck']['Ground_truth']['No_vulnerabilities']

def calc_file_precision_recall(choice: str):
    '''
    Either calculates precision, recall, and F-1 score for a specific file or overall (as dictated by choice)
    :param choice: can be 'file' or 'overall' (str)
    :return: N/A
    '''

    def safe_divide(numerator, denominator):
        '''
        Returns 1 if denominator is 0 or else true value of numerator/denominator
        '''
        return numerator / denominator if denominator != 0 else 1

    if choice == 'file':
        # Main precision, recall, and F-1 score calculations
        cur_file_analysis['Precision'] = safe_divide(cur_file_analysis['No_TP'], (cur_file_analysis['No_TP'] + cur_file_analysis['No_FP']))
        cur_file_analysis['Recall'] = safe_divide(cur_file_analysis['No_TP'], (cur_file_analysis['No_TP'] + cur_file_analysis['No_FN']))
        cur_file_analysis['F-1_score'] = safe_divide(2,(safe_divide(1, cur_file_analysis['Precision']) + safe_divide(1,cur_file_analysis['Recall'])))


        # Branch
        cur_file_analysis['Branch']['Precision'] = safe_divide(cur_file_analysis['Branch']['No_TP'], (cur_file_analysis['Branch']['No_TP'] + cur_file_analysis['Branch']['No_FP']))
        cur_file_analysis['Branch']['Recall'] = safe_divide(cur_file_analysis['Branch']['No_TP'], (cur_file_analysis['Branch']['No_TP'] + cur_file_analysis['Branch']['No_FN']))
        cur_file_analysis['Branch']['F-1_score'] = safe_divide(2,(safe_divide(1, cur_file_analysis['Branch']['Precision']) + safe_divide(1,cur_file_analysis['Branch']['Recall'])))

        # Bypass
        cur_file_analysis['Bypass']['Precision'] = safe_divide(cur_file_analysis['Bypass']['No_TP'], (cur_file_analysis['Bypass']['No_TP'] + cur_file_analysis['Bypass']['No_FP']))
        cur_file_analysis['Bypass']['Recall'] = safe_divide(cur_file_analysis['Bypass']['No_TP'], (cur_file_analysis['Bypass']['No_TP'] + cur_file_analysis['Bypass']['No_FN']))
        cur_file_analysis['Bypass']['F-1_score'] = safe_divide(2,(safe_divide(1, cur_file_analysis['Bypass']['Precision']) + safe_divide(1,cur_file_analysis['Bypass']['Recall'])))

        # ConstantCoding
        cur_file_analysis['ConstantCoding']['Precision'] = safe_divide(cur_file_analysis['ConstantCoding']['No_TP'], (cur_file_analysis['ConstantCoding']['No_TP'] + cur_file_analysis['ConstantCoding']['No_FP']))
        cur_file_analysis['ConstantCoding']['Recall'] = safe_divide(cur_file_analysis['ConstantCoding']['No_TP'], (cur_file_analysis['ConstantCoding']['No_TP'] + cur_file_analysis['ConstantCoding']['No_FN']))
        cur_file_analysis['ConstantCoding']['F-1_score'] = safe_divide(2,(safe_divide(1, cur_file_analysis['ConstantCoding']['Precision']) + safe_divide(1,cur_file_analysis['ConstantCoding']['Recall'])))

        # LoopCheck
        cur_file_analysis['LoopCheck']['Precision'] = safe_divide(cur_file_analysis['LoopCheck']['No_TP'], (cur_file_analysis['LoopCheck']['No_TP'] + cur_file_analysis['LoopCheck']['No_FP']))
        cur_file_analysis['LoopCheck']['Recall'] = safe_divide(cur_file_analysis['LoopCheck']['No_TP'], (cur_file_analysis['LoopCheck']['No_TP'] + cur_file_analysis['LoopCheck']['No_FN']))
        cur_file_analysis['LoopCheck']['F-1_score'] = safe_divide(2,(safe_divide(1, cur_file_analysis['LoopCheck']['Precision']) + safe_divide(1,cur_file_analysis['LoopCheck']['Recall'])))


    elif choice == 'overall':
        # Main precision, recall, and F-1 score calculations
        analysis['Precision'] = safe_divide(analysis['Total_no_TP'], (analysis['Total_no_TP'] + analysis['Total_no_FP']))
        analysis['Recall'] = safe_divide(analysis['Total_no_TP'], (analysis['Total_no_TP'] + analysis['Total_no_FN']))
        analysis['F-1_score'] = safe_divide(2,(safe_divide(1, analysis['Precision']) + safe_divide(1,analysis['Recall'])))

        # Branch
        analysis['Branch']['Precision'] = safe_divide(analysis['Branch']['Total_no_TP'], (analysis['Branch']['Total_no_TP'] + analysis['Branch']['Total_no_FP']))
        analysis['Branch']['Recall'] = safe_divide(analysis['Branch']['Total_no_TP'], (analysis['Branch']['Total_no_TP'] + analysis['Branch']['Total_no_FN']))
        analysis['Branch']['F-1_score'] = safe_divide(2,(safe_divide(1, analysis['Branch']['Precision']) + safe_divide(1,analysis['Branch']['Recall'])))

        # Bypass
        analysis['Bypass']['Precision'] = safe_divide(analysis['Bypass']['Total_no_TP'], (analysis['Bypass']['Total_no_TP'] + analysis['Bypass']['Total_no_FP']))
        analysis['Bypass']['Recall'] = safe_divide(analysis['Bypass']['Total_no_TP'], (analysis['Bypass']['Total_no_TP'] + analysis['Bypass']['Total_no_FN']))
        analysis['Bypass']['F-1_score'] = safe_divide(2,(safe_divide(1, analysis['Bypass']['Precision']) + safe_divide(1,analysis['Bypass']['Recall'])))

        # ConstantCoding
        analysis['ConstantCoding']['Precision'] = safe_divide(analysis['ConstantCoding']['Total_no_TP'], (analysis['ConstantCoding']['Total_no_TP'] + analysis['ConstantCoding']['Total_no_FP']))
        analysis['ConstantCoding']['Recall'] = safe_divide(analysis['ConstantCoding']['Total_no_TP'], (analysis['ConstantCoding']['Total_no_TP'] + analysis['ConstantCoding']['Total_no_FN']))
        analysis['ConstantCoding']['F-1_score'] = safe_divide(2,(safe_divide(1, analysis['ConstantCoding']['Precision']) + safe_divide(1,analysis['ConstantCoding']['Recall'])))

        # LoopCheck
        analysis['LoopCheck']['Precision'] = safe_divide(analysis['LoopCheck']['Total_no_TP'], (analysis['LoopCheck']['Total_no_TP'] + analysis['LoopCheck']['Total_no_FP']))
        analysis['LoopCheck']['Recall'] = safe_divide(analysis['LoopCheck']['Total_no_TP'], (analysis['LoopCheck']['Total_no_TP'] + analysis['LoopCheck']['Total_no_FN']))
        analysis['LoopCheck']['F-1_score'] = safe_divide(2,(safe_divide(1, analysis['LoopCheck']['Precision']) + safe_divide(1,analysis['LoopCheck']['Recall'])))

# locate latest report
latest_report_file = max(glob.glob(os.path.join('Results/Reports', '*.json')), key=os.path.getctime)
# latest_report_file = max(glob.glob(os.path.join('Reports', '*.json')), key=os.path.getctime)

# report_data has results from FaultHunter run
with open(latest_report_file, 'r') as report_file:
    report_data = json.load(report_file)

# dataset holds ground truth
# with open ('dataset.json', 'r') as dataset_file:
with open ('Results/dataset.json', 'r') as dataset_file:
    dataset = json.load(dataset_file)

for asm_file in report_data:
    # Make an instance of the file_analysis dictionary to be populated with the analysis of the report
    cur_file_analysis = copy.deepcopy(file_analysis)

    # to locate the asm_file from run in dataset
    dataset_file = next((file for file in dataset if file['Program_name'] == asm_file['Program_name']
                         and file['Optimization_level'] == asm_file['Optimization_level']), None)

    # Update common information for both analyses
    update_analyses(asm_file)

    # Registering TP, FP, and FN for each pattern
    analyze_pattern('Branch')
    analyze_pattern('Bypass')
    analyze_pattern('ConstantCoding')
    analyze_pattern('LoopCheck')
    calc_file_precision_recall('file')
    
    analysis['Files'].append(copy.deepcopy(cur_file_analysis))

calc_file_precision_recall('overall')

# open latest analysis file
latest_analysis_file = max(glob.glob(os.path.join('Results/Analysis', '*.json')), key=os.path.getctime)
# latest_analysis_file = max(glob.glob(os.path.join('Analysis', '*.json')), key=os.path.getctime)

# Write to latest analysis file
with open(latest_analysis_file, 'w') as analysis_file:
    json.dump(analysis, analysis_file, indent=4)

