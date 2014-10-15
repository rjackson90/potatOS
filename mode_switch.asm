;   This file contains code used to switch CPU modes
[bits 16]

; Swtich to protected mode
switch_to_pm:
    cli                         ; Turn off interrupts
    lgdt [gdt_descriptor]       ; load GDT, which defines segments

    mov eax, cr0                ;
    or eax, 0x1                 ; Switch to protected mode by setting the first bit of cr0
    mov cr0, eax                ;

    jmp CODE_SEG:init_pm        ; make a far jump to flush the pipeline


[bits 32]

init_pm:
    mov eax, DATA_SEG           ; we are now in protected mode (PM).
    mov ds, ax                  ; Therefore, we need to point our segment 
    mov ss, ax                  ; registers to the data segment
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000            ; Move the stack to the top of free space
    mov esp, ebp

    call BEGIN_PM               ; Finally, call a well-known label
