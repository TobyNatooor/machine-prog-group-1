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
        JSR readS       ; execute the function readS
        HALT            ; finish executing
        
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

                        ; The following values are negated as to make it easier to subtract from the input value
ASCII   .FILL #-48      ; The value needed to transform a number in ASCII to the normal value negated
UPPER   .FILL #-57      ; The largest number an input is allowed to be (48 + 9) negated
INPUT   .STRINGZ "Input a 2 digit decimal number: "     ; Input message
WRONG   .STRINGZ "Input must be a digit between 0-9\n"  ; The error message if the input is not a digit between 0 and 9

.END
