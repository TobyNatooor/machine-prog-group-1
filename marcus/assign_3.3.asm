        .ORIG x3000
        
        LD      R0,TEST
        JSR     ISPRIME
        HALT

;===============================================;
;                                               ;
;Function for checking if number in R0 is prime ;
;                                               ;
;===============================================;

        
ISPRIME ST      R1,SAVE1
        ST      R2,SAVE2
        ST      R3,SAVE3
        AND     R3,R0,#1    ;Check to see if number is uneven
        BRz     NOTP
        ADD     R3,R0,#-1   ;Check to see if R0 <= 1
        BRnz    NOTP
        
;We set R1 to be the divisor. Since we will divide, by subtracting the divisor from divident 
;until we reach zero or a negativ number, the divisor (R1) will be the negativ value, of the amount
;we wish to divide with.
;Since we know it's an uneven number, we will start by dividing by 3. 
        AND     R1,R1,#0
        ADD     R1,R1,#-3 
        

;-----
;#### Start of loop to check if R0 is prime ####
;-----

;First we check if the divisor (R1) is greater than half of R0 rounded down, since anything greater will 
;never be a factor.
;If R1 is greater, it means we have divided R0, with everything below, and didn't find a factor, and
;and therefor R0 is a primenumber.
LOOP    AND     R3,R3,#0
        ADD     R3,R1,R1
        ADD     R3,R3,R0
;Since R1 is negativ, then if R1+R1+R0 <= 0, it means the divisor (R1) is greater than half of divident (R0)
        BRnz    ISP 
        AND     R2,R2,#0
        ADD     R2,R2,R0
        
;Start of division
;We subtract the divisor from divident until we either reach a negtive rest or 0
DIVIDE  ADD     R2,R2,R1    
        BRp     DIVIDE      
        BRz     NOTP        ;If rest = 0, R0 is not a prime
        ADD     R1,R1,#-2   ;If rest < 0, we continue with a higher (uneven) divider (--)
        BRnzp   LOOP        
 
 
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