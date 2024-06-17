#!/bin/bash

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Create the Results directory if it doesn't exist
RESULTS_DIR="$SCRIPT_DIR/Results"
mkdir -p "$RESULTS_DIR"

# Get the current date and time in the format YYYY-MM-DD_HH-MM
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

# Create the new directory with the current date and time as the name
NEW_RESULT="$RESULTS_DIR/$TIMESTAMP.json"
touch "$NEW_RESULT"

# Get the full directory of the folder with the test set and make list of .s files in folder
SOURCE_DIR=$(dirname "$(realpath "$1")")
FILES=$(find $SOURCE_DIR -type f -name "*.s")

# For each .s file, run the report
for FILE in $FILES; do
  python3 main.py $FILE --store_result yes --result_location report
done