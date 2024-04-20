%include "io.inc"

section .bss

mth resd 1
mday resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, mth
    GET_UDEC 4, mday
    mov eax, dword[mth]
    sub eax, 1
    mov ecx, 2
    div ecx
    mov ecx, 83
    mul ecx
    mov ebx, eax;количество дней в наибольшем четном числе месяцев, не превосходящем данное
    mov eax, edx
    mov ecx, 41
    mul ecx
    add ebx, eax;кол-во дней в данном числе месяцев
    mov eax, dword[mday]
    add ebx, eax
    PRINT_DEC 4, ebx
    xor eax, eax
    ret