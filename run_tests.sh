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