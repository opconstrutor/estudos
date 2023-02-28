# Compilation: make CC=ld inputwhile.o inputwhile; rm inputwhile.o
# or as -o inputwhile.o inputwhile.s; ld -o inputwhile inputwhile.o; rm inputwhile.o
#

    .section    .data

msg_input:
    .ascii  "Enter your message here: "
    len_input = .- msg_input

    .section    .text
    .globl      _start

_start:
    
    movl $0x4,       %eax
    movl $0x1,       %ebx
    movl $msg_input, %ecx
    movl $len_input, %edx
    int  $0x80

    movl $0x3,       %eax       # instruction for collect input data
    movl $0x1,       %ebx
    movl $input,     %ecx       # memory location to save you input
    movl $0xa,       %edx       # size of the input data
    int  $0x80                  # kernel interruption to execute code

    movl $0x1,       %edi       # our index
    jmp  _while                 # jumping to the while loop

_while:
    
    cmpl $0xa,       %edi       # compare '%edi' with '$0xa' (10 in hexadecimal system)
    jg   _exit                  # jump to _exit if greater than '0xa'

    movl $0x4,       %eax
    movl $0x1,       %ebx
    movl $input,     %ecx
    movl $0xa,       %edx
    int  $0x80

    incl %edi                   # increment instruction
    jmp  _while                 # return to while comparation

_exit:
    
    movl $0x1,       %eax       # exit instruction
    movl $0x0,       %ebx       # status value
    int  $0x80

    .section    .bss            # dynamic memory location

input: .skip 0xa                # '.skip 0xa' = skip 10 bits for input label (memory location)
