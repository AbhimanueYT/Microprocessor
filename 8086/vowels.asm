assume cs:code, ds:data

stack segment stack
	dw 128 dup(?)
stack ends

data segment
	m1 db 10,13, "Enter string $"
	vowel db 10,13,"aeiouAEIOU$"
	str db 20 dup(?)
	r db 10,13, "Result $"
data ends

code segment
	start:
		mov ax,data
		mov ds,ax
		
		lea dx,m1
		mov ah,09h
		int 21h
		
		lea si,str
	read:	mov ah,01h
		int 21h
		cmp al,13
		je ext
		mov [si],al
		inc si
		jmp read
	ext:	mov byte ptr[si],'$'
		lea si,str
		lea di,vowel
		mov bl,'0'
		cmp byte ptr[si],'$'
		je retu
	nche:	lea si,str
		mov al,[di]
	check:	cmp byte ptr[si],'$'
		je vnext
		cmp byte ptr[si],al
		jne next
		inc bl
	next:	inc si
		jmp check
	retu:	lea dx,r
		mov ah,09h
		int 21h
		mov dl,bl
		mov ah,02h
		int 21h
		mov ah,4ch
		int 21h
	
	vnext:	cmp byte ptr[di],'$'
		je retu
		inc di
		jmp nche
		
	code ends
	end start
