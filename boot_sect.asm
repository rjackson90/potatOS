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

    mov bx, BOOT_MSG                        
    call print_string

    mov bx, 0x9000              ; Load 2 sectors to 0x0000(ES):0x9000(BX)
    mov dh, 2                   ; from the boot disk
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov bx, [0x9000]            ; Print the first word from the first loaded sector,
    call print_hex_word         ; to confirm data integrity
    call print_new_line

    mov bx, [0x9000 + 512]      ; Print the first word from the second loaded sector
    call print_hex_word
    call print_new_line

    mov bx, PM_SWITCH_MSG       ; Inform the user of PM bring-up
    call print_string

    call switch_to_pm           ; switch to PM. **NOTE** this call never returns


%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "mode_switch.asm"
%include "pm_print_string.asm"

[bits 32]
BEGIN_PM:
    mov ebx, PM_ENTER_MSG
    call print_string_pm

    jmp $

;   Data
BOOT_MSG:
    db  "Boot sector loaded. Running in 16-bit real mode."
    dw CRLF
    dw 0

HALT_MSG:
    db "System halt."
    dw CRLF
    dw 0

PM_SWITCH_MSG:
    db "Switching to 32-bit protected mode."
    dw CRLF
    dw 0

PM_ENTER_MSG:
    db "Now running in 32-bit mode."
    db 0

BOOT_DRIVE:
    db 0

;   Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55

;   Add a couple more sectors to the image
times 256 dw 0xbeef
times 256 dw 0xface
