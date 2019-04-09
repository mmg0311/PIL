        .model  small
        .stack 64
        print macro msg
        lea     dx,msg
        mov     ah,09h
        int     21h
        endm
        .data
menu    db      10,13,"ENTER CHOICE: $"
ch1     db      10,13," 1.ENTER TWO STRINGS $"
ch2     db      10,13," 2.CONCATINATE $"
ch3     db      10,13," 3.COMPARE $"
ch4     db      10,13," 4.EXIT $"
s1	db	10,13,"ENTER STRING 1:$"
s2	db	10,13,"ENTER STIRNG 2:$"
str1    db      30
        db      ?
        db      30      dup('$')
str2    db      30
        db      ?
        db      30      dup('$')
choice  db      0
public  str1
public  str2
       .code
       extrn   concate:far              ;to call a procedure from other program
       extrn    compare:far
        main    proc    far
        mov     ax,@data
        mov     ds,ax

me:     print   menu
        print   ch1
        print   ch2
        print   ch3
        print   ch4
        mov     ah,01h              ;taking choice
        int     21h
        sub     al,30h
        mov     choice,al

        cmp     choice,1
        je      get
        cmp     choice,2
        je      con
        cmp     choice,3
        je      com
        jmp     exit

get:print   s1
   mov	dx,00h
	mov	ax,00h 
         mov     ah,0Ah
        mov     dx,offset str1       ;taking first string
        int     21h
print s2
mov	dx,00h
mov	ax,00h
        mov     ah,0Ah
        mov     dx,offset str2       ;taking second string
        int     21h
        jmp     me

con:    call    concate
        jmp     me

com:    call    compare
        jmp     me

exit:   mov     ax,4c00h
        int     21h

        endp
                end     main
