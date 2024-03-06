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
    
readS   LEA R0, INP_STR
        LD R4, ASCII
        PUTS
        IN
        ADD R0, R0, R4
        AND R1, R1, x0
        AND R3, R3, x0
        ADD R3, R3, #10
LOOP    ADD R1, R1, R0
        ADD R3, R3, #-1
        BRp LOOP
        IN
        ADD R0, R0, R4
        ADD R0, R0, R1
        RET
        
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

resultS AND R1, R1, x0
        ADD R1, R1, #1
        AND R1, R1, R0
        BRz NOT_P
        LEA R0, IS_P_STR
        PUTS
        RET
NOT_P   LEA R0, NO_P_STR
        PUTS
        RET
        
IS_P_STR .STRINGZ "The number is prime\n"
NO_P_STR .STRINGZ "The number is not prime\n"
INP_STR .STRINGZ "Input a 2 digit decimal number: "
ASCII   .FILL #-48
.END