%include "io.inc"

section .data

s dd 2011

section .text
global CMAIN

ex_op:
    push ebp
    mov ebp, esp
    push ebx
    mov ecx, dword[ebp + 12]
    mov ebx, dword[ebp + 8]
.sr:
    mov eax, ebx
    mul dword[ebp + 16]
    mov ebx, eax
    mov eax, ecx
    div dword[ebp + 16]
    mov ecx, eax
    cmp ecx, 0
    je .end
    jmp .sr
.end:
    mov eax, ebx
    add eax, dword[ebp + 12]
    pop ebx
    mov esp, ebp
    pop ebp
    ret

CMAIN:
    GET_UDEC 4, esi
    GET_UDEC 4, ecx
    GET_UDEC 4, eax
    mov edx, 0
    div dword[s]
    mov eax, edx
    mov ebx, eax
ccl:
    cmp ecx, 0
    je end
    dec ecx
    push ecx
    push edx
    push esi
    push ebx
    push eax
    call ex_op
    add esp, 12
    pop edx
    pop ecx
    mov ebx, edx
    mov edx, 0
    div dword[s]
    mov eax, edx
    jmp ccl
    
end:PRINT_UDEC 4, eax
    xor eax, eax
    ret