%include "io.inc"

section .data

namein db "input5.bin", 0
nameout db "output.bin", 0
formatin db "rb", 0
formatout db "wb", 0
formatouts db "%b", 0
formatins db "%s", 0
pyr dd 1
repyr dd -1
cur dd 0
pr dd 0

section .bss

input resd 1
output resd 1
m resd 1048576
n resd 1
ans resd 1

section .text
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN strlen
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
    mov dword[esp], namein
    call fopen
    mov dword[input], eax
    
    mov dword[esp + 4], formatout
    mov dword[esp], nameout
    call fopen
    mov dword[output], eax
    mov ecx, 0
    
    mov eax, dword[input]
    mov dword[esp + 12], eax
    mov dword[esp + 8], 1048576
    mov dword[esp + 4], 4
    mov dword[esp], m
    call fread
    
    mov dword[n], eax
    mov ebx, 0
chk:    
    cmp ebx, dword[n]
    je end
    
    mov ecx, ebx
    shl ecx, 1
    
    inc ecx
    cmp ecx, dword[n]
    jne if1
    mov eax, dword[pr]
    cmp dword[pr], 0
    cmove eax, dword[pyr]
    mov dword[cur], eax
    jmp end
if1:
    inc ecx
    
    cmp ecx, dword[n]
    jne if2
    dec ecx
    
    mov eax, dword[m + ecx * 4]
    cmp dword[m + ebx * 4], eax
    jge .f
    mov dword[cur], 1
    jmp .g
.f:
    cmp dword[m + ebx * 4], eax
    jge .ff
    mov dword[cur], -1
    jmp .g
.ff:
    mov eax, dword[pr]
    cmp dword[pr], 0
    cmove eax, dword[pyr]
    mov dword[cur], eax
    jmp end
    
.g:
    mov eax, dword[pr]
    cmp dword[cur], eax
    je .end
    cmp eax, 0
    je  .end
    mov dword[cur], 0
.end:
    jmp end    
if2:
    mov edi, dword[m + ecx * 4];m[2 * i + 2]
    dec ecx
    mov eax, dword[m + ebx * 4];m[i]
    mov esi, dword[m + ecx * 4];m[2 * i + 1]
    cmp edi, esi
    jne .g
    cmp edi, eax
    jne .g
    mov dword[esp], eax
    
    mov eax, dword[esp]
    jmp .ot
.g:
    cmp eax, esi
    jl .gg
    
    cmp eax, edi
    jl .gg
    
    mov dword[cur], -1
    jmp .ot
    
.gg:
    cmp eax, esi
    jg .ggg
    
    cmp eax, edi
    jg .ggg
    
    mov dword[cur], 1
    jmp .ot
.ggg:
    mov dword[cur], 0
    jmp end
.ot: 
    
    mov eax, dword[pr]
    cmp dword[cur], eax
    je .nxt
    cmp eax, 0
    je  .nxt
    mov dword[cur], 0
    jmp end

.nxt:
    mov eax, dword[cur]
    mov dword[pr], eax
    inc ebx
    jmp chk
end:
    mov eax, dword[cur]
    mov dword[m], eax
    
    mov eax, dword[output]
    mov dword[esp + 12], eax
    mov dword[esp + 8], 1
    mov dword[esp + 4], 4
    mov dword[esp], m
    call fwrite
    
    mov eax,[output]
    mov dword[esp],eax
    call fclose
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret