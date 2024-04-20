%include "io.inc"

section .data

formatinn db "%d", 0
formatins db "%s", 0
formatout db "%d", 0

section .bss

s resb 5500
c resb 13
n resd 1

section .text
global CMAIN
CEXTERN strstr
CEXTERN scanf
CEXTERN printf
CEXTERN strlen
    
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 12
    and esp, ~0xF
    
    mov dword[esp + 4], n
    mov dword[esp], formatinn
    call scanf
    mov esi, 0
    mov ebx, dword[n]
for:
    cmp esi, dword[n]
    je end
    
    mov byte[c], ' '
    
    mov dword[esp + 8], ecx
    mov dword[esp + 4], c + 1
    mov dword[esp], formatins
    call scanf
    mov ecx, dword[esp + 8]
    
    mov dword[esp], c
    call strlen
    
    dec ebx
    cmp eax, 1
    je nxt
    
    mov ecx, eax
    mov byte[c + ecx], ' '
    mov byte[c + ecx + 1], 0
    
    mov dword[esp + 8], ecx
    mov dword[esp + 4], c
    mov dword[esp], s
    call strstr
    mov ecx, dword[esp + 8]
    
    cmp eax, 0
    jne nxt
    inc ebx
    
    mov dword[esp + 4], ecx
    mov dword[esp], s
    call strlen
    mov ecx, dword[esp + 4]
    
    mov ecx, eax
    
    mov dword[esp + 4], ecx
    mov dword[esp], c
    call strlen
    mov ecx, dword[esp + 4]
    
    add eax, ecx
    mov byte[s + ecx], ' '
    mov edi, ecx
adst: 
    cmp ecx, eax
    jg nxt
    sub ecx, edi
    movzx edx, byte[c + ecx]
    mov byte[c + ecx], 0
    add ecx, edi
    mov byte[s + ecx + 1], dl
    inc ecx
    jmp adst
nxt:    
    ;PRINT_STRING s
    ;NEWLINE 
    inc esi
    jmp for
end:
    mov dword[esp + 4], ebx
    mov dword[esp], formatout
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret