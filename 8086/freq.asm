assume cs:code, ds:data

data segment
	m db 10,13, "Enter the string: $"
	m1 db 10,13, "Enter the word: $"
	m2 db 10,13, "Word to be replaced: $"
	r db 10,13, "Result: $"
	str db 100 dup(?)
	str1 db 100 dup(?)
	str2 db 100 dup(?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m
	mov ah,09h
	int 21h
	
	lea si,str
	call read



	lea dx,m1
	mov ah,09h
	int 21h
	
	lea si,str1
	call read
	
	
	
	lea dx,m2
	mov ah,09h
	int 21h
	
	lea si,str2
	call read
	
	
	mov cl,0	
	lea di,str
	lea si,str1
	cmp byte ptr[si],'$'
	call exi
l2:	cmp byte ptr[di],'$'
	call exi
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
	call repl
	lea si,str1
	jmp l2
		

repl:	mov ch,0
	lea si,str1
l3:	inc si
	inc ch
	cmp byte ptr[si],'$'
	jne l3
inf:	dec di
	dec ch
	jnz inf
	lea si,str2
l4:	mov al,[si]
	mov [di],al
	inc si
	inc di
	cmp byte ptr[di],20h
	je l6
	cmp byte ptr[si],20h
	jne l4
	cmp byte ptr[di],20h
	jne l5
lef:	ret


l5:	mov si,di
re1:	mov al,[si+1]
	mov [si],al
	inc si
	cmp byte ptr[si],'$'
	jne re1
	jmp lef

	
l6:	cmp byte ptr[si],20h
	je lef
	mov bx,si
	mov si,di
re2:	inc si
	cmp byte ptr[si],'$'
	jne re2
	mov byte ptr[si+1],'$'
re3:	mov al,[si-1]
	mov [si],al
	dec si
	cmp si,di
	jne re3
	mov si,bx
	mov byte ptr[di],'X'
	jmp l4	

	
	
exit:	lea dx,r
	mov ah,09h
	int 21h
	
	add cl,30h
	mov dl,cl
	mov ah,02h
	int 21h
	
	lea dx,r
	mov ah,09h
	int 21h
	
	lea dx,str
	mov ah,09h
	int 21h
	
	mov ah,4ch
	int 21h

exi:	je exit
	ret

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
	ret


code ends
end start
