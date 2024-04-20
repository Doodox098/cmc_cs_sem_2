%include "io.inc"

                    SECTION .text

                    GLOBAL CMAIN
                    CMAIN:
                        GET_DEC         4, ECX

                        MOV             EBX, 1
                        XOR             EAX, EAX

                    .L:
                        XOR             EAX, EBX
                        XOR             EBX, EAX
                        XOR             EAX, EBX

                        ADD             EBX, EAX
                        LOOP            .L

                        PRINT_UDEC      4, EAX
                        NEWLINE

                        XOR             EAX, EAX
                        RET