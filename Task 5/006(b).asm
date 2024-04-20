%include "io.inc"

section .rodata

formatin db "rb", 0
filein db "input.bin", 0
formatout db "wb", 0
fileout db "output.bin", 0

section .data

size dd 0
nd dd 1
ni dd 1

section .bss

a resd 2280000
now resd 1
inp resd 1
outp resd 1 

section .text
CEXTERN fopen
CEXTERN fclose
CEXTERN fread
CEXTERN fwrite
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 16
    and esp, ~0xF
    
    mov dword[esp + 4], formatin
    mov dword[esp], filein
    call fopen
    mov dword[inp], eax
    
    mov dword[esp + 4], formatout
    mov dword[esp], fileout
    call fopen
    mov dword[outp], eax
    
rd:
    mov dword[esp], now
    mov eax, 4
    mov dword[esp + 4], eax
    mov eax, 1
    mov dword[esp + 8], eax
    mov eax, dword[inp]
    mov dword[esp + 12], eax
    call fread
    test eax, eax
    jz erd
    mov ecx, dword[size]
    mov eax, dword[now]
    mov dword[a + ecx * 4], eax
    inc dword[size]
    jmp rd
erd:
    mov ecx, 0
ans:
    mov eax, ecx
    inc eax
    shl eax, 1
    cmp eax, dword[size]
    jnl eans
    mov ebx, dword[a + ecx * 4]
    mov edi, dword[a + ecx * 8 + 4]
    mov esi, dword[a + ecx * 8 + 8]
    mov eax, 1
    cmp ebx, edi
    jng ls
    mov dword[nd], 0
ls:
    cmp ebx, esi
    jnl rs
    mov dword[ni], 0
rs:
    inc ecx
    jmp ans
eans:

    mov eax, dword[inp]
    mov dword[esp], eax
    call fclose
    
    mov eax, dword[nd]
    xor eax, 1
    add eax, dword[ni]
    cmp eax, 2
    jne sk
    mov dword[nd], -1
sk:
    mov dword[esp], nd
    mov eax, 4
    mov dword[esp + 4], eax
    mov eax, 1
    mov dword[esp + 8], eax
    mov eax, dword[outp]
    mov dword[esp + 12], eax
    call fwrite
    
    mov eax, dword[outp]
    mov dword[esp], eax
    call fclose
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret