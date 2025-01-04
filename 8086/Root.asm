assume cs:code, ds:data

data segment
	m1 db 10,13, "Enter the value: $"
	result db 10 dup(?)
	r db 10,13, "Result: $"
data ends

code segment
	start:
		mov ax,data
		mov ds,ax
		
		lea dx,m1
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		mov bh,al
		
		mov ah,01h
		int 21h
		mov bl,al
		
		
		mov cl,0
	next:	inc cl
		mov ax,0
		mov al,cl
		mul al
		mov dx,ax
		cmp dl,9
		jbe che
	rap:	sub dl,0Ah
		inc dh
		cmp dl,9
		ja rap
	che:	add dx,3030h
		cmp dx,bx
		je pt
		ja pt1
		cmp cl,9
		jbe next
		
		
	pt1:	dec cl
	pt:	add cl,30h
		lea dx,r
		mov ah,09h
		int 21h

		mov dl,cl
		mov ah,02h
		int 21h
		
		mov ah,4ch
		int 21h


code ends
end start		
		
