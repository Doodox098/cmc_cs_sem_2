%include "io.inc"

section .rodata

namein db "input.bin", 0
formatin db "rb", 0
formatins db "%s", 0
formatouts db "%d ", 0

section .data

section .bss

input resd 1
output resd 1
m resd 120000
r resd 10000
n resd 1

section .text
global CMAIN
CEXTERN fscanf
CEXTERN printf
CEXTERN fopen
CEXTERN fclose
CEXTERN fread

prnt:
    push ebp
    mov ebp, esp
    sub esp, 16
    and esp, ~0xF
    
    mov eax, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    
    mov eax, dword[eax + ecx]
    mov dword[esp + 4], eax
    mov dword[esp],formatouts
    call printf
    
    mov eax, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    
    cmp dword[eax + ecx + 4], -1
    je .l
    mov edx, dword[eax + ecx + 4]
    mov dword[esp + 8], ecx
    mov dword[esp + 4], edx
    mov dword[esp], eax
    call prnt
    mov eax, dword[esp]
    mov ecx, dword[esp + 8]
.l:
    cmp dword[eax + ecx + 8], -1
    je .r
    mov edx, dword[eax + ecx + 8]
    mov dword[esp + 8], ecx
    mov dword[esp + 4], edx
    mov dword[esp], eax
    call prnt
    mov eax, dword[esp]
    mov ecx, dword[esp + 8]
    
.r:
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 16
    and esp, ~0xF
    
    mov dword[esp + 4], formatin
    mov dword[esp], namein
    call fopen
    mov dword[input], eax
    
    mov eax, dword[input]
    mov dword[esp + 12], eax
    mov dword[esp + 8], 120000
    mov dword[esp + 4], 4
    mov dword[esp], m
    call fread
    
    shl eax, 2
    mov dword[n], eax
    mov ecx, 0
    mov edi, 0
for:
    cmp ecx, dword[n]
    je nxt
    
    mov eax, dword[m + ecx + 4]
    
    cmp eax, -1
    je .sk1
    mov ebx, 12
    div ebx
    mov byte[r + eax], 1

.sk1:   
    mov eax, dword[m + ecx + 8]
    cmp eax, -1
    je .sk2
    mov ebx, 12
    div ebx
    mov byte[r + eax], 1
    
.sk2:    
    add ecx, 12
    jmp for
nxt:
    mov ecx, 0
for1:
    cmp byte[r + ecx], 0 
    je nxt1
    inc ecx
    jmp for1
nxt1:
    mov ebx, 12
    imul ecx, ebx
    mov dword[esp + 4], ecx
    mov dword[esp], m
    call prnt
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret