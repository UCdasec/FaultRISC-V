#!/bin/bash

# Define source and target directories
SOURCE_DIRS=("dev_examples/c_source/ai" "dev_examples/c_source/manual")
TARGET_DIR_O0="dev_examples/compiled_riscv/O0"
TARGET_DIR_O1="dev_examples/compiled_riscv/O1"
TARGET_DIR_O2="dev_examples/compiled_riscv/O2"

# Create target directories if they don't exist
mkdir -p $TARGET_DIR_O0
mkdir -p $TARGET_DIR_O1
mkdir -p $TARGET_DIR_O2

# Loop through each source directory
for SOURCE_DIR in "${SOURCE_DIRS[@]}"; do
    # Loop through each C file in the source directory
    for C_FILE in $SOURCE_DIR/*.c; do
        # Extract the base filename (without directory and extension)
        BASE_FILENAME=$(basename $C_FILE .c)

        # Compile the C file into RISC-V assembly with different optimization levels
        riscv64-unknown-elf-gcc -S -O0 $C_FILE -o $TARGET_DIR_O0/$BASE_FILENAME.s
        riscv64-unknown-elf-gcc -S -O1 $C_FILE -o $TARGET_DIR_O1/$BASE_FILENAME.s
        riscv64-unknown-elf-gcc -S -O2 $C_FILE -o $TARGET_DIR_O2/$BASE_FILENAME.s
    done
done

echo "Compilation finished for optimization levels O0, O1, and O2."
