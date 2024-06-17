import glob, os, json

latest_report_file = max(glob.glob(os.path.join('Results/Reports', '*.json')), key=os.path.getctime)

with open(latest_report_file, 'r') as report_file:
    report_data = json.load(report_file)

with open ('Results/dataset.json', 'r') as dataset_file:
    dataset = json.load(dataset_file)


