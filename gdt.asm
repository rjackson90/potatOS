;   This file contains the GDT used for making the jump to 32-bit protected mode
gdt_start:

gdt_null:       ; Mandatory null descriptor
    dd 0x0
    dd 0x0

gdt_code:       ; Code segment descriptor
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

;   GDT Descriptor
gdt_descriptor:
    dw gdt_end - gdt_start -1
    dd gdt_start

;   Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
