; Write a function called “isPrime” that takes as argument a number (with the decimal value
; between 0 and 99) stored in R0 and returns value 1 if the number is prime and value 0 if the
; number if not prime. The return value is also stored in register R0.
; Hint: There are several ways this function could be implemented. Here are a few
; suggestions:
;   1.  Calculate if the number is prime at runtime. In other words you have to divide the
;       number with the numbers smaller than itself and see if the rest of any such divisions is
;       0. This solution is very flexible because it can also work with numbers bigger than 99.
;   2.  Store all the prime numbers between 0 and 99 in an array and check if the number
;       given as argument to the function is equal with any of the numbers from the array
;       This solution is easier to implement than solution one and the size of the array used to
;       store the values is not that big.
;   3.  Create an array with 100 elements. At every index in the array we store the value 1 if
;       the number representing the index is prime and 0 if the value representing the index is
;       not prime. For example if the array is called “Primes” then Primes[1]=1, Primes[7]=1,
;       Primes[6]=0 etc. All we need to do is to use the input argument as an index for the
;       array and return the value stored in the array at that index. This solution is very easy
;       to implement but it wastes lots of memory and it scales very badly.
; Note: In your solution you can create several implementations for this function if you want to
; improve your assembly programming skills.

.ORIG x3000
        AND R0, R0, x0
        ADD R0, R0, #7
        JSR isPrime
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #3
        JSR isPrime
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #10
        JSR isPrime
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #13
        JSR isPrime
        JSR resultS
        AND R0, R0, x0
        ADD R0, R0, #8
        JSR isPrime
        JSR resultS
        HALT

isPrime AND R1, R1, x0
        ADD R1, R1, R0
ALL_NUM ADD R1, R1, #-1
        ADD R4, R1, #-1
        BRz PRIME
        AND R2, R2, x0
ONE_NUM ADD R2, R2, R1
        AND R3, R3, x0
        ADD R3, R3, R2
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R0
        BRn ALL_NUM 
        BRp ONE_NUM
        BRz NOT_PRI
PRIME   AND R0, R0, x0
        ADD R0, R0, #1
        RET
NOT_PRI AND R0, R0, x0
        RET

resultS AND R1, R1, x0
        ADD R1, R1, #1
        AND R1, R1, R0
        BRz NOT_P
        LEA R0, IS_P_STR
        PUTS
        RET
NOT_P   LEA R0, NO_P_STR
        PUTS
        RET
        
IS_P_STR .STRINGZ "The number is prime\n"
NO_P_STR .STRINGZ "The number is not prime\n"
.END
