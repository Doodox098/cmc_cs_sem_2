%include "io.inc"

section .data

s dd 2011

section .text
global CMAIN

ex_op:
    push ebp
    mov ebp, esp
    mov ebx, 0
    push esi
    push ebx
    mov esi, dword[ebp + 8]
    mov eax, dword[ebp + 4]
.c: cmp eax, 0
    je .e
    mov edx, 0
    imul ebx, esi
    div esi
    add ebx, edx
    jmp .c
.e: pop ebx
    pop esi
    mov eax, ebx
    mov esp, ebp
    pop ebp
    ret

CMAIN:
    GET_UDEC 4, ebx
    GET_UDEC 4, ecx
    GET_UDEC 4, eax
    mov edx, 0
    div dword[s]
    mov eax, edx
ccl:
    cmp ecx, 0
    je end
    dec ecx
    mov edx, eax
    mul edx
    push ecx
    push ebx
    push eax
    call ex_op
    add esp, 4
    pop ebx
    pop ecx
    mov edx, 0
    div dword[s]
    mov eax, edx
    jmp ccl
    
end:PRINT_UDEC 4, eax
    xor eax, eax
    ret