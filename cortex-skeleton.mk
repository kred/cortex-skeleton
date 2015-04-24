# One Makefile to rule them all
# For STM32 Cortex-M0, M3, M4
# Author: Krzysztof Dziuba krzysztof (at) meeqo.net
# License: LGPL-3

# To use this file in your own project, set following variables:
#
# SKELETON_BASE (path to this file, relative to ones Makefile location)
# DEVICE_MODEL (e.g. STM32F030F4)
# CSRC (add your source files to this variable)
# INCDIR (add path to header files directory here)
# PROJECT (your project name, also name of output binary file)
#
# Include this file at the end of your Makefile

PREFIX  = arm-none-eabi-
CC = $(PREFIX)gcc
LD = $(PREFIX)ld
OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump
SHELL = /bin/bash

INCDIR += $(SKELETON_BASE)/device/CMSIS/include/
COPT += $(OPTIONS) -fomit-frame-pointer -falign-functions=16 -Wall -lgcc

DEVICE_SPECIFIC_MK = device-$(shell tr '[:upper:]' '[:lower:]' <<< $(DEVICE_MODEL)).mk
include $(SKELETON_BASE)/$(DEVICE_SPECIFIC_MK)

LDOPT += -T$(LINKER) -nostartfiles -nodefaultlibs -nostdlib -Wl,-Map=$(PROJECT).map,--cref,--gc-sections $(COPT) -g -ffunction-sections -fdata-sections
OBJECTS += $(notdir $(CSRC:%.c=%.o) $(ASMSRC:%.s=%.o))


all: $(PROJECT).elf $(PROJECT).bin $(PROJECT).hex $(PROJECT).lst

$(PROJECT).elf: $(OBJECTS)
	@echo "Linking $@..."
	@$(CC) $(OBJECTS) $(LIBS) $(LDOPT) --output $@

$(PROJECT).bin: $(PROJECT).elf
	@echo "Generating $@..."
	@$(OBJCOPY) -O binary $(PROJECT).elf $(PROJECT).bin

$(PROJECT).hex: $(PROJECT).elf
	@echo "Generating $@..."
	@$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex

$(PROJECT).lst: $(PROJECT).elf
	@echo "Generating $@..."
	@$(OBJDUMP) -D $(PROJECT).elf > $(PROJECT).lst

%.o: %.c
	@echo "Compiling $@..."
	@$(CC) -c $(COPT) $< -o $@

%.o: $(SRCDIR)/%.c
	@echo "Compiling $@..."
	@$(CC) -c $(COPT) $< -o $@

%.o: $(SRCDIR)/%.s
	@echo "Compiling $@..."
	@$(CC) -c $(COPT) $< -o $@

clean:
	@echo "Cleaning..."
	@rm -f $(OBJECTS)
	@rm -f $(PROJECT).elf
	@rm -f $(PROJECT).bin
	@rm -f $(PROJECT).hex
	@rm -f $(PROJECT).lst
	@rm -f $(PROJECT).map
