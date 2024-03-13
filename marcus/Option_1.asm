        .ORIG x3000
        
LOOP    TRAP x23
        JSR CHECK
        BRn LOOP
        HALT
        
        
CHECK   ST R0,SAVE0
        ST R1,SAVE1
        ST R2,SAVE2
        LD R1, UPPER
        ADD R2,R0,R1
        BRp ERR
        LD R1, LOWER
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
LOWER   .FILL #-48
MSG     .STRINGZ "Input must be a digit between 0-9\n"

SAVE0   .BLKW 1
SAVE1   .BLKW 1
SAVE2   .BLKW 1

        .END