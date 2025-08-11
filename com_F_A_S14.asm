                 .model small
.stack 100h
.data
    msg db 10,13,"First character (alphabetical): $"
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Read first character
    mov ah, 1
    int 21h
    mov bl, al

    ; Read second character
    int 21h
    mov bh, al

    ; Display message
    mov ah, 9
    lea dx, msg
    int 21h

    ; Compare and print smaller (alphabetically first)
    cmp bl, bh
    jle print_bl    ; if bl <= bh ? print bl
    jmp print_bh    ; else print bh

print_bl:   
    mov ah, 2
    mov dl, bl
    int 21h
    jmp done

print_bh:
    mov ah, 2
    mov dl, bh
    int 21h

done:
    mov ax, 4c00h
    int 21h
    
main endp
end main
