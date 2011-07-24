# Compile with:
# as -o sdl.o sdl.s 
# ld -dynamic-linker /lib/ld-linux.so.2 -lc `sdl-config --libs` -o sdl sdl.o 

.section .data
    .equ WIDTH, 800
    .equ HEIGHT, 600
    .equ BPP, 32
    .equ SDL_INIT_VIDEO, 32
    .equ SDL_HWSURFACE, 1
    .equ SDL_DOUBLEBUF,1073741824


.section .bss
    .lcomm screen, 4
    
.section .text
.globl _start
_start:
    pushl $SDL_INIT_VIDEO
    call SDL_Init
    addl $0x04, %esp
    
    movl $SDL_DOUBLEBUF, %eax
    orl  $SDL_HWSURFACE, %eax
    pushl %eax
    pushl $BPP
    pushl $HEIGHT
    pushl $WIDTH
    call SDL_SetVideoMode
    addl $0x10, %esp
    mov %eax, screen 
    
    movl $0x05, %eax
    pushl %eax
    call sleep
    addl $0x04, %esp
    
    call SDL_Quit
    
    mov $1, %eax
    mov $0, %ebx
    int $0x80
