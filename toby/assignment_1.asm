; It is often useful to find the midpoint between two values. For this
; problem, assume A and B are both even numbers, and A is less than B.
; For example, if A = 2 and B = 8, the midpoint is 5. The following
; program finds the midpoint of two even numbers A and B by continually
; incrementing the smaller number and decrementing the larger number.
; You can assume that A and B have been loaded with values before this
; program starts execution.
; Your job: Insert the missing instructions:
; .ORIG x3000
;      LD R0, A
;      LD R1, B
; X    ------------------ (a)
;      ------------------ (b)
;      ADD R2, R2, R1
;      ------------------ (c)
;      ADD R1, R1, #-1
;      ------------------ (d)
;      BRnzp  X
; DONE ST R1, C
;      TRAP x25
; A    .BLKW 1
; B    .BLKW 1
; C    .BLKW 1
; .END

.ORIG x3000
     LD R0, A
     LD R1, B
     
     ; set initial values
     ADD R0, R0, #2
     ADD R1, R1, #8
     
X    NOT R2, R0
     ADD R2, R2, #1
     ADD R2, R2, R1
     BRz DONE
     ADD R1, R1, #-1
     ADD R0, R0, #1
     BRnzp  X
DONE ST R1, C
     TRAP x25 ; HALT
A    .BLKW 1
B    .BLKW 1
C    .BLKW 1
.END
