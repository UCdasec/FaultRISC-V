##############################################################################
BUILD = build
BIN = bootloader

OPENOCD_CONFIG ?= ../openocd/openocd.cfg

##############################################################################
.PHONY: all directory clean size

MKDIR = mkdir

CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy
SIZE = riscv64-unknown-elf-size

CFLAGS += -S
CFLAGS += -O2

INCLUDES += \
  -I../include \
  -I..

SRCS += \
  ../main.c \
  ../spritz.c \
  ../startup.c

DEFINES += \
  -D__SAMD21J18A__ \
  -DDONT_USE_CMSIS_INIT \
  -DF_CPU=8000000

CFLAGS += $(INCLUDES) $(DEFINES)

OBJS = $(addprefix $(BUILD)/, $(notdir %/$(subst .c,.o, $(SRCS))))

all: directory $(BUILD)/$(BIN).elf $(BUILD)/$(BIN).hex $(BUILD)/$(BIN).bin $(BUILD)/$(BIN)_upd.bin size

$(BUILD)/$(BIN).elf: $(OBJS)
	@echo LD $@
	@$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o $@

$(BUILD)/$(BIN).hex: $(BUILD)/$(BIN).elf
	@echo OBJCOPY $@
	@$(OBJCOPY) -O ihex $^ $@

$(BUILD)/$(BIN).bin: $(BUILD)/$(BIN).elf
	@echo OBJCOPY $@
	@$(OBJCOPY) -O binary $^ $@

$(BUILD)/$(BIN)_upd.bin: $(BUILD)/$(BIN).elf
	@echo OBJCOPY $@
	@$(OBJCOPY) -O binary -R .key $^ $@

%.o:
	@echo CC $@
	@$(CC) $(CFLAGS) $(filter %/$(subst .o,.c,$(notdir $@)), $(SRCS)) -c -o $@

directory:
	@$(MKDIR) -p $(BUILD)

size: $(BUILD)/$(BIN).elf
	@echo size:
	@$(SIZE) -t $^

clean:
	@echo clean
	@-rm -rf $(BUILD)

program: $(BUILD)/$(BIN).hex
	openocd -f $(OPENOCD_CONFIG)

.PHONY: assemble
assemble:
	@echo "Assembling"
	@$(CC) $(CFLAGS) $(INCLUDES) $(SRCS) #-o $@

-include $(wildcard $(BUILD)/*.d)
