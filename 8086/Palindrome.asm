assume cs:code, ds:data

data segment
	m1 db 10,13, "Enter the string: $"       ; Prompt message to enter a string
	str db 100 dup(?)                          ; Input string buffer, uninitialized
	r db 10,13, "Result: $"                   ; Output message for the result
	str1 db 100 dup(?)                         ; Temporary buffer to store a substring

data ends

stack segment stack
	db 100 dup(?)                              ; Stack segment with 100 bytes
stack ends

code segment
start:
	mov ax,data                               ; Initialize data segment
	mov ds,ax
	
	lea dx,m1                                 ; Load address of prompt message
	mov ah,09h                                ; DOS interrupt to display string
	int 21h
	
	lea si,str                                ; Load address of input string buffer
	call read                                 ; Call the `read` procedure to get input

	lea si,str                                ; Initialize source pointer to input string
	lea di,str1                               ; Initialize destination pointer for substring
	mov cl,0                                  ; Initialize palindrome counter to 0

l1:                                          ; Loop to process the input string
	mov al,[si]                               ; Load the current character from the input string
	mov [di],al                               ; Copy the character to the temporary buffer
	inc si                                    ; Increment source pointer
	inc di                                    ; Increment destination pointer
	cmp byte ptr[si],'$'                      ; Check if end of string is reached
	je exit1                                  ; If yes, exit the loop
	cmp byte ptr[si],20h                      ; Check if the character is a space
	jne l1                                    ; If not a space, continue copying
	
	mov bx,si                                 ; Save the current position in the input string
	mov byte ptr[di],'$'                      ; Null-terminate the substring
	call palin                                ; Call `palin` to check if the substring is a palindrome
	mov si,bx                                 ; Restore the position in the input string
	inc si                                    ; Skip the space character
	cmp byte ptr[si],'$'                      ; Check if the end of the string is reached
	je exit1                                  ; If yes, exit the loop
	lea di,str1                               ; Reset the destination pointer
	jmp l1                                    ; Continue processing

exit1:                                       ; Exit point of the program
	lea dx,r                                  ; Load address of result message
	mov ah,09h                                ; DOS interrupt to display string
	int 21h
	
	add cl,30h                                ; Convert the palindrome counter to ASCII
	mov dl,cl                                 ; Load the counter into DL
	mov ah,02h                                ; DOS interrupt to display a character
	int 21h
	
	mov ah,4ch                                ; Terminate the program
	int 21h

; Subroutine to read a string from the user
read:   mov ah,01h                           ; DOS interrupt to read a character
	int 21h
	cmp al,13                                ; Check if the Enter key (Carriage Return) is pressed
	je dol                                   ; If yes, jump to termination
	mov [si],al                              ; Store the character in the input buffer
	inc si                                   ; Increment the buffer pointer
	jmp read                                 ; Continue reading

dol:    mov byte ptr[si],20h                ; Add a space at the end of the input
	inc si                                   ; Increment the buffer pointer
	mov byte ptr[si],'$'                     ; Null-terminate the string
	ret                                     ; Return to the caller

; Subroutine to check if a substring is a palindrome
palin:  lea di,str1                          ; Load the address of the substring

into1:  cmp byte ptr[di],'$'                ; Check for the end of the substring
	je ex1                                   ; If end, proceed to palindrome check
	inc di                                   ; Increment the pointer
	jmp into1                                ; Continue moving to the end

ex1:    lea si,str1                          ; Reset source pointer to the start of the substring
	dec di                                   ; Adjust destination pointer to the last character

l6:     cmp di,si                           ; Check if pointers have crossed
	jl l5                                    ; If yes, substring is a palindrome
	
	mov al,[si]                              ; Load character from the start
	cmp [di],al                              ; Compare with character from the end
	jne retu                                 ; If not equal, substring is not a palindrome
	inc si                                   ; Move start pointer forward
	dec di                                   ; Move end pointer backward
	jmp l6                                   ; Continue checking

l5:     inc cl                               ; Increment the palindrome counter

retu:   ret                                  ; Return to the caller

code ends
end start
