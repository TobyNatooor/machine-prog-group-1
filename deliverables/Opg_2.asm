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
        
readS   LD R5, ASCII
        LD R6, UPPER
IN1     IN
        ADD R1, R0, R5  ; subtract the input with the minimum value of digit.
        BRn NOTDIG1
        ADD R2, R0, R6  ; subtract the input with the maximum value of digit.
        BRnz XTEN
NOTDIG1 LEA R0, WRONG
        PUTS
        BRnzp IN1
XTEN    AND R3, R3, #0
        AND R2, R2, #0
        ADD R2, R2, R1
        BRz IN2
TENLOOP ADD R3, R3, #10
        ADD R2, R2, #-1
        BRp TENLOOP
IN2     IN
        ADD R2, R0, R5  ; subtract the input with the minimum value of digit.
        BRn NOTDIG2
        ADD R4, R0, R6
        BRnz ADDIN
NOTDIG2 LEA R0, WRONG
        PUTS
        BRnzp IN2
ADDIN   AND R0, R0, #0
        ADD R0, R0, R2
        ADD R0, R0, R3
        RET
        
ASCII   .FILL #-48
UPPER   .FILL #-57
WRONG   .STRINGZ "Input must be a digit between 0-9\n"
.END
