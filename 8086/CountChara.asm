assume cs:code, ds:data

data segment
	m db 10,13, "Enter the string: $"
	str db 100 dup("$")
	one db 100 dup("$")
	two db 100 dup("$")
	three db 100 dup("$")
	o db 10,13, "One: $"
	t db 10,13, "Two: $"
	th db 10,13, "Three: $"
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea si,one
	mov byte ptr[si],'0'
	inc si
	mov byte ptr[si],'$'
	
	lea si,two
	mov byte ptr[si],'0'
	inc si
	mov byte ptr[si],'$'
	
	lea si,three
	mov byte ptr[si],'0'
	inc si
	mov byte ptr[si],'$'
	
	lea dx,m
	mov ah,09h
	int 21h
	
	lea si,str
read:	mov ah,01h
	int 21h
	cmp al,13
	je last
	mov [si],al
	inc si
	jmp read
last:	mov byte ptr[si],20h
	inc si
	mov byte ptr[si],'$'
	
	mov cl,00
	lea si,str
	cmp byte ptr[si],'$'
	je exit
l1:	cmp byte ptr[si],20h
	je compe
	inc si
	inc cl
	cmp byte ptr[si],'$'
	je print
	jmp l1
	
compe:	cmp cl,1
	je one1
	cmp cl,2
	je two1
	cmp cl,3
	je three1
	mov cl,00
	inc si
	jmp l1


print:	lea dx,o
	mov ah,09h
	int 21h
	
	lea dx,one
	mov ah,09h
	int 21h
	
	lea dx,t
	mov ah,09h
	int 21h
	
	lea dx,two
	mov ah,09h
	int 21h
	
	lea dx,th
	mov ah,09h
	int 21h
	
	lea dx,three
	mov ah,09h
	int 21h
	
exit:	mov ah,4ch
	int 21h
	
one1:	lea di,one
	mov al,[di]
	inc al
	mov [di],al
	mov cl,00
	jmp l1
	
two1:	lea di,two
	mov al,[di]
	inc al
	mov [di],al
	mov cl,00
	jmp l1
	
three1:	
	lea di,three
	mov al,[di]
	inc al
	mov [di],al
	mov cl,00
	jmp l1
	
code ends
end start
