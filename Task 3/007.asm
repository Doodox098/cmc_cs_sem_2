%include "io.inc"

section .data

section .bss

n resd 1
i resd 1
mas resd 10000

section .text
global CMAIN
CMAIN:
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov dword[i], eax
    GET_DEC 4, n
    mov eax, dword[n]
    mov ecx, 0
    
rd:     GET_DEC 4, eax
        mov dword[mas + ecx * 4], eax
        inc ecx
        cmp ecx, dword[n]
        jl rd
    mov ecx, 0
    mov eax, dword[n]
    cmp eax, 1
    je wt
    mov dword[i], eax
    mov ebx, dword[mas]
        
C1:     dec dword[i]
    C2:     mov ebx, dword[mas + ecx * 4 + 4]
            cmp dword[mas + ecx * 4], ebx
            jg Mv
            inc ecx
Mv2:        cmp ecx, dword[i]
            jl C2
        mov ecx, 0
        cmp dword[i],0
        jg C1
    
    mov ecx, 0

wt:    mov eax, dword[mas + ecx * 4]
        PRINT_DEC 4, eax
        PRINT_CHAR " "
        inc ecx
        cmp ecx, dword[n]
        jl wt

    xor eax, eax
    ret
    
Mv: ;PRINT_CHAR "."
    mov edx, dword[mas + ecx * 4]
    mov dword[mas + ecx * 4], ebx
    mov dword[mas + ecx * 4 + 4], edx
    jmp Mv2