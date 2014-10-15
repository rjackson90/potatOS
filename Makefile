.PHONY: all
all : osimage.img

.PHONY: qemu
qemu : osimage.img
	qemu-system-i386 -cpu Haswell $<

boot_sect.bin : boot_sect.asm
	nasm -f bin -o $@ $<

kernel.o : kernel.c
	gcc -ffreestanding -c $< -o $@

kernel.bin : kernel.o
	ld -o $@ -Ttext 0x1000 $< --oformat binary

osimage.img : boot_sect.bin kernel.bin
	cat $^ > $@

.PHONY: clean
clean :
	rm -f *.bin *.o *.img
