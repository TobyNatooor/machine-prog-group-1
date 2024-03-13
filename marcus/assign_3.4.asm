        .ORIG x3000
        
        LD R0,Test
        JSR resultS
        HALT
        
resultS ADD R0,R0,#0
        BRnp N1
        LEA R0,IsP
        PUTS
        BRnzp N2
N1      LEA R0,NotP
        PUTS
N2      RET

IsP     .STRINGZ "The number is prime\n"
NotP    .STRINGZ "The number is not prime\n"

Test    .FILL #0

        .END