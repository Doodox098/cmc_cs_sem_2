%include "io.inc"

section .rodata

namein db "input.bin", 0
formatin db "%d",0
formatouts db "%d",10, 0

section .data

section .bss

input resd 1
output resd 1
n resd 1
m resd 1

section .text
global CMAIN
CEXTERN scanf
CEXTERN fprintf
CEXTERN fread
CEXTERN calloc
    

apply:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 20]
    add eax, 2
    shl eax, 2
    sub esp, eax
    and esp, ~0xF
    
    mov ecx, 0
    
.for:
    cmp ecx, dword[ebp + 12]
    je .end
    
    mov edx, 0
    .prin:
        cmp edx, dword[ebp + 20]
        je .pre 
        mov eax, dword[ebp + 24 + edx * 4]
        mov dword[esp + edx * 4], eax
        inc edx
        jmp .prin
    .pre:
    mov eax, dword[ebp + 8]
    mov eax, dword[eax + ecx * 4]
    mov dword[esp + edx * 4], eax
    mov dword[esp + edx * 4 + 4], ecx
    call [ebp + 16]
    mov edx, dword[ebp + 20]
    mov ecx, dword[esp + edx * 4 + 4]
    inc ecx
    jmp .for
.end:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 24
    and esp, ~0xF
        
    mov dword[esp + 4], n
    mov dword[esp], formatin
    call scanf
    
    mov eax, dword[n]
    mov dword[esp + 4], 4
    mov dword[esp], eax
    call calloc
    
    mov dword[m], eax
    
    mov ecx, 0
st:
    cmp ecx, dword[n]
    je cnt
    mov dword[esp + 8], ecx
    shl ecx, 2
    mov eax, dword[m]
    add eax, ecx
    mov dword[esp + 4], eax
    mov dword[esp], formatin
    call scanf
    mov ecx, dword[esp + 8]
    inc ecx
    jmp st
cnt:
    mov dword[esp + 20], formatouts
    call get_stdout
    mov dword[esp + 16], eax
    mov dword[esp + 12], 2
    mov dword[esp + 8], fprintf
    mov eax, dword[n]
    mov dword[esp + 4], eax
    mov eax, dword[m]
    mov dword[esp], eax
    call apply
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret