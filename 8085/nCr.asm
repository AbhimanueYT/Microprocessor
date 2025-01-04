lxi h,5000h
mov a,m
call fact
mov e,a
inx h
mov a,m
call fact
inx h
mov m,e
inx h
mov m,a
lxi h,5000h
mov a,m
inx h
mov e,m
sub e
call fact
lxi h,5004h
mov m,a
mov d,a
dcx h
mov c,m
dcr c
call MUL
lxi h,5005h
mov m,a
lxi h,5002h
mov a,m
lxi h,5005h
mov b,m
call DIV
lxi h,5006h
mov m,e
inx h
mov m,a
hlt

DIV: mvi c,0
     cmp b
     jc ex
loop: sub b
     inr c
     cmp b
     jnc loop
     mov e,a
     mov a,c
     ret
 ex: mov e,a
     mov a,c
     ret

MUL: jz exit
     add d
     dcr c
     jnz MUL
     mov d,a
exit: ret


 fact: mov d,a
       mov b,a
  fac: mov c,b
       dcr c
       jz last
       dcr c
       call MUL
 last: dcr b
       jnz fac
       ret
