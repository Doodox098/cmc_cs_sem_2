%include "io.inc"

section .data

a db 'A';храним код А чобы иметь возможность вычислять номер столбца

section .bss

col resb 1
lne resb 1

section .text
global CMAIN
CMAIN:
    GET_CHAR col
    GET_UDEC 1, lne
    mov ax, 0
    mov al, byte[col]
    sub al, byte[a];вычисляем номер столбца
    inc al
    mov bh, al
    mov al, 8
    sub al, bh
    mov bh, 2
    div bh;вычисляем количество четных и нечетных столбцов
    mov ch, al
    mov cl, al
    add ch, ah
    mov ax, 0
    mov al, byte[lne]
    mov bh, al
    mov al, 8
    sub al, bh
    mov bh, 2
    div bh;вычисляем количество четных и нечетных строк
    mov bh, al
    mov bl, al
    add bh, ah
    mov ax, 0
    mov al, cl
    mul bh;вычисляем кол-во клеток с учетом четности числа строк и столбцов
    mov dx, ax
    mov ax, 0
    mov al, ch
    mul bl
    add dx, ax
    PRINT_UDEC 1, dx
    xor eax, eax
    ret