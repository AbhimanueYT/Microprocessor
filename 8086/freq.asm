assume cs:code, ds:data

data segment
	m db 10,13, "Enter the string: $"
	m1 db 10,13, "Enter the word: $"
	r db 10,13, "Result: $"
	str db 100 dup(?)
	str1 db 100 dup(?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m
	mov ah,09h
	int 21h
	
	lea si,str
	
read:	mov ah,01h
	int 21h
	cmp al,13
	je dol
	mov [si],al
	inc si
	jmp read
dol:	mov byte ptr[si],20h
	inc si	
	mov byte ptr[si],'$'


	lea dx,m1
	mov ah,09h
	int 21h
	
	lea si,str1
	
read1:	mov ah,01h
	int 21h
	cmp al,13
	je dol1
	mov [si],al
	inc si
	jmp read1
dol1:	mov byte ptr[si],20h
	inc si	
	mov byte ptr[si],'$'
	
	
	
	mov cl,0	
	lea di,str
	lea si,str1
	cmp byte ptr[si],'$'
	je exit
l2:	cmp byte ptr[di],'$'
	je exit
	mov al,[si]
	cmp [di],al
	je cou
	inc di
	lea si,str1
	jmp l2
cou:	inc si
	inc di
	cmp byte ptr[si],'$'
	jne l2
	inc cl
	lea si,str1
	jmp l2
	
exit:	lea dx,r
	mov ah,09h
	int 21h
	
	add cl,30h
	mov dl,cl
	mov ah,02h
	int 21h
	
	mov ah,4ch
	int 21h

code ends
end start
