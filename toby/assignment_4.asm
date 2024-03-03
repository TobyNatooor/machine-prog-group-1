; Write a function called “resultS” that takes as argument a value stored in R0. If the value in
; R0 is not zero then the function should display on the console the message: “The number is
; prime” else it should display the message “The number is not prime”.

.ORIG x3000
        
        AND R0, R0, x0
        ADD R0, R0, #1
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #0
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #-1
        JSR resultS

        HALT
        
resultS AND R1, R1, x0
        NOT R1, R1
        AND R1, R1, R0
        
        BRz ZERO
        LEA R0, IS_PRI
        BRnp CONTINU
        
ZERO    LEA R0, NOT_PRI

CONTINU PUTS
        RET
        
IS_PRI  .STRINGZ "The number is prime\n"
NOT_PRI .STRINGZ "The number is not prime\n"
.END
