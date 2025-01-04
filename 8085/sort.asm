      lxi h,0x0400h
      mov b,m
      dcr b
      mov c,b
      inx h
      mov e,l
  l2: mov c,b
      mov l,e
  l1: mov a,m
      inx h
      mov d,m
      cmp d
      jc next
      mov m,a
      dcx h
      mov m,d
      inx h
next: dcr c
      jnz l1
      dcr b
      jnz l2
      hlt
