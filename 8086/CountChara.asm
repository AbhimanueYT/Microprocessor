data segment
    m db 10,13, "Enter the string: $"    ; Message prompting the user to input a string
    str db 100 dup("$")                  ; Buffer to store the user-input string
    one db 100 dup("$")                  ; Buffer to count words of length 1
    two db 100 dup("$")                  ; Buffer to count words of length 2
    three db 100 dup("$")                ; Buffer to count words of length 3
    o db 10,13, "One: $"                 ; Message prefix for "One"
    t db 10,13, "Two: $"                 ; Message prefix for "Two"
    th db 10,13, "Three: $"              ; Message prefix for "Three"
data ends

code segment
start:
    ; Initialize data segment
    mov ax, data
    mov ds, ax

    ; Initialize "one" counter to "0$"
    lea si, one
    mov byte ptr [si], '0'               ; Set first byte of "one" to '0'
    inc si
    mov byte ptr [si], '$'               ; Terminate with '$'

    ; Initialize "two" counter to "0$"
    lea si, two
    mov byte ptr [si], '0'               ; Set first byte of "two" to '0'
    inc si
    mov byte ptr [si], '$'               ; Terminate with '$'

    ; Initialize "three" counter to "0$"
    lea si, three
    mov byte ptr [si], '0'               ; Set first byte of "three" to '0'
    inc si
    mov byte ptr [si], '$'               ; Terminate with '$'

    ; Display the input prompt
    lea dx, m
    mov ah, 09h                          ; DOS interrupt to display string
    int 21h

    ; Read user input string
    lea si, str
read:
    mov ah, 01h                          ; DOS interrupt to read a character
    int 21h
    cmp al, 13                           ; Check if Enter (Carriage Return) is pressed
    je last                              ; If yes, end input
    mov [si], al                         ; Store the character in the string buffer
    inc si                               ; Move to the next position
    jmp read                             ; Repeat the read loop

last:
    mov byte ptr [si], 20h               ; Replace Enter with a space (end of last word)
    inc si
    mov byte ptr [si], '$'               ; Terminate string with '$'

    ; Initialize word length counter
    mov cl, 00
    lea si, str                          ; Point to the start of the string

    cmp byte ptr [si], '$'               ; Check if string is empty
    je exit                              ; If yes, exit program

l1:                                      ; Loop to process each word
    cmp byte ptr [si], 20h               ; Check if the current character is a space
    je compe                             ; If yes, evaluate word length
    inc si                               ; Move to the next character
    inc cl                               ; Increment word length counter
    cmp byte ptr [si], '$'               ; Check for end of string
    je print                             ; If yes, print results
    jmp l1                               ; Otherwise, continue loop

compe:
    cmp cl, 1                            ; Check if word length is 1
    je one1                              ; If yes, increment "one" counter
    cmp cl, 2                            ; Check if word length is 2
    je two1                              ; If yes, increment "two" counter
    cmp cl, 3                            ; Check if word length is 3
    je three1                            ; If yes, increment "three" counter
    mov cl, 00                           ; Reset word length counter
    inc si                               ; Move past the space
    jmp l1                               ; Continue loop

print:
    ; Display "One:" and its count
    lea dx, o
    mov ah, 09h
    int 21h
    lea dx, one
    mov ah, 09h
    int 21h

    ; Display "Two:" and its count
    lea dx, t
    mov ah, 09h
    int 21h
    lea dx, two
    mov ah, 09h
    int 21h

    ; Display "Three:" and its count
    lea dx, th
    mov ah, 09h
    int 21h
    lea dx, three
    mov ah, 09h
    int 21h

exit:
    mov ah, 4ch                          ; DOS interrupt to terminate program
    int 21h

one1:
    lea di, one                          ; Point to "one" buffer
    mov al, [di]                         ; Get current count
    inc al                               ; Increment count
    mov [di], al                         ; Store updated count
    mov cl, 00                           ; Reset word length counter
    jmp l1                               ; Continue loop

two1:
    lea di, two                          ; Point to "two" buffer
    mov al, [di]                         ; Get current count
    inc al                               ; Increment count
    mov [di], al                         ; Store updated count
    mov cl, 00                           ; Reset word length counter
    jmp l1                               ; Continue loop

three1:
    lea di, three                        ; Point to "three" buffer
    mov al, [di]                         ; Get current count
    inc al                               ; Increment count
    mov [di], al                         ; Store updated count
    mov cl, 00                           ; Reset word length counter
    jmp l1                               ; Continue loop

code ends
end start
