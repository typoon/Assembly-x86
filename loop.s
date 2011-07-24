.section .data
    array: .int 1, 10, 40, 23, 55, 80, 2, 33, 0
    mask: .asciz "%d\n"
.section .text
.globl _start
    _start:
        movl $0, %ecx
        
        loop:
            movl array(, %ecx, 4), %ebx
            pushl %ecx
            pushl %ebx
            pushl $mask
            call printf
            addl $0x08, %esp
            pop %ecx

            inc %ecx
            cmp $0, %ebx
            jne loop

        movl $0x01, %eax
        xorl %ebx,  %ebx
        int $0x80           

