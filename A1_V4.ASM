
; count is user defined and 2-digit number and 3-digit sum

        .model small
        .stack 64

    print macro msg
        lea     dx,msg
        mov     ah,09h
        int     21h
        endm
    input macro
        mov     ah,01h
        int     21h
        endm
     output macro
        mov     ah,02h
        int     21h
        endm
        .data
 msg1   db      10,13,"ENTER ELEMENTS IN ARRAY$"
 msg2   db      10,13,"SUM IS$"
 msg3   db      10,13,"ENTER NUMBER OF ELEMENTS OF ARRAY$"
 arr    dw      9       dup(0)
 sum    db      0
 count  db      0
 rem    db      0
 rem2   db      0
 temp   db      0
        .code
 main proc far
        mov     ax,@data
        mov     ds,ax

        print   msg3
        xor     ax,ax
        input
        sub     al,30h
        mov     count,al
        mov     cl,count

        print   msg1
        mov     di,0
loop1:  input
        mov     bh,00h
        mov     bl,0Ah
        mov     ah,00h
        sub     al,30h
        mul     bl
        mov     bx,00h
        mov     bl,al

        input
        sub     al,30h
        mov     ah,00h
        add     al,bl

        mov     arr[di],ax
        inc     di
        loop    loop1

        print   msg2
        mov     di,0
        mov     cl,count
loop2:  mov     dx,arr[di]
        add     dl,sum
        mov     sum,dl
        inc     di
        loop    loop2

        mov     ah,00h
        mov     al,sum
        mov     bl,10
        div     bl
        mov     rem,ah
       mov      ah,00h
       mov     bl,10
        div     bl
        mov     rem2,ah

        mov     dl,al           ;quotient goes in al and remainder in ah
        add     dl,30h
        output

        mov     dl,rem2
        add     dl,30h
        output

        mov     dl,rem
        add     dl,30h
        output



        mov     ax,4c00h
        int     21h
        main endp
        end main


