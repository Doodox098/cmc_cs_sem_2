%include "io.inc"

section .bss

a resd 1
b resd 1
c resd 1
d resd 1

section .text
global CMAIN
CMAIN:
    GET_HEX 4, a
    GET_HEX 4, b
    GET_HEX 4, c
    mov ebx, dword[a]
    and ebx, dword[c]
    mov ecx, dword[c]
    not ecx
    and ecx, dword[b]
    add ebx, ecx
    PRINT_HEX 4, ebx
    xor eax, eax
    ret