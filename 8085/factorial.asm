lxi h,5000h
mov a,m
mov d,a
mov b,a
  fac: mov c,b
       dcr c
       jz last
       dcr c
       call MUL
 last: dcr b
       jnz fac
inx h
mov m,a
hlt

MUL: jz exit
     add d
     dcr c
     jnz MUL
     mov d,a
exit: ret
