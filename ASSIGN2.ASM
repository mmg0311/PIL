
;convert 4digit hex no. to BCD
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
 menu   db      10,13,"ENTER CHOICE 1.HEX TO BCD 2.BCD TO HEX 3.EXIT $"
 msg1   db      10,13,"ENTER HEX NUMBER (4-DIGIT HEX) $"
 msg2   db      10,13,"EQUIVALENT BCD : $"
 msg3   db      10,13,"ENTER 5-DIGIT BCD NUMBER $"
 msg4   db      10,13,"EQUIVALENT HEX : $"
 ent    db      10,13," $"
 hex    db      4       dup(0)               ;4 digit hex
 choice db      0
 ans    dw      0
 p      dw      4096
 s      dw      16
 ten    dw      10
 bcd    dw      0

        .code
 main proc far
        mov     ax,@data
        mov     ds,ax


m:      mov     choice,00h
        print   menu                  ;displaying menu
        input
        sub     al,30h
        mov     choice,al               ;taking choice
                                        ;switch case
        cmp     choice,1              
        je      case1
        cmp     choice,2
        je      case2
        cmp     choice,3
        je      exit


case1:  call    hexToBCD
        jmp     m

case2:  call    bcdToHex
        jmp     m
       
exit:   mov     ax,4c00h
        int     21h
        
        main endp



hexToBCD   proc near

        print   msg1                ;convertion of hex to bcd
       
        xor     cx,cx
        xor     di,di
        jmp     loop1
alpha:  sub     al,37h
        jmp     l1

loop1:  input
        cmp     al,39h               ;comparing al with 9
        ja      alpha                ;jump if it is an alphabet

        sub     al,30h               ;if it is a number
l1:     mov     hex[di],al           ;taking 4 digit hex number
        inc     di
        cmp     di,4
        jb      loop1                ;loop1 finished
                                        
        mov     di,0                 
loop2:  mov     ax,00h
        mov     al,hex[di]
        mul     p
        add     ax,ans
        mov     ans,ax
        mov     ax,00h
        mov     ax,p
        div     s
        mov     p,ax
        inc     di
        cmp     di,4
        jb      loop2
;to display result
        print   msg2
        print   ent
        mov     bx,ten
        
loop3: mov     dx,00h
         mov     ax,ans
        div     bx
        push    dx
        mov     ans,ax
        cmp     ax,0
        ja      loop3
        mov      cl,4

loop4:  pop     dx
        add     dx,30h
        output
        dec     cl
        cmp     cl,0
        ja     loop4
ret
hexToBCD endp

bcdToHex proc near
        print   msg3                 ;conversion of bcd to hex
        print   ent
        mov     cl,5
lo:     input
        mov     ah,00h
        sub     ax,30h
        add     ax,bcd
       cmp     cl,1
       je	hi
        mul     ten
hi :   mov     bcd,ax
        loop    lo
        mov     cl,4
lo1:    mov     ax,00h
        mov     dx,00h
        mov     ax,bcd
        div     s
        push    dx
        mov     bcd,ax
        loop    lo1

        print   msg4
        print   ent
        mov     cl,4
        mov     bl,39h
	jmp lo2
con:    add     dl,37h
        jmp     con1
lo2:    mov     dx,00h
        pop     dx
        cmp     dl,bl
        ja      con
        add     dl,30h
con1:    output
        dec     cl
        cmp     cl,0
        ja      lo2
ret
bcdToHex endp
        end main
