%include "io.inc"

section .rodata

formatina db '%s', 0
formatink db '%d', 0
formatind db '%d', 0
formatout db '%d %d', 10, 0

section .data

root dd 0

section .bss

struc treenode
.key: resd 1
.dta: resd 1
.right_son: resd 1
.left_son: resd 1
endstruc

key resd 1
data resd 1
action resb 1

section .text
global CMAIN
CEXTERN strstr
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

new_node:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    mov dword[esp], 16
    call malloc
    mov ecx, eax
    mov eax, dword[ebp + 8]
    mov dword[ecx + treenode.key], eax
    mov eax, dword[ebp + 12]
    mov dword[ecx + treenode.dta], eax
    mov dword[ecx + treenode.right_son], 0
    mov dword[ecx + treenode.left_son], 0
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret
    
add_node:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    mov ecx, dword[ebp + 8]
    cmp ecx, 0
    jne .mal
    mov eax, dword[ebp + 16]
    mov dword[esp + 4], eax
    mov eax, dword[ebp + 12]
    mov dword[esp], eax
    call new_node
    mov ecx, eax
    jmp .end
.mal:
    mov edx, dword[ebp + 12]
    mov eax, dword[ebp + 16]
    cmp dword[ecx], edx
    jne .gl
    mov dword[ecx + treenode.dta], eax
    jmp .end
.gl:
    mov dword[esp + 12], ecx
    mov eax, dword[ebp + 16]
    mov dword[esp + 8], eax
    mov eax, dword[ebp + 12]
    mov dword[esp + 4], eax
    cmp dword[ecx], edx
    jg .gs
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call add_node
    mov ecx, dword[esp + 12]
    mov dword[ecx + treenode.right_son], eax
    jmp .end
.gs:
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp], eax
    call add_node
    mov ecx, dword[esp + 12]
    mov dword[ecx + treenode.left_son], eax
    jmp .end
.end:
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret
    
search_node:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    
    mov eax, 0
    mov ecx, dword[ebp + 8]
    cmp ecx, 0
    jne .mal
    jmp .end
.mal:
    mov edx, dword[ebp + 12]
    cmp dword[ecx], edx
    jne .gl
    mov dword[esp + 4], edx
    mov edx, dword[ecx + treenode.dta]
    mov dword[esp + 8], edx
    mov dword[esp], formatout
    call printf
    jmp .end
.gl:
    mov dword[esp + 4], edx
    cmp dword[ecx], edx
    jg .gs
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call search_node
    mov ecx, dword[esp + 12]
    jmp .end
.gs:
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp], eax
    call search_node
    mov ecx, dword[esp + 12]
    jmp .end
.end:
    
    mov esp, ebp
    pop ebp
    ret
    
delete_node:

    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov eax, ecx
    cmp ecx, 0
    je .end
    
    mov edx, dword[ebp + 12]
    cmp dword[ecx], edx
    jne .gl
    
    cmp dword[ecx + treenode.right_son], 0
    jne .nxr
    
    cmp dword[ecx + treenode.left_son], 0
    jne .nxl
    
    mov dword[esp], ecx
    call free
    mov eax, 0
    jmp .end
    
.nxr:
    cmp dword[ecx + treenode.left_son], 0
    jne .nxt
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp + 4], eax
    mov dword[esp], ecx
    call free
    mov eax, dword[esp + 4]
    jmp .end
.nxl:
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp + 4], eax
    mov dword[esp], ecx
    call free
    mov eax, dword[esp + 4]

    jmp .end
.nxt:
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp + 4], ecx
    mov dword[esp], eax
    call find_max
    mov ecx, dword[esp + 4]
    mov dword[ecx + treenode.key], eax
    mov dword[ecx + treenode.dta], edx
    mov dword[esp + 8], ecx
    mov dword[esp + 4], eax
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp], eax
    call delete_node
    mov ecx, dword[esp + 8]
    mov dword[ecx + treenode.left_son], eax
    mov eax, ecx
    jmp .end
.gl:
    cmp dword[ecx], edx
    jg .gs
    mov dword[esp + 8], ecx
    mov dword[esp + 4], edx
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call delete_node
    mov ecx, dword[esp + 8]
    mov dword[ecx + treenode.right_son], eax
    mov eax, ecx
    jmp .end
.gs:
    mov dword[esp + 8], ecx
    mov dword[esp + 4], edx
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp], eax
    call delete_node
    mov ecx, dword[esp + 8]
    mov dword[ecx + treenode.left_son], eax
    mov eax, ecx
.end:
    mov esp, ebp
    pop ebp
    ret
    
my_free:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    cmp ecx, 0
    je .end
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call my_free
    mov eax, dword[ecx + treenode.left_son]
    mov dword[esp], eax
    call my_free
    mov dword[esp], ecx
    call free
    jmp .end
.end:   
    mov esp, ebp
    pop ebp
    ret
    
find_max:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
    
    mov eax, 0
    mov ecx, dword[ebp + 8]
    cmp ecx, 0
    je .end
    
    mov dword[esp + 4], ecx
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call find_max
    mov ecx, dword[esp + 4]
    cmp dword[ecx + treenode.key], eax
    jl .nxf
    mov eax, dword[ecx + treenode.key]
    mov edx, dword[ecx + treenode.dta]
.nxf:
    mov dword[esp + 12], ecx
    mov dword[esp + 8], edx
    mov dword[esp + 4], eax
    mov eax, dword[ecx + treenode.right_son]
    mov dword[esp], eax
    call find_max
    mov ecx, dword[esp + 12]
    cmp dword[esp + 4], eax
    jl .end
    mov eax, dword[esp + 4]
    mov edx, dword[esp + 8]
.end:
    mov esp, ebp
    pop ebp
    ret
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~0xF
    sub esp, 16
whl: 
    mov dword[esp + 4], action
    mov dword[esp], formatina
    call scanf
    cmp byte[action], 'F'
    je end
    
    mov dword[esp + 4], key
    mov dword[esp], formatink
    call scanf
    cmp byte[action], 'A'
    jne na
    
    mov dword[esp + 4], data
    mov dword[esp], formatind
    call scanf
    
    mov eax, dword[data]
    mov dword[esp + 8], eax
    mov eax, dword[key]
    mov dword[esp + 4], eax
    mov eax, dword[root]
    mov dword[esp], eax
    call add_node
    mov dword[root], eax
    mov eax, dword[root]
    jmp whl
na:
    cmp byte[action], 'D'
    jne nd
    mov eax, dword[key]
    mov dword[esp + 4], eax
    mov eax, dword[root]
    mov dword[esp], eax
    call delete_node
    mov dword[root], eax
    jmp whl
nd: 
    mov eax, dword[key]
    mov dword[esp + 4], eax
    mov eax, dword[root]
    mov dword[esp], eax
    call search_node
    jmp whl
end:
    mov eax, dword[root]
    mov dword[esp], eax
    call my_free
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret