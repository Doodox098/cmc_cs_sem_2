%include "io.inc"

section .data

formatnum db "%d", 0
formatstr db "%s", 0
res dd 0

section .bss

now resb 13
num resd 1
m resb 6000

section .text

CEXTERN strstr
CEXTERN scanf
CEXTERN printf
CEXTERN strlen
CEXTERN strncpy

global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 12
    and esp, ~0xF
    
    mov dword[esp + 4], num
    mov dword[esp], formatnum
    call scanf
    mov ebx, 0
rd:
    cmp ebx, dword[num]
    jnl erd
    
    mov byte[now], ' '
    mov dword[esp + 4], now
    inc dword[esp + 4]
    mov dword[esp], formatstr
    call scanf
    
    mov dword[esp], now
    call strlen
    
    mov byte[now + eax], ' '
    
    mov dword[esp + 4], now
    mov dword[esp], m
    call strstr
    
    cmp eax, 0
    jne sk
    inc dword[res]
sk:    
    mov dword[esp], m
    call strlen
    mov edi, eax
    
    mov dword[esp], now
    call strlen
    
    mov dword[esp + 8], eax
    mov dword[esp + 4], now
    mov dword[esp], m
    add dword[esp], edi
    call strncpy
 
    inc ebx
    
    mov dword[now], 0
    mov dword[now + 4], 0
    mov dword[now + 8], 0
    jmp rd
erd:    
    mov eax, dword[res]
    mov dword[esp + 4], eax
    mov dword[esp], formatnum
    call printf

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret