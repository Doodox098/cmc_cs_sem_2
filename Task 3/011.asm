%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_DEC 4, ebx
    GET_DEC 4, ecx
src:    mov edx, 0
        mov eax, ebx
        div ecx
        mov ebx, ecx
        mov ecx, edx
        cmp edx, 0
        jne src
        
    PRINT_DEC 4, ebx
    xor eax, eax
    ret