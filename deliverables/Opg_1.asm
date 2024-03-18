        .ORIG   x3000
        
        ; Load A and B to R0 and R1
        LD      R0,A
        LD      R1,B
        
        ; Find negative value of A and place it in R2
X       NOT     R2,R0
        ADD     R2,R2,#1
        
        ; Add -A and B and jump to DONE, if result is zero
        ADD     R2,R2,R1
        BRz     DONE
        
        ; Decrement B and increment A and repeat process
        ADD     R1,R1,#-1
        ADD     R0,R0,#1
        BRnzp   X
        
        ; Current B is equal to the midpoint and is stored in C
DONE    ST      R1,C
        TRAP    x25 ;HALT
A       .BLKW   1
B       .BLKW   1
C       .BLKW   1
        .END