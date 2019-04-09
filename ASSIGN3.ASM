        .model small
        .stack 64
        print macro msg
        lea     dx,msg
        mov     ah,09h
        int     21h
        endm
        .data
msg1    db      10,13,"ENTER A STRING $"
msg2    db      10,13,"GIVEN STRING IS $"
msg3    db      10,13,"LENGTH OF GIVEN STRING IS $"
msg4    db      10,13,"IS PALINDROME $"
msg5    db      10,13,"NOT A PALINDROME $"
msg6    db      10,13,"REVERSE OF GIVEN STRING IS ",'$'
ent     db      10,13,"$"
menu    db     10,13,"ENTER CHOICE $"
m1     db      10,13,"1.ENTER STRING  $"
m2    db        10,13,"2.DISPLAY STRING $"
m3    db	      10,13,"3.PRINT LENGTH $"
m4   db         10,13,"4.CHECK IF IT IS PALINDROME $"
m5    db       10,13,"5.DISPLAY REVERSE $"
m6     db      10,13,"6.EXIT $"
s       db      26
        db      ?
        db      20      dup('$')
choice  db      0        
        .code
        main proc far
        mov     ax,@data
        mov     ds,ax
        
me:  print    ent
         print   menu
         print    m1
         print    m2
         print    m3
         print    m4
         print    m5
         print    m6
        mov     ah,01h
        int     21h
        sub     al,30h
        mov     choice,al
        cmp     choice,1              
        je      case1
        cmp     choice,2
        je      case2  
       cmp     choice,3
        je      case3
        cmp     choice,4
        je      case4        
        cmp     choice,5
        je      case5
        jmp     exit
        
case1:  print   msg1

        mov     ah,0Ah
        mov     dx,offset  s
        int     21h
        jmp     me

case2:  print   msg2

        mov     ah,09h
        mov     dx,offset s+2
        int     21h
        jmp     me

case3:  print   msg3

        mov     dl,s+1
        cmp     dl,39h
        ja     alpha
        add     dl,30h
        jmp     t
alpha:  sub     dl,37h
t:      mov     ah,02h
        int     21h
        jmp     me
        
case4:  mov     dh,00h
        mov     dl,s+1
        mov     si,0
        mov     di,dx
        dec     di
        mov     cl,dl
        jmp     l
er:     print   msg5
        jmp     me
l:      mov     al,offset s+2[di]
        mov     bl,offset s+2[si]
        cmp     al,bl
        jne     er
        inc     si
        dec     di
        loop     l 
        print   msg4
        jmp     me

case5:  print   msg6
        print   ent
        mov     dx,00h
        mov     dl,s+1
        mov     dh,00h
        mov     si,dx
label1: mov     dl,offset s+2[si]
        mov     ah,02h
        int     21h
        dec     si
        cmp     si,-1
        jne     label1
        jmp     me

exit:   mov     ax,4c00h
        int     21h
        endp
                end main
                                          
