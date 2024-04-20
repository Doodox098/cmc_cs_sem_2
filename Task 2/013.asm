%include "io.inc"

section .bss

xc resb 1
xl resb 1
yc resb 1
yl resb 1

section .text
global CMAIN
CMAIN:              ;значение вычисляется с помощью вычисления суммы модулей разности столбцов и модуля разности строк
    GET_CHAR xc     ;модуль вычисляется по формуле |X| = X + 2*X*S, где S получается копированием старшего бита X в остальные
    GET_UDEC 1, xl  ;тогда если X >= 0, то S = 0 и |X| = X + 0, иначе S = -1, а |X| = X - 2 * X = -X
    GET_CHAR yc
    GET_CHAR yc
    GET_UDEC 1, yl
    mov dl, byte[yc]
    sub dl, byte[xc]
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov al, dl
    sar al, 8
    cbw 
    mov cx, ax
    mov al, dl
    cbw
    mov bx, ax
    imul bx, cx
    imul bx, 2
    add al, bl
    mov byte[xc], al
    mov dl, byte[yl]
    sub dl, byte[xl]
    mov al, dl
    sar al, 8
    cbw 
    mov cx, ax
    mov al, dl
    cbw
    mov bx, ax
    imul bx, cx
    imul bx, 2
    add al, bl
    add al, byte[xc]
    PRINT_DEC 1, al
    xor eax, eax
    ret