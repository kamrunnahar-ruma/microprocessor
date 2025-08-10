.model small
.stack 100h
.data
    msg_input db 'Enter your marks (0-100): $'
    msg_aplus db 13,10,'Grade: A+$'
    msg_a db 13,10,'Grade: A$'
    msg_b db 13,10,'Grade: B$'
    msg_c db 13,10,'Grade: C$'

.code
main:
    mov ax, @data
    mov ds, ax

    ; --- Prompt for marks ---
    lea dx, msg_input
    mov ah, 09h
    int 21h

    call read_num      ; AX = user input

    ; --- Grade Calculation ---
    cmp ax, 80
    jae show_aplus

    cmp ax, 70
    jae show_a

    cmp ax, 60
    jae show_b

    ; If less than 60
    jmp show_c

show_aplus:
    lea dx, msg_aplus
    mov ah, 09h
    int 21h
    jmp exit

show_a:
    lea dx, msg_a
    mov ah, 09h
    int 21h
    jmp exit

show_b:
    lea dx, msg_b
    mov ah, 09h
    int 21h
    jmp exit

show_c:
    lea dx, msg_c
    mov ah, 09h
    int 21h

exit:
    mov ah, 4Ch
    int 21h

; --- Subroutine to read number from user ---
read_num proc
    xor ax, ax         ; Clear AX
    xor bx, bx         ; Clear BX
    xor cx, cx         ; Digit counter

read_loop:
    mov ah, 01h        ; Read character
    int 21h
    cmp al, 13         ; Enter key?
    je done_read
    sub al, '0'        ; Convert ASCII to digit
    mov bl, al
    mov dx, ax         ; Save current AX
    mov ax, cx
    mov si, 10
    mul si             ; AX = AX * 10
    add ax, bx         ; AX = AX + digit
    mov cx, ax
    jmp read_loop

done_read:
    mov ax, cx         ; Final result in AX
    ret
read_num endp

end main
