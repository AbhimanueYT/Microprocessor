assume cs:code, ds:data

stack segment stack
	dw 128 dup(?)
stack ends

data segment
	m db 10,13,"Enter value $"
	r db 10,13,"Result $"
	num1 db 0
	num2 db 0
	re dw 0
data ends

code segment
	start:
		mov ax,data
		mov ds,ax
		
		lea dx,m
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		sub al,'0'
		mov num1,al
		
		lea dx,m
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		sub al,'0'
		
		mul al
		mov bx,ax
		mov al,num1
		mul al
		add ax,bx
		mov re,ax
		
		lea dx,r
		mov ah,09h
		int 21h
		
		mov ax,re
		mov cx,0
		mov bx,10
	d:	mov dx,0
		div bx
		push dx
		inc cx
		test ax,ax
		jnz d
		
		
	p:	pop dx
		add dl,'0'
		mov ah,02h
		int 21h
		loop p
		
		mov ah,4ch
		int 21h
		
	code ends
	end start
