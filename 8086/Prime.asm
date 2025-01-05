assume cs:code, ds:data

data segment
	m1 db 10,13, "Enter the value: $"
	re db 10,13, "Prime: $"
	su db 10,13, "Sum: $"
	s db 10 dup(?)
	n db 100 dup(?)
	r db 100 dup(?)
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
	
	lea si,n
	
read:	mov ah,01h
	int 21h
	cmp al,13
	je exit
	cmp al,20h
	je read
	mov [si],al
	inc si
	jmp read
exit:	mov byte ptr[si],'$'
	
	mov dl,0
	lea si,n
l1:	cmp byte ptr[si],'$'
	je last
	mov bh,[si]
	inc si
	mov bl,[si]
	cmp bx,'02'
	jb no
	je l2
	sub bx,3030h
	cmp bh,0
	je resu
loa:	add bl,0Ah
	dec bh
	jnz loa	

resu:	mov dl,1
nope:	inc dl
	cmp dl,bl
	je l2
	cmp dl,9
	je l2
	mov ax,00
	mov al,bl
	div dl
	cmp ah,0
	je no
	jmp nope
	
	
no:	mov byte ptr[si],0
	dec si
	mov byte ptr[si],0
	inc si
	inc si
	jmp l1
	
l2:	push si
	inc si
	inc ch
	jmp l1
	
	
last:	lea dx,re
	mov ah,09h
	int 21h
	
	mov cl,ch
	mov ch,0
	mov dx,00
l5:	pop si
	mov bl,[si]
	dec si
	mov bh,[si] 
	sub bx,3030h
	cmp bh,0
	je l4
loa1:	add bl,0Ah
	dec bh
	jnz loa1
l4:	add dx,bx
	cmp sp,bp
	je br
	loop l5
	
	
	
br:	mov cl,0
p1:	cmp dl,9
	jbe l6
	sub dl,0Ah
	inc dh
	jmp p1
l6:	cmp dh,9
	jbe l7
	sub dh,0Ah
	inc cl
	jmp l6
l7:	add dx,3030h
	add cl,30h
	lea di,s
	mov [di],cl
	inc di
	mov [di],dh
	inc di
	mov [di],dl
	inc di
	mov byte ptr[di],'$'	
	
	lea si,n
	lea di,r
l8:	cmp byte ptr[si],'$'
	je l3
	mov al,[si]
	mov [di],al
	inc di
	inc si
	mov al,[si]
	mov [di],al
	inc di
	mov byte ptr[di],20h
	inc di
	inc si
	jmp l8
	
l3:	mov byte ptr[di],'$'
	lea dx,r
	mov ah,09h
	int 21h
	
	lea dx,su
	mov ah,09h
	int 21h
	
	lea dx,s
	mov ah,09h
	int 21h
	
	mov ah,4ch
	int 21h
	
code ends
end start
