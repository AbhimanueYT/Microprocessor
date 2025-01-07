assume cs:code, ds:data

data segment
	m db 10,13, "Enter the number: $"
	n db 100 dup(?)
	sum db 100 dup(?)
	r db 10,13, "Result: $"
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m
	mov ah,09h
	int 21h
	
	lea si,n
read:	mov ah,01h
	int 21h
	cmp al,13
	je exit
	mov [si],al
	inc si
	jmp read
exit:	mov byte ptr[si],'$'
	
	lea dx,r
	mov ah,09h
	int 21h

	lea si,n
	cmp byte ptr[si],'$'
	je exit1
	mov cx,0000
l1:	mov ax,0000
	mov bx,0000
	mov bl,[si]
	sub bl,30h
	mov al,bl
	
	mul bl
	mul bl
	
	add cx,ax
	inc si
	cmp byte ptr[si],'$'
	je cont
	jmp l1
	
cont:	mov bx,cx
	mov ax,bx
	
	lea di,sum
	
	mov dx,0f000h
	and ax,dx
	mov cl,12
	ror ax,cl
	call conv
	mov ax,bx
	mov dx,00f00h
	and ax,dx
	mov cl,8
	ror ax,cl
	call conv
	mov ax,bx
	mov dx,000f0h
	and ax,dx
	mov cl,4
	ror ax,cl
	call conv
	mov ax,bx
	mov dx,0000fh
	and ax,dx
	mov cl,0
	ror ax,cl
	call conv
	
	mov byte ptr[di],'$'
	
	
	
	lea dx,sum
	mov ah,09h
	int 21h
	
exit1:	mov ah,4ch
	int 21h
	
conv:	
	cmp al,9h
	jbe r1
	add al,07h
r1:	add al,30h
	mov [di],al
	inc di
	ret
	
	
code ends
end start
