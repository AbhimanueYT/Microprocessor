lxi h,5000h        ; Initialize HL register pair to point to memory location 5000h
mov c,m            ; Load the value at memory location 5000h into register C (number of terms in Fibonacci series)
mvi a,0            ; Load 0 into accumulator A (used for the Fibonacci calculation)
inx h              ; Increment HL to point to the next memory location (5001h)
mov m,a            ; Store 0 (first term of Fibonacci series) at memory location 5001h
mvi b,1            ; Load 1 into register B (second term of Fibonacci series)
mov d,a            ; Clear register D by moving 0 from A
add b              ; Add B (1) to accumulator A, now A contains 1 (next term)
mov b,d            ; Update B with the previous value of D (which is 0)
mov d,a            ; Update D with the value of A (which is 1)
call fab           ; Call the Fibonacci calculation subroutine
hlt                ; Halt the program

; Subroutine to generate the Fibonacci series
tab:	inx h              ; Increment HL to point to the next memory location
	mov m,d           ; Store the current Fibonacci term (D) at the memory location pointed by HL
	mov d,a           ; Update D with the previous value of A
	add b             ; Add B (previous term) to A (current term) to calculate the next term
	mov b,d           ; Update B with the value of D (previous term)
	mov d,a           ; Update D with the value of A (next term)
	dcr c             ; Decrement the count of terms to be generated (C)
	jnz fab           ; If C is not zero, jump to the start of the subroutine to continue generating terms
	ret               ; Return from the subroutine to the main program
