assume cs:code, ds:data

data segment
	m1 db 10,13, "Enter the string: $"
	str db 100 dup(?)
	r db 10,13, "Result: $"
	str1 db 100 dup(?)
data ends

stack segment stack
	db 100 dup(?)
stack ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m1
	mov ah,09h
	int 21h
	
	lea si,str
	call read

	
	lea si,str
	lea di,str1
	mov cl,0
l1:	mov al,[si]
	mov [di],al
	inc si
	inc di
	cmp byte ptr[si],'$'
	je exit1
	cmp byte ptr[si],20h
	jne l1
	mov bx,si
	mov byte ptr[di],'$'
	call palin
	mov si,bx
	inc si
	cmp byte ptr[si],'$'
	je exit1
	lea di,str1
	jmp l1
	
exit1:	lea dx,r
	mov ah,09h
	int 21h
	
	add cl,30h
	mov dl,cl
	mov ah,02h
	int 21h
	
	mov ah,4ch
	int 21h
		
	
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
	
	
palin:	lea di,str1	
into1:	cmp byte ptr[di],'$'
	je ex1
	inc di
	jmp into1
	
ex1:	lea si,str1
	dec di
	
l6:	cmp di,si
	jl l5
	
	mov al,[si]
	cmp [di],al
	jne retu
	inc si
	dec di
	jmp l6
l5:	inc cl

retu:	ret			
	
code ends
end start
