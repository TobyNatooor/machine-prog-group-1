; Write an assembly program that first reads a 2 digit decimal number using the function
; “readS” then checks if the number is prime or not using the function “isPrime” and then
; shows on the display a message that says if the number was prime or not by using the
; function “resultS”. The program should run in an infinite loop (when the function resultS
; returns, the program jumps back to function readS).

.ORIG X3000
    JSR readS
    JSR isPrime
    JSR resultS
    HALT
    
readS   LD R5, ASCII    ; load the value of ASCII into R5
        LD R6, UPPER    ; load the value of UPPER into R6
IN1     LEA R0, INPUT   ; Load the address of INPUT, which contains the error out, into R0
        PUTS            ; Print the INPUT string to the console
        IN              ; Get the first input digit
        ADD R1, R0, R5  ; Add the input with the negated minimum value of digit (R0 - ASCII)
        BRn NOTDIG1     ; If the result is negative, the input is bellow the minimum required value,
                        ; meaning it's not a number between 0-9. It then goes to NOTDIG1
        ADD R2, R0, R6  ; Add the input with the maximum value of digit (R0 - UPPER)
        BRnz XTEN       ; If the result is negative or zero, it means it's within the expected range (48 to 57)
                        ; If the result is positive it's above the accepted range, and therefore not a number
NOTDIG1 LEA R0, WRONG   ; Load the address of WRONG, which contains the error message, into R0
        PUTS            ; Print the WRONG string to the console
        BRnzp IN1       ; Go to IN1 to until a number between 0 and 9 is given as input
XTEN    AND R3, R3, #0  ; Set R3 to 0
        AND R2, R2, #0  ; Set R2 to 0
        ADD R2, R2, R1  ; Add R2 and R1, the first input, and store the result in R2
        BRz IN2         ; If the input is 0 there's no need to multiply it by 10. Go straight to IN2
TENLOOP ADD R3, R3, #10 ; Set R3 to 10
        ADD R2, R2, #-1 ; Decrement R2
        BRp TENLOOP     ; If the result isn't 0 or negative, repeat TENLOOP until R3 contains the first input times 10
IN2     LEA R0, INPUT   ; Repeat of IN2
        PUTS
        IN              
        ADD R2, R0, R5
        BRn NOTDIG2
        ADD R4, R0, R6
        BRnz ADDIN      ; If the input is valid, go to ADDIN
NOTDIG2 LEA R0, WRONG   ; Reapeat of NOTDIG1
        PUTS
        BRnzp IN2
ADDIN   AND R0, R0, #0  ; Set R0 to 0
        ADD R0, R0, R2  ; Add R2, the second input to R0
        ADD R0, R0, R3  ; Add R3, the first input to R0
        RET             ; Return from subrutine
        
isPrime AND R1, R1, x0
        ADD R1, R1, R0
ALL_NUM ADD R1, R1, #-1
        ADD R4, R1, #-1
        BRz PRIME
        AND R2, R2, x0
ONE_NUM ADD R2, R2, R1
        AND R3, R3, x0
        ADD R3, R3, R2
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R0
        BRn ALL_NUM 
        BRp ONE_NUM
        BRz NOT_PRI
PRIME   AND R0, R0, x0
        ADD R0, R0, #1
        RET
NOT_PRI AND R0, R0, x0
        RET

resultS AND R1, R1, #0      ; Set R1 to 0
        ADD R1, R1, #1      ; Add R1 by 1
        AND R1, R1, R0      ; And R1 and R0 to see if R0 contains a 1 or 0 as the bit most to the right
        BRz NOT_P           ; If the result is 0, go to NOT_P
        LEA R0, IS_P_STR    ; Load the address of the string IS_P_STR into R0
        PUTS                ; Print IS_P_STR to the console
        RET                 ; Return from the subrutine
NOT_P   LEA R0, NO_P_STR    ; Load the address of the string IS_P_STR into R0
        PUTS                ; Print NO_P_STR to the console
        RET                 ; Return from the subrutine

                        ; The following values are negated as to make it easier to subtract from the input value
ASCII   .FILL #-48      ; The value needed to transform a number in ASCII to the normal value negated
UPPER   .FILL #-57      ; The largest number an input is allowed to be (48 + 9) negated
INPUT   .STRINGZ "Input a 2 digit decimal number: "     ; Input message
WRONG   .STRINGZ "Input must be a digit between 0-9\n"  ; The error message if the input is not a digit between 0 and 9
IS_P_STR .STRINGZ "The number is prime\n"       ; The string that gets printed if R0 is not 0, and therefore is prime
NO_P_STR .STRINGZ "The number is not prime\n"   ; The string that gets printed if R0 is 0, and therefore is not prime
INP_STR .STRINGZ "Input a 2 digit decimal number: "
.END