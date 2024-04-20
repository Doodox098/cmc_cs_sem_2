%include "io.inc"

section .data

g dd 0
b dd 2

section .bss

x1 resd 1
y1 resd 1
x2 resd 1
y2 resd 1
x3 resd 1
y3 resd 1

section .text
global CMAIN

sqr:;площадь ищем по формуле: |(y3 - y1)(x2 - x1)-(y2 - y1)(x3 - x1)|/2
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 12]
    sub eax, dword[ebp + 28]
    push eax
    mov eax, dword[ebp + 16]
    sub eax, dword[ebp + 24]
    push eax
    mov eax, dword[ebp + 20]
    sub eax, dword[ebp + 28]
    mov edx, eax
    mov eax, dword[ebp + 8]
    sub eax, dword[ebp + 24]
    imul eax, edx
    mov ecx, eax
    pop eax
    pop edx
    imul eax, edx
    sub ecx, eax
    cmp ecx, 0
    jg .end
    neg ecx
.end:
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret
    
nod:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cmp eax, 0
    jne .d
    mov eax, ecx
.d:
    jg .nx
    neg eax
.nx:
    cmp ecx, 0
    je .end
    jg .src
    neg ecx
.src:   mov edx, 0
        div ecx
        mov eax, ecx
        mov ecx, edx
        cmp edx, 0
        jne .src
.end:
    mov esp, ebp
    pop ebp
    ret

CMAIN:
    GET_DEC 4, eax
    mov dword[x1], eax
    GET_DEC 4, eax
    mov dword[y1], eax
    GET_DEC 4, eax
    mov dword[x2], eax
    GET_DEC 4, eax
    mov dword[y2], eax
    GET_DEC 4, eax
    mov dword[x3], eax
    GET_DEC 4, eax
    mov dword[y3], eax
    mov eax, dword[x1]
    sub eax, dword[x2]
    push eax
    mov eax, dword[y1]
    sub eax, dword[y2]
    push eax
    call nod
    add dword[g], eax
    add esp, 8
    mov eax, dword[g]
    mov eax, dword[x1]
    sub eax, dword[x3]
    push eax
    mov eax, dword[y1]
    sub eax, dword[y3]
    push eax
    call nod
    add dword[g], eax
    add esp, 8
    mov eax, dword[g]
    mov eax, dword[x3]
    sub eax, dword[x2]
    push eax
    mov eax, dword[y3]
    sub eax, dword[y2]
    push eax
    call nod
    add dword[g], eax
    add esp, 8
    push dword[x1]
    push dword[y1]
    push dword[x2]
    push dword[y2]
    push dword[x3]
    push dword[y3]
    call sqr
    add esp, 24
    sub eax, dword[g]
    add eax, 2
    mov edx, 0
    div dword[b]
    PRINT_DEC 4, eax
    xor eax, eax
    ret