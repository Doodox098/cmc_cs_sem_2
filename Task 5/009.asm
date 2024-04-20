%include "io.inc"

section .data

nxtln db 10, 0
formatnum db "%d ", 0
dimm dd 0
max dq 0x80000000

section .bss

trace resq 1
maxm resd 1
matrix resd 1
num resd 1
dim resq 1

section .text
CEXTERN calloc
CEXTERN scanf
CEXTERN printf
CEXTERN free    
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 12
    and esp, ~0xF
    
    mov dword[esp + 4], num
    mov dword[esp], formatnum
    call scanf
    
    mov ebx, 0
rd:
    cmp ebx, dword[num]
    jnl erd
    mov dword[esp + 4], dim
    mov dword[esp], formatnum
    call scanf
    
    mov eax, dword[dim]
    mul eax
    mov esi, eax
    mov dword[esp + 4], eax
    mov dword[esp], 4
    call calloc
    mov dword[matrix], eax
    mov edx, 0
    mov dword[trace], 0
    mov dword[trace + 4], 0
    mov edi, 0
    cur:
        cmp edi, esi
        jnl ecur
        shl edi, 2
        mov eax, dword[matrix]
        add eax, edi
        shr edi, 2
        mov dword[esp + 8], edx
        mov dword[esp + 4], eax
        mov dword[esp], formatnum
        call scanf
        mov edx, dword[esp + 8]
        cmp edx, edi
        jne nx
        mov eax, dword[matrix]
        shl edi, 2
        add eax, edi
        shr edi, 2
        mov eax, dword[eax]
        add edx, dword[dim]
        inc edx
        add dword[trace], eax
        jno nx
        inc dword[trace + 4]
    nx:
        inc edi
        jmp cur
    ecur:
    mov eax, dword[max + 4]
    cmp eax, dword[trace + 4]
    jg ls
    jnl ub
    mov eax, dword[maxm]
    mov dword[esp], eax
    call free
    mov eax, dword[trace + 4]
    mov dword [max + 4], eax
    mov eax, dword[trace]
    mov dword [max], eax
    mov eax, dword[dim]
    mov dword[dimm], eax
    mov eax, dword[matrix]
    mov dword[maxm], eax
    jmp lg
ub:
    mov eax, dword[max]
    cmp eax, dword[trace]
    jnl ls
    mov eax, dword[maxm]
    mov dword[esp], eax
    call free
    mov eax, dword[trace + 4]
    mov dword [max + 4], eax
    mov eax, dword[trace]
    mov dword [max], eax
    mov eax, dword[dim]
    mov dword[dimm], eax
    mov eax, dword[matrix]
    mov dword[maxm], eax
    jmp lg
ls:
    mov eax, dword[matrix]
    mov dword[esp], eax
    call free
lg:
    inc ebx
    jmp rd
erd:
    mov edi, 0
prt:
    cmp edi, dword[dimm]
    je eprt
    mov esi, 0
    mov ebx, edi
    imul ebx, dword[dimm]
    prt1:
        cmp esi, dword[dimm]
        je eprt1
        mov eax, dword[maxm]
        add ebx, esi
        shl ebx, 2
        add eax, ebx
        shr ebx, 2
        sub ebx, esi
        mov eax, dword[eax]
        mov dword[esp + 4], eax
        mov dword[esp], formatnum
        call printf
        inc esi
        jmp prt1
    eprt1:
    mov dword[esp], nxtln
    call printf
    inc edi
    jmp prt
eprt:
    mov eax, dword[maxm]
    mov dword[esp], eax
    call free
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret