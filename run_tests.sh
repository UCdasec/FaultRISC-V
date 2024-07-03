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


# Optional Variable: Optimization level
OPT_LEVEL = ""

while getopts "o:" option; do
  case "$option" in
    o)
      OPT_LEVEL=$OPTARG
      ;;
    *)
      echo "Usage: ./run_tests.sh [-opt optimization_level(O0|O1|O2)] source_dir"
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

# Get the full directory of the folder with the test set and make list of .s files in folder
SOURCE_DIR=$(realpath "$1")
FILES=$(find "$SOURCE_DIR" -type f -name "*.s")

# For each file, run the report
for FILE in $FILES; do
  if [ -n "$OPT_LEVEL" ]; then
    python3 main.py "$FILE" --optimization_level "$OPT_LEVEL" --store_result report
  else
    python3 main.py "$FILE" --store_result report
  fi
done

# Create the Analysis directory if it doesn't exist
ANALYSIS_DIR="$SCRIPT_DIR/Results/Analysis"
mkdir -p "$ANALYSIS_DIR"

# Create a new analysis with current date and time as the name
NEW_ANALYSIS="$ANALYSIS_DIR/Analysis_$TIMESTAMP.json"
touch "$NEW_ANALYSIS"

# Run analysis
python3 "Results/Analyze.py"