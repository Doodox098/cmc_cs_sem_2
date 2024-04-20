%include "io.inc"

section .bss

x1 resw 1
x2 resw 1
x3 resw 1
y1 resw 1
y2 resw 1
y3 resw 1

section .text
global CMAIN
CMAIN:
    ;площадь ищем по формуле: |(y3 - y1)(x2 - x1)-(y2 - y1)(x3 - x1)|/2
    GET_DEC 2, x1
    GET_DEC 2, y1
    GET_DEC 2, x2
    GET_DEC 2, y2
    GET_DEC 2, x3
    GET_DEC 2, y3
    mov eax, 0
    mov ebx, 0
    mov ax, word[y3]
    sub ax, word[y1]
    mov bx, word[y2]
    sub bx, word[y1]
    mov cx, word[x3]
    sub cx, word[x1]
    mov dx, word[x2]
    sub dx, word[x1]
    mov word[y3], ax
    mov word[y2], bx
    mov word[x3], cx
    mov word[x2], dx
    mov eax, 0
    movsx eax,word[y3]
    movsx ecx,word[x2]
    imul eax, ecx
    mov ebx, eax
    mov eax, 0
    movsx eax,word[y2]
    movsx ecx,word[x3]
    imul eax, ecx
    sub ebx, eax
    ;берем модуль
    mov ecx, ebx
    sar ecx, 31
    movsx eax, cx
    mov edx, ebx
    imul edx, eax
    imul edx, 2
    add ebx, edx
    ;находим неполное частное и остаток от деления на два, домножаем остаток на 5 и выводим через точку
    mov eax, ebx
    cdq
    mov ebx, 2
    idiv ebx
    mov ebx, 5
    imul edx, ebx
    PRINT_DEC 4, eax
    PRINT_CHAR '.'
    PRINT_DEC 4, edx
    xor eax, eax
    ret