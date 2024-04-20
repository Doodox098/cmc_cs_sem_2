%include "io.inc"

section .data

namein db "input4.bin", 0
nameout db "output.bin", 0
formatin db "r", 0
formatout db "w", 0
formatins db "%c%c%c%c", 0

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
    mov ebp, esp; for correct debugging

    ;Открытие файла на чтение
    sub esp, 4
    push formatin
    push namein
    call fopen
    add esp, 12
    mov dword[input], eax
    ;Открытие файла на запись
    sub esp, 4
    push formatout
    push nameout
    call fopen
    add esp, 12
    mov dword[output], eax
    
    mov ecx, 0
whl:
    GET_DEC 4, eax
    cmp eax, 0
    je nxt
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
    PRINT_DEC 4, edx
    xor eax, eax
    ret