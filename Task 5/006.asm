%include "io.inc"

section .data

namein db "input3.bin", 0
nameout db "output.bin", 0
formatin db "rb", 0
formatout db "wb", 0
formatins db "%d", 0
formatouts db "%c%c%c%c", 0

section .bss

input resd 1
output resd 1
x resd 1
m resd 1048576

section .text
global CMAIN
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose   
CMAIN:
    mov ebp, esp
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 32
    
    mov dword[esp + 4], formatin
    mov dword[esp], namein
    call fopen
    mov dword[input], eax
    
    mov dword[esp + 4], formatout
    mov dword[esp], nameout
    call fopen
    mov dword[output], eax
    
    mov ecx, 0
whl:
    mov dword[esp + 12], ecx
    mov dword[esp + 8], x
    mov dword[esp + 4], formatins
    mov eax, dword[input]
    mov dword[esp], eax
    call fscanf
    mov ecx, dword[esp + 12]
    cmp eax, -1
    je nxt
    mov eax, dword[x]
    mov dword[m + ecx * 4], eax
    inc ecx
    jmp whl
nxt:
    cmp ecx, 1
    jg nt
    mov edx, 0
    cmp ecx, 0
    je end
    mov edx, 1
    jmp end
nt:
    mov esi, ecx
    dec esi
    mov edi, 0
    shr esi, 1
    mov ebx, ecx
    shr ebx, 1
    dec ebx
    mov ecx, 0
    mov eax, 0
for:
    cmp ecx, ebx
    jg res
    mov edx, dword[m + ecx * 4]
    inc edi
    cmp edx, dword[m + ecx * 8 + 4]
    jg ls
    inc eax
ls:
    cmp esi, ecx
    je res
    inc edi
    cmp edx, dword[m + ecx * 8 + 8]
    jg ls1
    inc eax
ls1:
    inc ecx
    jmp for
res:
    mov edx, 1
    cmp edi, eax
    je end
    neg edx
    cmp eax, 0
    je end
    mov edx, 0
end:
    mov dword[x], edx
    mov eax, dword[x + 3]
    mov dword[esp + 20], eax
    mov eax, dword[x + 2]
    mov dword[esp + 16], eax
    mov eax, dword[x + 1]
    mov dword[esp + 12], edx
    mov eax, dword[x]
    mov dword[esp + 8], eax
    mov dword[esp + 4], formatouts
    mov eax, dword[output]
    mov dword[esp], eax
    call fprintf
    
    mov eax,[output]
    mov dword[esp],eax
    call fclose
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret