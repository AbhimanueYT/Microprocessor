lxi h,5000h
mov c,m
mvi a,0
inx h
mov m,a
mvi b,1
mov d,a
add b
mov b,d
mov d,a
call fab
hlt

fab:	inx h
	mov m,d
    mov d,a
	add b
    mov b,d
    mov d,a
	dcr c
	jnz fab
	ret
