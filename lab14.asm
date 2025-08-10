.model small
.stack 100h
.data
    prompt db 'Enter characters (end with $): $'
    inputBuffer db 50 dup('$') ; input buffer, ends with '$'
    minChar db 0
    resultMsg db 0Dh, 0Ah, 'Smallest character: $'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Show prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Take input string (ends with '$')
    lea dx, inputBuffer
    mov ah, 0Ah
    int 21h

    ; Initialize registers
    lea si, inputBuffer + 2 ; skip length byte and reserved byte
    lodsb                  ; load first character into AL
    mov bl, al             ; store it as minChar

find_min:
    lodsb                  ; load next char from input
    cmp al, '$'            ; check for end of string
    je show_result
    cmp al, bl             ; compare with current minChar
    jae skip               ; if AL >= BL, skip
    mov bl, al             ; new minChar found

skip:
    jmp find_min

show_result:
    ; Print result message
    lea dx, resultMsg
    mov ah, 09h
    int 21h

    ; Print smallest character
    mov dl, bl
    mov ah, 02h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h
end main
