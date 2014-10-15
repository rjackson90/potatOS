;
;   A basic BIOS boot sector
;
[org 0x7c00]
    mov [BOOT_DRIVE], dl        ; BIOS stores the boot drive in dl, save it for later

    mov bp, 0x8000              ; Set up the stack some place out of the way
    mov sp, bp
    
    mov ah, 0x00                ; BIOS set video mode
    mov al, 0x02                ; 80x25 lines text mode, 16 colors 8 pages
    int 0x10

    mov ah, 0x0b                ; BIOS background/border color
    mov bx, 0x000c              ; light red background, black border
    int 0x10    

    mov bx, BOOT_MSG            ; Inform user of entry to Real Mode            
    call print_string

    call load_kernel            ; load the kernel

    mov bx, PM_SWITCH_MSG       ; Inform the user of PM bring-up
    call print_string

    call switch_to_pm           ; switch to PM. **NOTE** this call never returns


%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "mode_switch.asm"
%include "pm_print_string.asm"

[bits 16]
load_kernel:
    mov bx, LOAD_KERNEL_MSG     ; Inform the user that we are loading the kernel
    call print_string

    mov bx, KERNEL_OFFSET       ;
    mov dh, 1                   ; Read the kernel from disk into memory at offset
    mov dl, [BOOT_DRIVE]        ; 0x1000, which is our preselected "magic offset"
    call disk_load              ;

    ret

[bits 32]
BEGIN_PM:
    mov ebx, PM_ENTER_MSG       ; Inform the user that 32-bit mode has been entered
    call print_string_pm

    mov ebx, KERNEL_ENTER_MSG   ; Looks like we're gonna have to jump...!
    call print_string_pm

    call KERNEL_OFFSET          ; Grab your ankles and kiss your ass goodbye, we're
                                ; jumping into the loaded kernel. Cowabunga, dudes!

    jmp $

;   Data
BOOT_MSG:
    db  "Boot sector loaded. Running in 16-bit real mode."
    dw CRLF
    dw 0

PM_SWITCH_MSG:
    db "Switching to 32-bit protected mode."
    dw CRLF
    dw 0

PM_ENTER_MSG:
    db "Now running in 32-bit mode."
    db 0

LOAD_KERNEL_MSG:
    db "Loading kernel from disk."
    dw CRLF
    dw 0

KERNEL_ENTER_MSG:
    db "Passing control to kernel."
    db 0

BOOT_DRIVE:
    db 0

KERNEL_OFFSET equ 0x1000

;   Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55
