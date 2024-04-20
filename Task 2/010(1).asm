    %include "io.inc"

section .bss

mth resb 1
mday resb 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 1, mth
    GET_UDEC 1, mday
    mov ah, 0
    mov al, byte[mth]
    sub al, 1
    mov cl, 2
    div cl;вычисляем наибольшее четное число месяцев, не превосходящее данное и четность числа месяцев
    mov dl, ah
    mov cl, 83
    mul cl
    mov bx, ax;количество дней в наибольшем четном числе месяцев, не превосходящем данное
    mov al, dl
    mov cl, 41
    mul cl
    add bx, ax;кол-во дней в данном числе месяцев
    movzx ax, byte[mday]
    add bx, ax
    PRINT_DEC 2, bx
    xor eax, eax
    ret