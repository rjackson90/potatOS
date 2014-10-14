;
;   A basic BIOS boot sector
;
[org 0x7c00]
    mov ah, 0x00                ; BIOS set video mode
    mov al, 0x02                ; 80x25 lines text mode, 16 colors 8 pages
    int 0x10

    mov ah, 0x0b                ; BIOS background/border color
    mov bx, 0x000c              ; light red background, black border
    int 0x10    

    mov bx, BOOT_MSG            
    call print_string

    mov bx, WELCOME_MSG
    call print_string

    mov bx, HALT_MSG
    call print_string

    jmp $                       ; Hang

%include "print_string.asm"

;   Data
CRLF:   equ     0x0a0d

BOOT_MSG:
    db  "Boot sector loaded. Running in 16-bit real mode."
    dw CRLF
    dw 0

WELCOME_MSG:
    db "Welcome to PotatOS!"
    dw CRLF
    dw 0

HALT_MSG:
    db "System halt"
    dw CRLF
    dw 0

;   Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55
