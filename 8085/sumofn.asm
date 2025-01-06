mvi a,0
sta 8501h
lxi h,8500h
mov a,m
mov b,a
mvi d,0
rep: inr d
mov c,d
mov a,d
dcr c
jz exit
l1: add d
dcr c
jnz l1
exit: mov e,a
lda 8501h
add e
sta 8501h
mov a,b
cmp d
jnz rep
lxi h,8501h
mvi a,00
mov c,m
l2: adi 01
daa
dcr c
jnz l2
sta 8502h
hlt
