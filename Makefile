# Project name - will be used to create the name of the final binary image
TARGET = PotatOS.img

# C Compiler flags
CC = gcc
CFLAGS = -m32 -ffreestanding -std=c11 -Wall -pedantic -I$(INCLUDE_DIR)

# Linker and flags
LINKER = ld
LFLAGS = -melf_i386 -Ttext 0x1000 --oformat binary

# Directories
SRC_DIR 	= src
BIN_DIR 	= bin
BOOT_DIR 	= boot
INCLUDE_DIR = include

# File types
C_SOURCES	:= $(wildcard $(SRC_DIR)/*.c)
OBJECTS		:= $(C_SOURCES:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)

.PHONY: all
all: $(BIN_DIR)/$(TARGET)

.PHONY: qemu
qemu: $(BIN_DIR)/$(TARGET)
	qemu-system-i386 -vga std -cpu Haswell $<

$(BIN_DIR)/$(TARGET): $(BIN_DIR)/boot_sect.bin $(BIN_DIR)/kernel.bin
	cat $^ > $@

$(BIN_DIR)/boot_sect.bin: $(BOOT_DIR)/boot_sect.asm
	nasm -f bin -i $(BOOT_DIR)/ -o $@ $^

$(BIN_DIR)/kernel.bin: $(BIN_DIR)/kernel_entry.elf $(OBJECTS)
	$(LINKER) $(LFLAGS) -o $@ $^

$(BIN_DIR)/kernel_entry.elf: $(SRC_DIR)/kernel_entry.asm
	nasm -f elf -o $@ $^

$(OBJECTS): $(BIN_DIR)/%.o : $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(BIN_DIR)/*
