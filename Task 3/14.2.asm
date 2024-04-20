%include "io.inc"

section .data

rs dq 0
cnst dd 2

section .bss

n resd 1
k resd 1
b resq 1
p resd 1
t resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, ebx
    GET_DEC 4, ecx
    mov dword[n], ebx
    mov dword[k], ecx
    
    xor eax, eax
    ret
    
fac:
    mul ebx
    dec ecx
    cmp ecx, edi
    jg fac
    ret

sch:
    mov dword[b], 0
    mov ecx, p
    mov eax, 1
    mov edx, 0
    mov edi, t
    call fac
    add dword[b + 2],edx
    add dword[b], eax

    