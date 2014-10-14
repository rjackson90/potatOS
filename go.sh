#!/bin/sh

# Compile and then run the PotatOS boot sector under QEMU
nasm -f bin -o boot_sect.bin  boot_sect.asm
qemu-system-i386 -cpu Haswell boot_sect.bin
