import csv

def hamming_weight(n):
    # Assuming 32-bit integers
    bit_length = 32
    # Count the number of 1s in the binary representation
    return bin(n).count('1')

def process_csv(input_file_path, output_file_path):
    with open(input_file_path, newline='') as csvfile:
        csvreader = csv.reader(csvfile)
        rows = list(csvreader)

    updated_rows = []
    for row in rows:
        if len(row) < 3:
            updated_rows.append(row)
            continue
        try:
            num = int(row[2])
            weight = hamming_weight(num)
            if weight <= 4:
                if len(row) > 3:
                    row[3] = True
                else:
                    row.append(True)
            else:
                if len(row) > 3:
                    row[3] = False
                else:
                    row.append(False)
        except ValueError:
            if len(row) > 3:
                row[3] = 'Invalid'
            else:
                row.append('Invalid')
        updated_rows.append(row)

    with open(output_file_path, 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerows(updated_rows)

# Example usage:
input_file_path = 'uECC_O2.s_constant.csv'
output_file_path = 'uECC_O2.s_constant.csv'
process_csv(input_file_path, output_file_path)