%include "io.inc"

section .bss;значения переменных не превышают 10000, поэтому для их хранения достаточно 2 байта
    a resw 2;тк данная переменная используется для хранения результатов умножений, под нее выделяем больше памяти
    b resw 1;подсчет проведем через сумму произведений а на сумму e и f, b на сумму d и f, с на сумму d и e
    c resw 1
    d resw 1
    e resw 1
    f resw 1
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 2, a
    GET_UDEC 2, b
    GET_UDEC 2, c
    GET_UDEC 2, d
    GET_UDEC 2, e
    GET_UDEC 2, f
    mov eax, 0;обнуляем регистр eax, тк в ax помещаются результаты умножения 
    mov ax, word[a]     ;помещаем в ах значение первого множителя
    mov bx, word[e]     ;помещаем в bх значение первого слагаемого
    add bx, word[f]     ;прибавляем к bх значение второго слагаемого
    mul bx              ;домножаем ах на bx
    mov word[a], 0      ;обнуляем а
    mov word[a+2], dx   ;помещаем в а старшие разряды произведения
    mov ecx, dword[a]   ;помещаем в ecx значение а (старшие разряды произведения)
    add ecx, eax        ;помещаем в ecx младшие разряды произведения
    mov eax, 0
    mov ax, word[b]
    mov bx, word[d]
    add bx, word[f]
    mul bx
    mov word[a], 0
    mov word[a+2], dx
    add ecx, dword[a]
    add ecx, eax
    mov eax, 0
    mov ax, word[c]
    mov bx, word[e]
    add bx, word[d]
    mul bx
    mov word[a], 0
    mov word[a+2], dx
    add ecx, dword[a]
    add ecx, eax
    PRINT_UDEC 4,ecx
    xor eax, eax
    ret