data segment
    ; Messages and buffers for input and output
    m1 db 10,13, "Enter the value: $"   ; Message prompting user to enter values
    re db 10,13, "Prime: $"             ; Message indicating prime numbers
    su db 10,13, "Sum: $"               ; Message indicating sum of prime numbers
    s db 10 dup(?)                      ; Buffer for storing the sum as a string
    n db 100 dup(?)                     ; Buffer for input numbers
    r db 100 dup(?)                     ; Buffer for storing prime numbers
data ends

stack segment stack
    db 100 dup(?)                       ; Stack segment
stack ends

code segment
start:
    ; Initialize data segment
    mov ax, data
    mov ds, ax

    ; Display the prompt message
    lea dx, m1
    mov ah, 09h
    int 21h

    ; Read input numbers into the buffer `n`
    lea si, n
read:
    mov ah, 01h
    int 21h
    cmp al, 13                        ; Check if Enter key (carriage return) is pressed
    je exit                           ; Exit input loop if Enter key is pressed
    cmp al, 20h                       ; Ignore spaces
    je read
    mov [si], al                      ; Store character in buffer
    inc si
    jmp read

exit:
    mov byte ptr [si], '$'            ; Terminate input buffer with '$'

    ; Initialize for prime checking
    mov dl, 0                         ; Initialize prime counter
    lea si, n                         ; Point to input buffer

l1:
    cmp byte ptr [si], '$'            ; Check if end of input buffer
    je last                           ; If end, proceed to next section
    mov bh, [si]                      ; Extract first digit
    inc si
    mov bl, [si]                      ; Extract second digit
    cmp bx, '02'                      ; Check if number is >= 2
    jb no                             ; Skip if less than 2
    je l2                             ; If equal to 2, it's prime
    sub bx, 3030h                     ; Convert ASCII to binary
    cmp bh, 0
    je resu

    ; Convert multi-digit number
loa:
    add bl, 0Ah                       ; Multiply by 10
    dec bh
    jnz loa

resu:
    mov dl, 1                         ; Start dividing from 1
nope:
    inc dl
    cmp dl, bl                        ; Stop if divisor reaches the number
    je l2
    cmp dl, 9                         ; Stop at 9 if no divisors found
    je l2
    mov ax, 00
    mov al, bl                        ; Divide number by dl
    div dl
    cmp ah, 0                         ; Check if remainder is 0
    je no                             ; If divisible, it's not prime
    jmp nope

no:
    ; Mark as not prime
    mov byte ptr [si], 0
    dec si
    mov byte ptr [si], 0
    inc si
    inc si
    jmp l1

l2:
    ; Mark as prime
    push si                           ; Save the position of the number
    inc si
    inc ch                            ; Increment prime count
    jmp l1

last:
    ; Output prime numbers
    lea dx, re
    mov ah, 09h
    int 21h

    ; Calculate sum of primes
    mov cl, ch                        ; Get count of primes
    mov ch, 0
    mov dx, 00                        ; Initialize sum to 0

l5:
    pop si                            ; Retrieve position of number
    mov bl, [si]
    dec si
    mov bh, [si]
    sub bx, 3030h                     ; Convert ASCII to binary
    cmp bh, 0
    je l4
loa1:
    add bl, 0Ah                       ; Multiply by 10
    dec bh
    jnz loa1
l4:
    add dx, bx                        ; Add number to sum
    cmp sp, bp                        ; Check if stack is empty
    je br
    loop l5

br:
    ; Convert sum to ASCII
    mov cl, 0
p1:
    cmp dl, 9
    jbe l6
    sub dl, 0Ah                       ; Reduce by 10
    inc dh                            ; Increment tens place
    jmp p1
l6:
    cmp dh, 9
    jbe l7
    sub dh, 0Ah
    inc cl
    jmp l6
l7:
    add dx, 3030h                     ; Convert back to ASCII
    add cl, 30h
    lea di, s
    mov [di], cl                      ; Store hundreds place
    inc di
    mov [di], dh                      ; Store tens place
    inc di
    mov [di], dl                      ; Store units place
    inc di
    mov byte ptr [di], '$'            ; Terminate with '$'

    ; Copy primes to output buffer `r`
    lea si, n
    lea di, r
l8:
    cmp byte ptr [si], '$'            ; End of input buffer
    je l3
    mov al, [si]                      ; Copy first digit
    mov [di], al
    inc di
    inc si
    mov al, [si]                      ; Copy second digit
    mov [di], al
    inc di
    mov byte ptr [di], 20h            ; Add space
    inc di
    inc si
    jmp l8

l3:
    mov byte ptr [di], '$'            ; Terminate output buffer

    ; Display primes
    lea dx, r
    mov ah, 09h
    int 21h

    ; Display sum
    lea dx, su
    mov ah, 09h
    int 21h

    lea dx, s
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

code ends
end start
