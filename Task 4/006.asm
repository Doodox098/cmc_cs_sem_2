%include "io.inc"

section .bss

n resd 1000

section .text
global CMAIN

z_num:
    push ebp
    mov ebp, esp
    push ebx
    mov ebx, dword[ebp + 8]
    mov eax, 0
.zc:
    cmp ebx, 0
    je .en
    test ebx, 1
    jne .z1
    inc eax
.z1:
    shr ebx, 1
    jmp .zc
.en:
    pop ebx
    mov esp, ebp
    pop ebp
    ret

CMAIN:
    GET_UDEC 4, edx
    mov ecx, 0
for:
    cmp ecx, edx
    je ot
    inc ecx
    GET_UDEC 4, eax
    mov dword[n + ecx * 4], eax
    jmp for
ot: 
    GET_UDEC 4, ebx
    mov ecx, 0
    mov esi, 0
fr1:
    cmp ecx, edx
    je ot1
    inc ecx
    push ecx
    push edx
    push dword[n + ecx * 4]
    call z_num
    add esp, 4
    pop edx
    pop ecx
    cmp eax, ebx
    jne fr1
    inc esi
    jmp fr1
ot1:
    PRINT_DEC 4, esi
    xor eax, eax
    ret