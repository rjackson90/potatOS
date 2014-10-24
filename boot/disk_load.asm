; A routine to load DH sectors to ES:BX from drive DL

disk_load:
    push dx         ; We will want to later recall the number of sectors
                    ; requested to be read
    mov ah, 0x02    ; BIOS read sector
    mov al, dh      ; number of sectors to read
    mov ch, 0x00    ; Select cylinder 0
    mov dh, 0x00    ; Select head 0
    mov cl, 0x02    ; Start reading from sector 2 (our bootloader is in sector 1)
    int 0x13        ; BIOS interrupt

    pop dx
    jc disk_error   ; jump if carry flag set (an error occured)

    cmp dh, al      ;
    jne disk_error  ; jump if the number of sectors read != number of sectors expected
    ret             ;

disk_error:
    mov bx, DISK_ERROR_MSG          ; Inform the user a disk read error has occured
    call print_string

    jmp $


;   Data
DISK_ERROR_MSG:
    db "Disk read error!"
    dw CRLF
    dw 0
