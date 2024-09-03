.data
    formatPrintf: .asciz "%d\n"
    chDelim: .asciz " "
    str_let: .asciz "let"
    str_add: .asciz "add"
    str_sub: .asciz "sub"
    str_mul: .asciz "mul"
    str_div: .asciz "div"
    instruction: .space 100
    res: .space 4
    aux: .space 4
    frecv: .space 2570
    penult: .long 0
    ult: .long 0

.text

.global main

main:
    pushl $instruction
    call gets
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
    cmpl $0, %eax
    je case_else_var

et_loop:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx
    movl %eax, res
    cmpl $0, %eax
    je et_exit

    pushl res
    call atoi
    popl %ebx
    cmpl $0, %eax
    jne case_else

verify_var:
    pushl res
    call strlen
    popl %ebx
    cmpl $1, %eax
    jne verify_op
    xorl %eax, %eax
    xorl %ecx, %ecx
    movl res, %edi
    movb (%edi, %ecx, 1), %al
    cmpb $0x61, %al
    jl verify_op
    cmpb $0x7A, %al
    jle case_else_var

verify_op:
    movl res, %edi
    xorl %ecx, %ecx
    mov (%edi, %ecx, 1), %al
    cmp $0x61, %al
    je case_add
    cmp $0x73, %al
    je case_sub
    cmp $0x6D, %al
    je case_mul
    cmp $0x64, %al
    je case_div

case_let:
    popl %ecx
    popl %eax
    lea frecv, %edi
    movl %ecx, (%edi, %eax, 4)
    jmp et_loop

case_add:
    mov penult, %eax
    cmp $0, %eax
    je add_penult_const
    mov ult, %eax
    cmp $0, %eax
    je add_v_c
    jmp add_v_v
    add_penult_const:
    mov ult, %eax
    cmp $1, %eax
    je add_c_v
    add_c_c:
    pop %eax
    pop %ecx
    add %ecx, %eax
    push %eax
    jmp et_loop
    add_c_v:
    pop %eax
    pop %ecx
    add frecv( , %eax, 1), %ecx
    push %ecx
    jmp et_loop
    add_v_c:
    pop %eax
    pop %ecx
    add frecv( , %ecx, 1), %eax
    push %eax
    jmp et_loop
    add_v_v:
    xorl %eax, %eax
    pop %ecx
    add frecv( , %ecx, 1), %eax
    pop %ecx
    add frecv( , %ecx, 1), %eax
    push %eax
    jmp et_loop

case_sub:
    mov penult, %eax
    cmp $0, %eax
    je sub_penult_const
    mov ult, %eax
    cmp $0, %eax
    je sub_v_c
    jmp sub_v_v
    sub_penult_const:
    mov ult, %eax
    cmp $1, %eax
    je sub_c_v
    sub_c_c:
    pop %eax
    pop %ecx
    sub %eax, %ecx
    push %ecx
    jmp et_loop
    sub_c_v:
    pop %eax
    pop %ecx
    sub frecv( , %eax, 1), %ecx
    push %ecx
    jmp et_loop
    sub_v_c:
    pop %eax
    pop %ecx
    sub frecv( , %ecx, 1), %eax
    push %eax
    jmp et_loop
    sub_v_v:
    xorl %eax, %eax
    pop %ebx
    pop %ecx
    add frecv( , %ecx, 1), %eax
    sub frecv( , %ebx, 1), %eax
    push %eax
    jmp et_loop

case_mul:
    mov penult, %eax
    cmp $0, %eax
    je mul_penult_const
    mov ult, %eax
    cmp $0, %eax
    je mul_v_c
    jmp mul_v_v
    mul_penult_const:
    mov ult, %eax
    cmp $1, %eax
    je mul_c_v
    mul_c_c:
    pop %eax
    pop %ecx
    mul %ecx
    push %eax
    jmp et_loop
    mul_c_v:
    pop %ecx
    pop %eax
    mull frecv( , %eax, 1)
    push %eax
    jmp et_loop
    mul_v_c:
    pop %eax
    pop %ecx
    mull frecv( , %ecx, 1)
    push %eax
    jmp et_loop
    mul_v_v:
    mov $1, %eax
    pop %ebx
    pop %ecx
    mull frecv( , %ebx, 1)
    mull frecv( , %ecx, 1)
    jmp et_loop

case_div:
    xorl %edx, %edx
    mov penult, %eax
    cmp $0, %eax
    je div_penult_const
    mov ult, %eax
    cmp $0, %eax
    je div_v_c
    jmp div_v_v
    div_penult_const:
    mov ult, %eax
    cmp $1, %eax
    je div_c_v
    div_c_c:
    pop %ecx
    pop %eax
    div %ecx
    push %eax
    jmp et_loop
    div_c_v:
    pop %ecx
    pop %eax
    divl frecv( , %ecx, 1)
    push %eax
    jmp et_loop
    div_v_c:
    pop %ecx
    pop %ebx
    mov frecv( , %ebx, 1), %eax
    div %ecx
    push %eax
    jmp et_loop
    div_v_v:
    pop %ecx
    pop %ebx
    mov frecv( , %ebx, 1), %eax
    divl frecv( , %ecx, 1)
    push %eax
    jmp et_loop

case_else:
    push %eax
    mov ult, %ecx
    mov %ecx, penult
    movl $0, ult
    jmp et_loop

case_else_var:
    movl res, %eax
    xorl %ecx, %ecx
    xorl %edx, %edx
    movb (%eax, %ecx, 1), %dl
    pushl %edx
    
    mov ult, %ecx
    mov %ecx, penult
    movl $1, ult
    jmp et_loop

et_exit:
    push $formatPrintf
    call printf
    pop %ebx
    pop %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
