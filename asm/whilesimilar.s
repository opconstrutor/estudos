# Use 'make CC=ld whilesimilar.o whilesimilar; rm whilesimilar.o' to compile, or
# 'as -o whilesimilar.o whilesimilar.s; ld -o whilesimilar whilesimilar.o; rm whilesimlar.o'
#

    .section    .data           # Put all your "variables" in

intro:
    .ascii "Hi, this is my first study in Assemby language\n"
    intro_len = .-intro         # '.-' collect dinamically the length of the label (memory location)

str:
    .ascii "Hello, World\n"
    str_len = .-str

    .section    .text           # introduce your code section
    .globl      _start          # declare '_start' as global (internal and external)
                                # to compile wiht gcc you need to change '_start' to 'main'
_start:
    
    movl    $0x4,       %eax    # output instruction
    movl    $0x1,       %ebx
    movl    $intro,     %ecx    # constant (real) value of the label 'intro'
    movl    $intro_len, %edx
    int     $0x80               # kernel interruption to execute your code

    movl    $0x1,       %edi    # the '%edi' register will be our 'index' of the loop
    jmp     _loop               # jump to the memory location '_loop'

_loop:
    
    cmpl    $10,        %edi    # compare the value of '%edi' with the constant '$10'
    jg      _end                # jump to '_end' if '%edi' is greater than '$10'

    movl    $0x4,       %eax    # another output code
    movl    $0x1,       %ebx
    movl    $str,       %ecx
    movl    $str_len,   %edx
    int     $0x80

    incl    %edi                # increment (%edi = %edi + 1) the value of '%edi' (index)
    jmp     _loop               # jump again to the first line in '_loop' label

_end:
    
    movl    $0x1,       %eax    # instruction to end our program
    movl    $0x0,       %ebx    # the status value of the execution, similar to 'return 0' in C
    int     $0x80
