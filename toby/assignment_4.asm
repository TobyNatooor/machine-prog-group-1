; Write a function called “resultS” that takes as argument a value stored in R0. If the value in
; R0 is not zero then the function should display on the console the message: “The number is
; prime” else it should display the message “The number is not prime”.

.ORIG x3000
        
        ; Tests for the function
        AND R0, R0, #0
        ADD R0, R0, #1
        JSR resultS
        AND R0, R0, #0
        ADD R0, R0, #0
        JSR resultS
        AND R0, R0, #0
        ADD R0, R0, #-1
        JSR resultS
        HALT
        
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
        
IS_P_STR .STRINGZ "The number is prime\n"       ; The string that gets printed if R0 is not 0, and therefore is prime
NO_P_STR .STRINGZ "The number is not prime\n"   ; The string that gets printed if R0 is 0, and therefore is not prime
.END
