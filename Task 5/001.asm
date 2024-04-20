%include "io.inc"

section .data 

formatout db "0x%08X",10, 0
formatin db "%ud",0

section .bss

x resd 1

section .text
global CMAIN
CEXTERN printf
CEXTERN scanf
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~0xF
st:
    mov dword[esp + 4], x
    mov dword[esp], formatin
    call scanf
    cmp eax, -1
    je end
    mov eax, dword[x]
    mov dword[esp + 4], eax
    mov dword[esp],formatout
    call printf
    jmp st
end:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret