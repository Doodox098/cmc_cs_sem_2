%include "io.inc"

section .text
global CMAIN

read:
    push ebp
    mov ebp, esp
    GET_DEC 4, eax
    cmp eax, 0
    je cnt
    test ecx, 1
    jne nxt
    PRINT_DEC 4, eax
    PRINT_CHAR ' '
nxt:inc ecx
    push eax
    push ecx
    call read
    pop ecx
    pop eax
    test ecx, 1
    jne cnt
    PRINT_DEC 4, eax
    PRINT_CHAR ' '
cnt:mov esp, ebp
    pop ebp
    ret

CMAIN:
    mov ecx, 0
    call read
    xor eax, eax
    ret