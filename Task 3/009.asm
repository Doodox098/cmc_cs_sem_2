%include "io.inc"

section .bss

x resd 1
y resd 1
x1 resd 4
y1 resd 4
sg resd 1

section .text
global CMAIN
CMAIN:
    mov ecx, 0
    
rd:     GET_DEC 4, eax
        mov dword[x1 + ecx*4], eax
        GET_DEC 4, eax
        mov dword[y1 + ecx*4], eax
        inc ecx
        cmp ecx, 4
        jl rd
    mov eax, 0
    mov edx, 0
    GET_DEC 4, eax
    mov dword[x], eax
    GET_DEC 4, eax
    mov dword[y], eax
    mov esi, dword[x1 + 12]
    mov ebx, dword[y1 + 12]
    mov ecx, dword[x]
    mov edi, dword[y]
    sub esi, dword[x1]
    sub ebx, dword[y1]
    sub ecx, dword[x1]
    sub edi, dword[y1]
    imul esi, edi
    imul ebx, ecx
    sub esi, ebx
    cmp esi, 0
    jg gr
    mov eax, 0
    mov dword[sg], eax
gr1:mov ecx, 0
    
sn: 
    mov esi, dword[x1 + 4 + ecx * 4]
    mov ebx, dword[y1 + 4 + ecx * 4]
    mov ebp, dword[x]
    mov edi, dword[y]
    sub esi, dword[x1 + ecx * 4]
    sub ebx, dword[y1 + ecx * 4]
    sub ebp, dword[x1 + ecx * 4]
    sub edi, dword[y1 + ecx * 4]
    imul esi, edi
    imul ebx, ebp
    sub esi, ebx
    sar esi, 32
    PRINT_DEC 4, esi
    inc ecx
    cmp ecx, 3
    jl sn
    
    xor eax, eax
    ret
gr: mov eax, -1
    mov dword[sg], eax
    jmp gr1