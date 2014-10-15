;   The functions in this file enable the user to write messages to the screen
;   from protected mode
[bits 32]

print_string_pm:        ; Print a null-terminated string located at EBX
    pusha
    mov edx, VIDEO_MEMORY

    mov eax, 160        ;
    imul eax, [LINE_NO] ; Add a one-row offset into video memory to ensure each
    add edx, eax        ; message is on its own line

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_ORANGE

    cmp al, 0
    je print_string_pm_done

    mov [edx], ax

    add ebx, 1
    add edx, 2

    jmp print_string_pm_loop

print_string_pm_done:
    inc byte [LINE_NO]  ; One message per line      
    popa
    ret

;   Data
LINE_NO:
    dd 4

;   Constants
VIDEO_MEMORY equ (0xb8000)
WHITE_ON_ORANGE equ 0x6f
