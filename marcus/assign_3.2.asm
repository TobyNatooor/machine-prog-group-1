        .ORIG x3000
        
        JSR readS
        HALT
        
readS   ST R1,SAVE1
        ST R2,SAVE2
        ST R3,SAVE3
        AND R1,R1,#0
        AND R2,R2,#0
        LD R3,ASCII
IN1     TRAP x23
        ST R7,SAVE7
        JSR CHECK
        BRn IN1
        LD R7,SAVE7
        ADD R0,R0,R3
        BRnzp TENx
CONT    ADD R1,R1,R2
        LD R3,ASCII
IN2     TRAP x23
        ST R7,SAVE7
        JSR CHECK
        BRn IN2
        LD R7,SAVE7
        ADD R0,R0,R3
        ADD R0,R0,R1
        LD R1,SAVE1
        LD R2,SAVE2
        LD R3,SAVE3
        RET
    

TENx    AND R3,R3,#0
        ADD R3,R3,#10
LOOP    ADD R2,R2,R3
        BRz CONT
        ADD R0,R0,#-1
        BRp LOOP
        BRnz CONT

CHECK   ST R0,SAVE0
        ST R1,SAVE1
        ST R2,SAVE2
        LD R1, UPPER
        ADD R2,R0,R1
        BRp ERR
        LD R1, ASCII
        ADD R2,R0,R1
        BRn ERR
        LD R1,SAVE1
        LD R2,SAVE2
        RET
        
ERR     LEA R0,MSG
        PUTS
        LD R1,SAVE1
        LD R2,SAVE2
        AND R0,R0,#0
        ADD R0,R0,#-1
        RET
        
UPPER   .FILL #-57
MSG     .STRINGZ "Input must be a digit between 0-9\n"

ASCII   .FILL #-48

SAVE0   .BLKW 1
SAVE1   .BLKW 1
SAVE2   .BLKW 1
SAVE3   .BLKW 1
SAVE7   .BLKW 1
        .END