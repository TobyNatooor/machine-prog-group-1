        .ORIG x3000
        
        LEA R0,out1
        PUTS
        JSR readS
        JSR isPrime
        JSR resultS
        
        HALT
        
out1    .STRINGZ "Input a 2 digit decimal number: \n"


;===============================================;
;                                               ;
;READ FUNCTION + ERROR MESSAGE IF NOT DIGIT     ;
;BETWEEN 0-9                                    ;
;                                               ;
;===============================================;
                                               
readS   ST R1,save1
        ST R2,save2
        ST R3,save3
        AND R1,R1,#0
        AND R2,R2,#0
        LD R3,ASCII
        ST R7,save7
in1     TRAP x23
        JSR check
        BRn in1
        LD R7,save7
        ADD R0,R0,R3
        BRnzp tenX
contR   ADD R1,R1,R2
        LD R3,ASCII
        ST R7,save7
in2     TRAP x23
        JSR check
        BRn in2
        LD R7,save7
        ADD R0,R0,R3
        ADD R0,R0,R1
        LD R1,save1
        LD R2,save2
        LD R3,save3
        RET
    

tenX    AND R3,R3,#0
        ADD R3,R3,#10
loopX   ADD R2,R2,R3
        BRz contR
        ADD R0,R0,#-1
        BRp loopX
        BRnz contR

check   ST R0,save0
        ST R1,save1
        ST R2,save2
        LD R1, upper
        ADD R2,R0,R1
        BRp err
        LD R1, ASCII
        ADD R2,R0,R1
        BRn err
        LD R1,save1
        LD R2,save2
        ADD R0,R0,#0
        RET
        
err     LEA R0,msg
        PUTS
        LD R1,save1
        LD R2,save2
        AND R0,R0,#0
        ADD R0,R0,#-1
        RET
        
upper   .FILL #-57
msg     .STRINGZ "Input must be a digit between 0-9\n"

ASCII   .FILL #-48


;===============================================;
;                                               ;
;Function for checking if number is prime       ;
;                                               ;
;===============================================;

;First checks to see if number is even. Then proceeds to divide given number(R2<-R0),
;with each uneven number (R1) until (-R1) + (-R1) + 3 < R2 
        
isPrime ST      R1,save1
        ST      R2,save2
        ST      R3,save3
        AND     R3,R0,#1    ;Check to see if number is even
        BRz     notP
        ADD     R3,R0,#-1   ;Check to see if R0 <= 1
        BRnz    notP
        
cont    AND     R1,R1,#0
        ADD     R1,R1,#-3   ;R1 will be the divider
        

;Start of loop to check if R2 is a factor of R1 (R2)        
loopP   AND     R3,R3,#0
        ADD     R3,R1,R1
        ADD     R3,R3,R0
        BRnz    isP
        AND     R2,R2,#0
        ADD     R2,R2,R0    ;R2 will the divided (our number input)
;We subtract the divider from the divided until we either reach a negtive rest or 0
divide  ADD     R2,R2,R1    
        BRp     divide      
        BRz     notP        ;If rest = 0, R0 is not a prime
        ADD     R1,R1,#-2   ;If rest < 0, we continue with a higher (uneven) divider (--)
        BRnzp   loopP       ;If divider > 1 (negative of R2), we continue loop
 
 
notP    AND     R0,R0,#0
        BRnzp   rest
        
isP     AND     R0,R0,#0
        ADD     R0,R0,#1
        BRnzp   rest

rest    LD      R1,save1
        LD      R2,save2
        LD      R3,save3
        RET
        
;===============================================;
;                                               ;
;DISPLAY RESULT FUNCTION                        ;
;                                               ;
;===============================================;
resultS ADD R0,R0,#0
        BRnp n1
        LEA R0,notPr
        PUTS
        BRnzp n2
n1      LEA R0,isPr
        PUTS
n2      RET

isPr    .STRINGZ "The number is prime\n"
notPr   .STRINGZ "The number is not prime\n"



;FOR SAVING REGISTER VALUES
save0   .BLKW 1
save1   .BLKW 1
save2   .BLKW 1
save3   .BLKW 1
save4   .BLKW 1
save5   .BLKW 1
save6   .BLKW 1
save7   .BLKW 1

        .END