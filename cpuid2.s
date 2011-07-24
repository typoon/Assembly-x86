# Compile with:
# as -o cpuid2.o cpuid2.s
# ld -dynamic-linker /lib/ld-linux.so.2 -lc -o cpuid2 cpuid2.o

.section .data
output:
    .asciz "The processor Vendor ID is '%s'\n"

.section .bss
    .lcomm buffer, 12

.section .text
.globl _start
_start:
    movl $0, %eax # Define CPUID function
    cpuid

    mov $buffer, %edi
    movl %ebx, (%edi)
    movl %edx, 4(%edi)
    movl %ecx, 8(%edi)
    pushl $buffer
    pushl $output
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80
