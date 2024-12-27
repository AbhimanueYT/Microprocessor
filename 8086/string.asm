assume cs:code, ds:data

stack segment stack
	dw 128 dup(?)
stack ends

data segment
	st1 db 20 dup(?)
	st2 db 20 dup(?)
	st3 db 20 dup(?)
	m1 db 10,13,"Enter string :$"
	m2 db 10,13,"Select string :$"
	m3 db 10,13,"Enter new string :$"
	r db 10,13,"Result :$"
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m1
	mov ah,09h
	int 21h
	
	lea si,st1
	call r2
	
	lea dx,m2
	mov ah,09h
	int 21h
	
	lea si,st2
	call r2

	lea dx,m3
	mov ah,09h
	int 21h
	
	lea si,st3
	call r2
	
	lea dx,r
	mov ah,09h
	int 21h
	
	mov ch,0
	mov bl,0
	lea si,st1
	lea di,st2
ra:	cmp byte ptr[si],'$'
	je exit
	mov al,[di]
	cmp byte ptr[si],al
	jne incr
	push si
	inc ch
	inc di
	jmp incr1
incr:	test ch,ch
	jnz its
incr1:	inc si
	jmp ra	
its:	cmp byte ptr[di],'$'
	je its1
dele:	pop si
	loop dele
	lea di,st2
	mov ch,0
	jmp incr
	
its1:	lea di,st2
	add bl,ch
	mov ch,0
	jmp incr
	
last:	cmp byte ptr[di],'$'
	je last1
dele1:	pop si
	loop dele1
	mov ch,0
	jmp exit
	
last1:	lea di,st2
	add bl,ch
	mov ch,0
	
exit:	test ch,ch
	jnz last
	test bl,bl
	jnz place
	lea dx,st1
	mov ah,09h
	int 21h
	lea dx,st1
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h
place:	lea di,st3
pla1:	cmp byte ptr[di],'$'
	je cont
	inc di
	jmp pla1
cont:	dec di
	mov cl,bl
pl1:	pop si
	mov al,[di]
	mov [si],al
	dec di
	loop pl1
print:	lea dx,st1
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h


r2:	mov ah,01h
	int 21h
	cmp al,13
	je re2
	mov [si],al
	inc si
	loop r2
re2:	mov byte ptr[si],'$'
	ret
		
code ends
end start
