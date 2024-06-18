#!/bin/bash

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Create the Results directory if it doesn't exist
REPORTS_DIR="$SCRIPT_DIR/Results/Reports"
mkdir -p "$RESULTS_DIR"

# Get the current date and time in the format YYYY-MM-DD_HH-MM
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

# Create the new report with the current date and time as the name
NEW_RESULT="$REPORTS_DIR/Report_$TIMESTAMP.json"
touch "$NEW_RESULT"

# Get the full directory of the folder with the test set and make list of .s files in folder
SOURCE_DIR=$(realpath "$1")
FILES=$(find "$SOURCE_DIR" -type f -name "*.s")

# For each file, run the report
for FILE in $FILES; do
  python3 main.py "$FILE" --store_result yes --result_location report
done

# Create the Analysis directory if it doesn't exist
ANALYSIS_DIR="$SCRIPT_DIR/Results/Analysis"
mkdir -p "ANALYSIS_DIR"

# Create a new analysis with current date and time as the name
NEW_ANALYSIS="$ANALYSIS_DIR/Analysis_$TIMESTAMP.json"
touch "$NEW_ANALYSIS"