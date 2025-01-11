lxi h,5000h        ; Load HL register pair with the memory address 5000H.
mov a,m            ; Move the value at the memory location pointed by HL into the accumulator (A).
mov d,a            ; Copy the value in accumulator A into register D.
mov b,a            ; Copy the value in accumulator A into register B (used as a counter).

fac: mov c,b       ; Copy the value of register B into register C (inner loop counter).
     dcr c         ; Decrement the value of C.
     jz last       ; If C becomes zero, jump to the label 'last'.
     dcr c         ; Decrement C again.
     call MUL      ; Call the subroutine 'MUL' to perform multiplication.
last: dcr b        ; Decrement B (outer loop counter).
      jnz fac      ; If B is not zero, jump back to the label 'fac'.

inx h              ; Increment the HL register pair to point to the next memory location.
mov m,a            ; Store the value of accumulator A into the memory location pointed by HL.
hlt                ; Halt the execution.

MUL: jz exit       ; If the value in C is zero, jump to 'exit'.
     add d         ; Add the value of register D to the accumulator (A).
     dcr c         ; Decrement C.
     jnz MUL       ; If C is not zero, repeat the MUL loop.
     mov d,a       ; Copy the result in accumulator A into register D.
exit: ret          ; Return to the calling function.
