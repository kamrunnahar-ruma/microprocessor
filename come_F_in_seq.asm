.model small
.stack 100h
.data
    msg db 10,13,"First character: $"
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 1
    int 21h
    mov bl, al
    int 21h
    mov bh, al

    mov ah, 9
    lea dx, msg
    int 21h

    cmp bl, bh
    jge print_bl
    jmp print_bh

print_bh:
    mov ah, 2
    mov dl, bh
    int 21h
    jmp done

print_bl:   
    mov ah, 2
    mov dl, bl
    int 21h

done:
    mov ax, 4ch
    int 21h
    
main endp
end main