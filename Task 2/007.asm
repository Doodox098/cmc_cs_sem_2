%include "io.inc"

section .bss
a resb 4;место в памяти куда помещается итоговое числ
b resb 1
c resb 1
d resb 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 1, a
    GET_UDEC 1, b
    GET_UDEC 1, c
    GET_UDEC 1, d
    mov al, byte[b]
    mov byte[a+1], al;помещаем 9-16 биты в память
    mov al, byte[c]
    mov byte[a+2], al;помещаем 17-24 биты в память
    mov al, byte[d]
    mov byte[a+3], al;помещаем 25-32 биты в память
    mov eax, dword[a]
    PRINT_UDEC 4, eax
    xor eax, eax
    ret