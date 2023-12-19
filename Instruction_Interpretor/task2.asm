.data
    formatPrintf: .asciz "%d\n"
    formatScanf: .asciz "%[^\n]s"
    instruction: .space 100
    chDelim: .asciz " "
    res: .space 4
    atoiRes: .space 4
    firstNumber: .space 4
    x: .space 4

.text

.global main

main:

    pushl $instruction
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    pushl $chDelim
    pushl $instruction
    call strtok
    popl %ebx
    popl %ebx
    movl %eax, res

    pushl res
    call atoi
    popl %ebx
    movl %eax, firstNumber
    pushl firstNumber

et_loop:

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx
    movl %eax, res
    b1:
    cmpl $0, %eax
    je et_exit

    pushl res
    call atoi
    popl %ebx
    movl %eax, atoiRes
    b2:
    cmp $0, %eax
    jne case_else
    b3:
    xorl %ecx, %ecx
    movl res, %edi
    mov (%edi, %ecx, 1), %eax
    b4:
    cmp $0x61, %al
    je case_add
    cmp $0x73, %al
    je case_sub
    cmp $0x6D, %al
    je case_mul
    cmp $0x64, %al
    je case_div

case_add:
    pop %eax
    pop %ecx
    add %ecx, %eax
    push %eax
    jmp et_loop

case_sub:
    pop %ecx
    pop %eax
    sub %ecx, %eax
    push %eax
    jmp et_loop

case_mul:
    pop %eax
    pop %ecx
    mul %ecx
    push %eax
    jmp et_loop

case_div:
    xorl %edx, %edx
    pop %ecx
    pop %eax
    idiv %ecx
    push %eax
    jmp et_loop

case_else:
    push atoiRes
    jmp et_loop

et_exit:
    push $formatPrintf
    call printf
    pop %ebx
    pop %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
