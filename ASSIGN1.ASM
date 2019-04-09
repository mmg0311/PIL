
; count is 3 and 1 digit numbers
	.model small
	.stack 64
	.data
msg1    db     10,13 ,"ENTER ELEMENTS IN ARRAY $"
msg2    db     10,13, "SUM IS $"
arr     db      3       dup(?)          ;array of size 3 with garbage values
sum     db      0
.code
main proc far
        mov     ax,@data
        mov     ds,ax
        lea     dx,msg1
        mov     ah,09h
        int     21h
        xor     ax,ax
        mov     di,0
loop1:  mov     ah,01h                    ;for taking array elements
        int     21h
        sub     al,30h
        mov     arr[di],al
        inc     di
        cmp     di,3
        jb     loop1
        mov     di,0
loop2:  mov     al,arr[di]
        add     al,sum                ;adding three numbers
        mov     sum,al
        inc     di
        cmp     di,3
        jb     loop2
        lea     dx,msg2
        mov     ah,09h
        int     21h
        mov     dl,sum
        add     dl,30h
        mov     ah,02h
        int     21h
        mov     ax,4c00h
        int     21h
    main endp
        end main
