data segment
    m1 db 10,13, "Enter the value: $" ; Message to prompt the user to enter a value
    result db 10 dup(?)               ; Reserve 10 bytes of space for storing the result
    r db 10,13, "Result: $"           ; Message to display the result
data ends

code segment
start:
    mov ax, data     ; Load the address of the data segment into AX
    mov ds, ax       ; Move the address of the data segment into DS

    lea dx, m1       ; Load the address of the prompt message into DX
    mov ah, 09h      ; DOS interrupt to display a string
    int 21h          ; Call DOS interrupt

    mov ah, 01h      ; DOS interrupt to take a single character input
    int 21h          ; Call DOS interrupt
    mov bh, al       ; Store the first input character in BH

    mov ah, 01h      ; DOS interrupt to take another single character input
    int 21h          ; Call DOS interrupt
    mov bl, al       ; Store the second input character in BL

    mov cl, 0        ; Initialize CL to 0 (this will serve as a loop counter)

next: 
    inc cl           ; Increment CL by 1
    mov ax, 0        ; Clear AX
    mov al, cl       ; Copy CL into AL
    mul al           ; Multiply AL by itself (square of CL)
    mov dx, ax       ; Move the result (square) into DX

    cmp dl, 9        ; Check if the lower byte of DX is less than or equal to 9
    jbe che          

rap: 
    sub dl, 0Ah      ; Subtract 10 from DL if greater than 9 (for hexadecimal adjustment)
    inc dh           ; Increment DH to handle overflow
    cmp dl, 9        ; Check if DL is still greater than 9
    ja rap           ; Repeat if DL > 9

che: 
    add dx, 3030h    ; Convert the result to ASCII format for comparison
    cmp dx, bx       ; Compare the computed square with the user's input
    je pt            ; If equal, jump to the print section
    ja pt1           ; If greater, jump to the decrement section
    cmp cl, 9        ; Check if CL is less than or equal to 9
    jbe next         ; If so, loop back to the next iteration

pt1: 
    dec cl           ; Decrement CL (used to adjust for overshoot)

pt: 
    add cl, 30h      ; Convert CL to ASCII format
    lea dx, r        ; Load the address of the result message
    mov ah, 09h      ; DOS interrupt to display a string
    int 21h          ; Call DOS interrupt

    mov dl, cl       ; Load the final result character into DL
    mov ah, 02h      ; DOS interrupt to display a single character
    int 21h          ; Call DOS interrupt

    mov ah, 4ch      ; DOS interrupt to terminate the program
    int 21h          ; Call DOS interrupt

code ends
end start
