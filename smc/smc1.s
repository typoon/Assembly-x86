# Compile with:
# as -o smc1.o smc1.s
# ld -o smc1 smc1.o

.section .data
	hello_1: .asciz "Hello number 1!!!\n"
	bye: .asciz "Adios!\n"

.section .text
.globl _start
	# Align the code to a page boundary
	.align 4096

	_start:
		# Make memory rwx, using syscall sys_mprotect
		mov  $125, %eax
		movl $_start, %ebx

		# We will make everything from _start to _new_code_end rwx
		movl $(new_code_end - _start), %ecx
		movl $7, %edx
		int  $0x80

		loop:
			xor %eax, %eax
			movl $4, %eax
			movl $1, %ebx
			movl $hello_1, %ecx
			movl $17, %edx
			int $0x80

			# Make the code after loop something else
			movl $(new_code_end - new_code), %ecx
			movl $new_code, %esi
			movl $loop, %edi
			rep movsb

		jmp loop

		new_code:
			movl $4, %eax
			movl $1, %ebx
			movl $bye, %ecx
			movl $7, %edx
			int  $0x80

			movl $1, %eax
			xor %ebx, %ebx
			int $0x80
		new_code_end:

