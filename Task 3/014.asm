%include "io.inc"

section .data

rs dd 0

section .text
global CMAIN
CMAIN:
    GET_DEC 4, ebx
    GET_DEC 4, ecx
    cmp ecx, 0
    je e
    mov esi, 0
    mov edi, 2
    mov eax, ebx
e1:     
    cmp eax, 0
    je e2
    mov edx, 0
    div edi
    inc esi
    sub esi, edx
    jmp e1
e2: 
    cmp esi, ecx
    je p
e3:
    mov edi, 1
    shl edi, cl
    cmp edi, ebx
    jg an
    shr edi, 1
    mov eax, -1
st: 
    mov esi, ecx
    mov eax, ecx
a:  
    shl edi, 1
    
    inc eax
    cmp edi, ebx
    jle a
    dec eax
    dec eax
    mov edx, 1  
b:  
    cmp esi, eax
    jge c
    PRINT_DEC 4, rs
    PRINT_CHAR '.'
    PRINT_DEC 4, esi
    PRINT_CHAR '.'
    PRINT_DEC 4, edx
    PRINT_CHAR '.'
    PRINT_DEC 4, eax
    PRINT_CHAR '.'
    add dword[rs], edx
    inc esi
    imul edx, esi
    jmp b
c:  
    shr edi, 1
    sub ebx, edi
    PRINT_CHAR '.'
    PRINT_DEC 4, edi
    PRINT_CHAR '.'
    PRINT_DEC 4, eax
    PRINT_CHAR '.'
    PRINT_DEC 4, esi
    PRINT_CHAR '.'
    PRINT_DEC 4, ebx
    cmp ebx, 0
    jle an
    shl ebx, 1
d:  
    shr edi, 1
    dec ecx
    dec eax
    cmp edi, ebx
    jg d
    shr ebx, 1
    dec ecx
    dec eax
    mov esi, ecx
    cmp esi, -1
    jle an
    ;inc dword[rs]
    mov edx, 1
    PRINT_CHAR '/'
    PRINT_CHAR '.'
    PRINT_DEC 4, edi
    PRINT_CHAR '.'
    PRINT_DEC 4, eax
    PRINT_CHAR '.'
    PRINT_DEC 4, esi
    PRINT_CHAR '.'
    PRINT_DEC 4, ebx
    PRINT_CHAR '.'
    PRINT_CHAR '|'
    
    jmp b
an: 
    PRINT_DEC 4, rs
    xor eax, eax
    ret
   
e:  cmp ebx, 1
    je an
    inc dword[rs]
    shr ebx, 1
    jmp e
p:  inc dword[rs]
    jmp e3