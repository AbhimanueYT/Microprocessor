lxi h,5000h
mov d,m
loop: inx h
      mov a,m
      mvi e,2
      cmp e
      jc exit
      jz exit1
div:  sub e 
      cmp e
      jz exit
      jc ne
      jmp div
ne:   call next
      jmp exit1
exit: mvi m,00
exit1: dcr d
      jnz loop
      hlt
next: mov a,m
      inr e
      cmp e
      jc exit
      jz exit1
      jmp div
ret
