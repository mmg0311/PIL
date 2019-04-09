        .model  small
        .stack  64
        print   macro   msg
        lea     dx,msg
        mov     ah,09h
        int     21h
        endm
        .data
msg1    db      10,13,"CONCATINATION OF GIVEN STRINGS IS $"
con     db      50
        db      ?
        db      50      dup('$')
l1      db      ?
l2      db      ?
extrn  str1:byte
extrn  str2:byte
        .code
        public  concate                 
        concate  proc    far
        mov     ax,@data
        mov     ds,ax

        ;length of sring 1
        mov     al,00h
        mov     al,str1+1
        mov     l1,al
        ;length of string 2
        mov     al,str2+1
        mov     l2,al

        mov     si,00h
        mov     dx,00h
        mov     dl,l1
copy1:  mov     ax,00h
        mov     ax,offset str1+2[si]
        mov     offset con+2[si],ax
        inc     si
        cmp     si,dx
        jne     copy1

        mov     dl,l2
        mov     dh,00h
        mov     di,00h
copy2:  mov     ax,00h
         mov     ax,offset str2+2[di]
        mov     offset con+2[si],ax
        inc     si
        inc     di
        cmp     di,dx
        jne     copy2

        print   msg1
        mov     ah,09h
        mov     dx,offset  con+2
        int     21h

        mov     ax,4c00h
        int     21h
        endp
	ret
                end   concate
