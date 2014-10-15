; This function prints a null-terminated ASCII string to the screen. Place the
; address of the string into bx and call print_string

print_string:
    mov ah, 0x0e

ps_loop:
    cmp [bx], word 0
    je ps_break

    mov al, byte [bx]
    int 0x10

    add bx, 0x1
    jmp ps_loop

ps_break:
    ret

; Just print a single character
print_char:
    mov ah, 0x0e
    mov al, bl
    int 0x10
    ret

; Convert the hex digit in bl to ASCII
;hex_to_char:
;    add bl, 0x30
;    cmp bl, 0x3a
;    jl ($ + 3)
;    add bl, 0x7
;    ret

; Print the value of bl to the console, as hex
;print_hex_byte:
;    mov ch, bl
;    shr ch, 4
;    
;    mov cl, bl
;    and cl, 0x0F
;    
;    mov bl, ch
;    call hex_to_char
;    call print_char
;
;    mov bl, cl
;    call hex_to_char
;    call print_char
;
;    ret

    
; Print the word stored in bx as hex
;print_hex_word:
;    push bx
;
;    mov bl, '0'
;    call print_char
;
;    mov bl, 'x'
;    call print_char
;
;    pop bx
;    push bx
;    shr bx, 8
;    call print_hex_byte
;
;    pop bx
;    call print_hex_byte
;
;    ret

; Start a new line
print_new_line:
    push bx
    mov bx, ENDL
    call print_string
    pop bx
    ret

; Data
CRLF:   equ     0x0a0d

ENDL:
    dw CRLF
    dw 0
