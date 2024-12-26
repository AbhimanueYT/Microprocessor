assume cs:code, ds:data

stack segment stack
	dw 128 dup(?)
stack ends

data segment
	m db 10,13,"Enter value $"
	r db 10,13,"Result $"
	num1 db 20("$")
	num2 db 20("$")
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
		
		mul al
		mov bx,ax
		
		lea dx,r
		mov ah,09h
		int 21h
		
		mov ax,bx
		
		mov cx,0
		mov bx,10
	d:	mov dx,0
		div bx
		push dx
		inc cx
		test ax,ax
		jnz d 	
		
		mov cx,0
	p:	pop dx
		add dl,'0'
		mov num1[cx],dl
		inc cx
		loop p		
		
		lea dx,num1
		mov ah,09h
		int 21h
		
		lea dx,m
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		sub al,'0'
		
		mul al
		mov bx,ax
		
		lea dx,r
		mov ah,09h
		int 21h
		
		mov ax,bx
		
		mov cx,0
		mov bx,10
	d1:	mov dx,0
		div bx
		push dx
		inc cx
		test ax,ax
		jnz d1
		
	p1:	pop dx
		add dl,'0'
		mov num2,dl
		loop p1			
		
		lea dx,num2
		mov ah,09h
		int 21h
			
		
		mov ah,4ch
		int 21h
		
	code ends
	end start
