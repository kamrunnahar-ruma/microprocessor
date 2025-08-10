.MODEL SMALL
.STACK 100H

.DATA
    ; Menu messages
    menu_msg DB 13,10,'Choose an option:',13,10
             DB '1. Find largest of 2 numbers',13,10
             DB '2. Find largest of 3 numbers',13,10
             DB 'Enter choice (1 or 2): $'
    
    ; Input messages
    msg1 DB 13,10,'Enter first number (0-9): $'
    msg2 DB 13,10,'Enter second number (0-9): $'
    msg3 DB 13,10,'Enter third number (0-9): $'
    
    ; Output messages
    result_msg DB 13,10,'The largest number is: $'
    newline DB 13,10,'$'
    
    ; Variables to store numbers
    num1 DB ?
    num2 DB ?
    num3 DB ?
    largest DB ?

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display menu
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H
    
    ; Get user choice
    MOV AH, 01H
    INT 21H
    MOV BL, AL      ; Store choice in BL
    
    ; Check choice
    CMP BL, '1'
    JE TWO_NUMBERS
    CMP BL, '2'
    JE THREE_NUMBERS
    JMP EXIT        ; Invalid choice, exit
    
TWO_NUMBERS:
    ; Get first number
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV num1, AL
    
    ; Get second number
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV num2, AL
    
    ; Find largest of two numbers
    MOV AL, num1
    CMP AL, num2
    JGE STORE_TWO   ; If num1 >= num2, num1 is largest
    MOV AL, num2    ; Otherwise, num2 is largest
    
STORE_TWO:
    MOV largest, AL
    JMP DISPLAY_RESULT

THREE_NUMBERS:
    ; Get first number
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV num1, AL
    
    ; Get second number
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV num2, AL
    
    ; Get third number
    LEA DX, msg3
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV num3, AL
    
    ; Find largest of three numbers
    MOV AL, num1    ; Start with num1 as largest
    CMP AL, num2
    JGE CHECK_THIRD ; If num1 >= num2, check against num3
    MOV AL, num2    ; Otherwise, num2 might be largest
    
CHECK_THIRD:
    CMP AL, num3
    JGE STORE_THREE ; If current largest >= num3, we have the answer
    MOV AL, num3    ; Otherwise, num3 is largest
    
STORE_THREE:
    MOV largest, AL
    JMP DISPLAY_RESULT

DISPLAY_RESULT:
    ; Display result message
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    
    ; Display the largest number
    MOV AL, largest
    ADD AL, '0'     ; Convert number back to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    ; Display newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H

EXIT:
    ; Terminate program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN