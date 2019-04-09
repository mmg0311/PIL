        .model small
        .stack  64

       print macro msg
        lea     dx,msg
        mov     ah,09h
        int     21h
       endm
       .data
msg1    db      10,13, "GIVEN STRINGS ARE EQUAL $"
msg2    db      10,13, "GIVEN STRINGS ARE NOT EQUAL $"
l1      db      ?
l2      db      ?
extrn  str1:byte
extrn   str2:byte
        .code
        public compare
        compare proc far

        mov     ax,@data
        mov     ds,ax

        mov     al,str1+1
        mov     l1,al

        mov     al,str2+1
        mov     l2,al
       jmp      start
er:    print    msg2
        jmp     exit
start:  mov     al,l2
        cmp     al,l1
        jne     er
        mov     di,00h
        mov     dl,l1
        mov     dh,00h
cmp1:    mov     al,offset str1+2[di]
        cmp     al,offset   str2+2[di]
        jne     er
        inc     di
        cmp     di,dx
        jle     cmp1
        print   msg1
exit:
        mov     ax,4c00h
        int     21h
        endp
	ret
                end compare
