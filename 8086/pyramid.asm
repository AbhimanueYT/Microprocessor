assume cs:code, ds:data

data segment
	m1 db 10,13, "Enter the number: $"
	spac db " $"
	ente db 10,13, "$"
	h db 10,13, "H! $"
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
	mov bl,al
	
	lea dx,ente
	mov ah,09h
	int 21h
	
	sub bl,30h
	mov cl,bl
	mov ch,0
	
n2:	dec cl
	call gap
n1:	cmp ch,bl
	je exit
	inc ch
	call print
	lea dx,ente
	mov ah,09h
	int 21h
	cmp cl,0
	je exit
	jmp n2
	
exit:	mov ah,4ch
	int 21h


gap:	mov al,cl
l1:	cmp al,0
	je n1
	lea dx,spac
	mov ah,09h
	int 21h
	dec al
	jnz l1
	ret
	
print:	mov bh,ch
l2:	add ch,30h
	mov dl,ch
	mov ah,02h
	int 21h
	sub ch,30h
	lea dx,spac
	mov ah,09h
	int 21h
	dec bh
	cmp bh,0
	jne l2
	ret

code ends
end start	
