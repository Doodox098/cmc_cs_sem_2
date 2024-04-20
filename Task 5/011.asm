%include "io.inc"

section .rodata

namein db "input.txt", 0
nameout db "output.txt", 0
formatin db "r", 0
formatout db "w", 0
formatins db "%d%d", 0
formatouts db "%d ", 0

section .data

section .bss

input resd 1
output resd 1
first_arr resd 100000
second_arr resd 100000
ext_arr resd 100000
f resd 1
s resd 1
n resd 1
m resd 1
x resd 1
y resd 1
root resd 1
pr resd 1
fn resd 1

struc st
.key: resd 1
.next: resd 1
endstruc

section .text
global CMAIN
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN fgets
CEXTERN calloc
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 20
    and esp, ~0xF
    
    mov dword[esp + 4], formatin
    mov dword[esp], namein
    call fopen
    mov dword[input], eax
    
    mov dword[esp + 4], formatout
    mov dword[esp], nameout
    call fopen
    mov dword[output], eax
    
    mov dword[esp + 12], m
    mov dword[esp + 8], n
    mov dword[esp + 4], formatins
    mov eax, dword[input]
    mov dword[esp], eax
    call fscanf
    
    mov ecx, 0
    mov edx, root
nch:
    cmp ecx, dword[n]
    je cnt
    mov dword[esp + 12], edx
    mov dword[esp + 8], ecx
    mov dword[esp + 4], 8
    mov dword[esp], 1
    call calloc
    mov ecx, dword[esp + 8]
    mov edx, dword[esp + 12]
    mov dword[edx], eax
    inc ecx
    mov dword[eax], ecx
    dec ecx
    mov edx, eax
    add edx, 4
    inc ecx
    jmp nch
cnt:   
    mov ecx, 0
for:
    cmp ecx, dword[m]
    je nxt
    
    mov dword[esp + 16], ecx
    mov dword[esp + 12], y
    mov dword[esp + 8], x
    mov dword[esp + 4], formatins
    mov eax, dword[input]
    mov dword[esp], eax
    call fscanf
    mov ecx, dword[esp + 16]
    mov eax, dword[root]
    mov eax, dword[eax]
    cmp dword[x], eax
    je bck
    mov eax, dword[root]
    mov dword[pr], 0
    chg:
        mov edx, dword[eax]
        cmp edx, dword[x]
        jne .nx
        mov edi, dword[root]
        mov dword[fn], edi
        mov dword[root], eax
        mov dword[pr], ebx
    .nx:
        cmp edx, dword[y]
        jne .ny
        cmp dword[pr], 0
        je .k
        mov edi, dword[pr]
        mov esi, dword[eax + 4]
    .k:
        mov dword[edi], esi
        mov edi, dword[fn]
        mov dword[eax + 4], edi
        jmp bck
    .ny:
        mov ebx, eax
        add ebx, 4
        mov eax, dword[eax + 4]
        jmp chg
    bck:
    inc ecx
    jmp for 
nxt:
    mov eax, dword[root]
wt:
    cmp eax, 0
    je end
    mov dword[esp + 12], eax
    mov edx, dword[eax]
    mov dword[esp + 8], edx
    mov dword[esp + 4], formatouts
    mov edx, dword[output]
    mov dword[esp], edx
    call fprintf
    mov eax, dword[esp + 12]
    mov eax, dword[eax + 4]
    jmp wt
end:
    mov eax,[output]
    mov dword[esp], eax
    call fclose
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret