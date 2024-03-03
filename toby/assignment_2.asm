; Write a function called “readS” that reads a 2 digit decimal number from the console and
; returns its value in register R0. The function doesn’t have any input arguments.
; These are the steps performed by the function:
;   1.  Write on the console the message: “Input a 2 digit decimal number:”
;   2.  Read two characters from the console (with echo) and convert them to an integer.
;       Echo means that when you type a character on the keyboard it is also shown on the
;       console. As a simplification it is assumed that the user always types digits (he never
;       types letters or other symbols), which means that you don’t have to validate the input.
;       In other words you don’t have to check if the user has typed digits or some other
;       symbols. As another simplification, numbers less that ten are typed with a zero in
;       front. For example 02, 07 etc.
;   3.  Returns the number read from the console in register R0

.ORIG x3000
        
        JSR readS
        HALT
        
readS   LEA R0, INP_STR
        PUTS
    
        IN
        ADD R0, R0, #-15
        ADD R0, R0, #-15
        ADD R0, R0, #-15
        ADD R0, R0, #-3

        AND R1, R1, x0
        AND R3, R3, x0
        ADD R3, R3, #10

X       ADD R1, R1, R0
        ADD R3, R3, #-1
        BRp X
        
        IN
        ADD R0, R0, #-15
        ADD R0, R0, #-15
        ADD R0, R0, #-15
        ADD R0, R0, #-3

        ADD R0, R0, R1
        RET

INP_STR .STRINGZ "Input a 2 digit decimal number: "
; INT     .FILL #-48
.END