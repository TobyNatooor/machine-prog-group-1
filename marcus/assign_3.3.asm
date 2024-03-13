        .ORIG x3000
        
        LD      R0,TEST
        JSR     ISPRIME
        HALT

;Function for checking if number is prime
;First checks to see if number is even. Then proceeds to divide given number(R2<-R0),
;with each uneven number (R1) until (-R1) + (-R1) + 3 < R2 
        
ISPRIME ST      R1,SAVE1
        ST      R2,SAVE2
        ST      R3,SAVE3
        AND     R3,R0,#1    ;Check to see if number is even
        BRz     NOTP
        ;AND     R3,R0,#5    ;Check to see if divisible by 5
        ;ADD     R3,R3,#-5
        ;BRz     Five
        ;BRnp    Cont
        ;ADD     R3,R0,#-5
        ;BRz     ISP
        ;BRp     NOTP
        ADD     R3,R0,#-1   ;Check to see if R0 <= 1
        BRnz    NOTP
        
Cont    AND     R1,R1,#0
        ADD     R1,R1,#-3   ;R1 will be the divider
        

;Start of loop to check if R2 is a factor of R1 (R2)        
LOOP    AND     R3,R3,#0
        ADD     R3,R1,R1
        ADD     R3,R3,R0
        BRnz    ISP
        AND     R2,R2,#0
        ADD     R2,R2,R0    ;R2 will the divided (our number input)
;We subtract the divider from the divided until we either reach a negtive rest or 0
DIVIDE  ADD     R2,R2,R1    
        BRp     DIVIDE      
        BRz     NOTP        ;If rest = 0, R0 is not a prime
        ADD     R1,R1,#-2   ;If rest < 0, we continue with a higher (uneven) divider (--)
        BRnzp   LOOP        ;If divider > 1 (negative of R2), we continue loop
 
 
NOTP    AND     R0,R0,#0
        BRnzp   REST
        
ISP     AND     R0,R0,#0
        ADD     R0,R0,#1
        BRnzp   REST

REST    LD      R1,SAVE1
        LD      R2,SAVE2
        LD      R3,SAVE3
        RET

TEST    .FILL #32377
SAVE1   .BLKW 1
SAVE2   .BLKW 1
SAVE3   .BLKW 1

        .END