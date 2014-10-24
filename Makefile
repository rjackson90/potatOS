#.PHONY: all
#all : bin/osimage.img

#.PHONY: qemu
#qemu : bin/osimage.img
#	qemu-system-i386 -vga std -cpu Haswell $<

#bin/boot_sect.bin : boot/boot_sect.asm
#	nasm -f bin -I boot -o $@ $<

#bin/kernel_entry.elf : arch/kernel_entry.asm
#	nasm -f elf -o $@ $<

#.c.o:
#	gcc -m32 -ffreestanding -std=c11 -Iinclude -c src/$< -o bin/$@

#bin/kernel.bin : bin/kernel_entry.elf bin/kernel.o bin/video.o
#	ld -melf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

#bin/osimage.img : bin/boot_sect.bin bin/kernel.bin
#	cat $^ > $@

#.PHONY: clean
#clean :
#	rm -f bin/*
#	touch bin/.gitkeep


###############################################################################

# Project name - will be used to create the name of the final binary image
TARGET = PotatOS.img

CC = gcc

# C Compiler flags
CFLAGS = -m32 -ffreestanding -std=c11 -I$(INCLUDE_DIR)

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
