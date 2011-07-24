# Compile with:
# as -gstabs -o scanf.o scanf.s 
# ld -dynamic-linker /lib/ld-linux.so.2 -lc -o scanf scanf.o 

.section .data
    msg: .asciz "Please type your name:\n"
    mask: .asciz "%s"
    output: .asciz "Your name is %s\n"

.section .bss
    .lcomm input, 32

.section .text
.globl _start
    _start:
        pushl $msg
        call printf
        addl $4, %esp

        pushl $input
        pushl $mask
        call scanf
        addl $8, %esp
        
        pushl $input
        pushl $output
        call printf
        addl $8, %esp

        mov $0x01, %eax
        xor %ebx, %ebx
        int $0x80
