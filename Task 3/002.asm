%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebx, 0
    GET_DEC 4, eax
c:      cmp eax, 0
        je b
        mov ecx, eax
        dec ecx
        and eax, ecx
        inc ebx
        jmp c
b:  PRINT_DEC 4, ebx
    xor eax, eax
    ret