# This builds the binary of our kernel from two object files :
# - the kernel_entry , which jumps to main () in our kernel
# - the compiled C kernel
kernel.bin : kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# Build our kernel object file .
kernel.o : kernel.c
	gcc -ffreestanding -c $< -o $@

# Build our kernel entry object file .
kernel_entry.o : kernel_entry.asm
	nasm $< -f elf64 -o $@

# Assemble the boot sector to raw machine code
# The -I options tells nasm where to find our useful assembly
# routines that we include in boot_sect . asm
boot_sect.bin : boot_sect.asm
	nasm $< -f bin -I '../../16bit/' -o $@

# Clear away all generated files .
clean:
	rm -fr *.bin *.dis *.o os-image *.map

# Disassemble our kernel - might be useful for debugging .
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
	