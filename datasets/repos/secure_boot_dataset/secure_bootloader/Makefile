# Secure Bootloader targets
# -------------------------

# Find the Root Directory
SB_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Define compiler
CC := riscv64-unknown-elf-gcc
OBJCOPY := riscv64-unknown-elf-objcopy

# Define directories
SRC_DIR := $(SB_DIR)/src
PLATFORM := $(SRC_DIR)/platform
CRYPTO := $(SRC_DIR)/crypto

# Define Targets
BUILD_DIR := $(SB_DIR)/build
SB_BIN := $(BUILD_DIR)/secure_bootloader.bin
SB_ELF := $(BUILD_DIR)/secure_bootloader.elf

# Define Sources
SB_SRCS := \
    $(SRC_DIR)/bootloader.c \
    $(SRC_DIR)/bootloader.S \
    $(PLATFORM)/platform.S \
    $(CRYPTO)/ed25519/fe.c \
    $(CRYPTO)/ed25519/ge.c \
    $(CRYPTO)/ed25519/keypair.c \
    $(CRYPTO)/ed25519/sc.c \
    $(CRYPTO)/ed25519/sha512.c \
    $(CRYPTO)/ed25519/sign.c \
    $(SRC_DIR)/clib/memcpy.c

SB_LDS := $(SRC_DIR)/bootloader.lds

# Debug Flags
#DEBUG_FLAGS := -ggdb3

# Compiler Flags
CFLAGS := -S -march=rv64g -mcmodel=medany -mabi=lp64 -fno-common -fno-tree-loop-distribute-patterns -std=gnu11 -Wall -O2$(DEBUG_FLAGS) -fvisibility=hidden -nostartfiles -nostdlib -static

# Build directory target
$(BUILD_DIR):
	@echo "Creating build directory..."
	mkdir -p $(BUILD_DIR)

# ELF target
#$(SB_ELF): $(BUILD_DIR) $(SB_LDS) $(SB_SRCS)
.PHONY: assemble
	@echo "Compiling secure bootloader ELF..."
	$(CC) -S -T $(SB_LDS) -I $(SRC_DIR) -I $(SRC_DIR)/clib -I $(CRYPTO) -I $(PLATFORM) $(CFLAGS) $(SB_SRCS) -o $(SB_ELF)

# Binary target
$(SB_BIN): $(SB_ELF)
	@echo "Extracting binary image from ELF..."
	$(OBJCOPY) -O binary --only-section=.text $(SB_ELF) $(SB_BIN)

# Clean target
.PHONY: clean
clean:
	@echo "Compiling secure bootloader ELF..."
	$(CC) -S -T $(SB_LDS) -I $(SRC_DIR) -I $(SRC_DIR)/clib -I $(CRYPTO) -I $(PLATFORM) $(CFLAGS) $(SB_SRCS)
