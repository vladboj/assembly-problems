.data
    formatScanf: .asciz "%[^\n]s"
    formatPrintf_const: .asciz "%d "
    formatPrintf_neg_const: .asciz "-%d "
    formatPrintf_var: .asciz "%c "
    formatPrintf_op: .asciz "%s "
    formatPrintf_newline: .asciz "\n"
    str_let: .asciz "let"
    str_add: .asciz "add"
    str_sub: .asciz "sub"
    str_mul: .asciz "mul"
    str_div: .asciz "div"
    str: .space 100


.text

.global main
main:
    pushl $str
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

et_loop:
    movl $0, %eax
    movl $0, %ecx
    movl $0, %edx
   
    mov (%ebx), %al
    cmpb $0, %al
    je et_exit
    incl %ebx
    movb (%ebx), %cl
    shl $8, %ecx
    incl %ebx
    movb (%ebx), %cl
    incl %ebx

    push %eax

process_all:
    verifiy_first_hex:
    cmpb $0x30, %ch
    je give_ZERO_first_hex
    cmpb $0x31, %ch
    je give_ONE_first_hex
    cmpb $0x32, %ch
    je give_TWO_first_hex
    cmpb $0x33, %ch
    je give_THREE_first_hex
    cmpb $0x34, %ch
    je give_FOUR_first_hex
    cmpb $0x35, %ch
    je give_FIVE_first_hex
    cmpb $0x36, %ch
    je give_SIX_first_hex
    cmpb $0x37, %ch
    je give_SEVEN_first_hex
    cmpb $0x38, %ch
    je give_EIGHT_first_hex
    cmpb $0x39, %ch
    je give_NINE_first_hex
    cmpb $0x41, %ch
    je give_TEN_first_hex
    cmpb $0x42, %ch
    je give_ELEVEN_first_hex
    cmpb $0x43, %ch
    je give_TWELVE_first_hex
    cmpb $0x44, %ch
    je give_THIRTEEN_first_hex
    cmpb $0x45, %ch
    je give_FOURTEEN_first_hex
    cmpb $0x46, %ch
    je give_FIFTEEN_first_hex
    verify_second_hex:
    cmpb $0x30, %cl
    je give_ZERO_second_hex
    cmpb $0x31, %cl
    je give_ONE_second_hex
    cmpb $0x32, %cl
    je give_TWO_second_hex
    cmpb $0x33, %cl
    je give_THREE_second_hex
    cmpb $0x34, %cl
    je give_FOUR_second_hex
    cmpb $0x35, %cl
    je give_FIVE_second_hex
    cmpb $0x36, %cl
    je give_SIX_second_hex
    cmpb $0x37, %cl
    je give_SEVEN_second_hex
    cmpb $0x38, %cl
    je give_EIGHT_second_hex
    cmpb $0x39, %cl
    je give_NINE_second_hex
    cmpb $0x41, %cl
    je give_TEN_second_hex
    cmpb $0x42, %cl
    je give_ELEVEN_second_hex
    cmpb $0x43, %cl
    je give_TWELVE_second_hex
    cmpb $0x44, %cl
    je give_THIRTEEN_second_hex
    cmpb $0x45, %cl
    je give_FOURTEEN_second_hex
    cmpb $0x46, %cl
    je give_FIFTEEN_second_hex
    hex_to_dec:
    mov $16, %ecx
    mov %dh, %al
    push %dx
    mul %ecx
    pop %dx
    add %dl, %al
    jmp verify_nature



give_ZERO_first_hex:
    movb $0, %dh
    jmp verify_second_hex
give_ONE_first_hex:
    movb $1, %dh
    jmp verify_second_hex
give_TWO_first_hex:
    movb $2, %dh
    jmp verify_second_hex
give_THREE_first_hex:
    movb $3, %dh
    jmp verify_second_hex
give_FOUR_first_hex:
    movb $4, %dh
    jmp verify_second_hex
give_FIVE_first_hex:
    movb $5, %dh
    jmp verify_second_hex
give_SIX_first_hex:
    movb $6, %dh
    jmp verify_second_hex
give_SEVEN_first_hex:
    movb $7, %dh
    jmp verify_second_hex
give_EIGHT_first_hex:
    movb $8, %dh
    jmp verify_second_hex
give_NINE_first_hex:
    movb $9, %dh
    jmp verify_second_hex
give_TEN_first_hex:
    movb $10, %dh
    jmp verify_second_hex
give_ELEVEN_first_hex:
    movb $11, %dh
    jmp verify_second_hex
give_TWELVE_first_hex:
    movb $12, %dh
    jmp verify_second_hex
give_THIRTEEN_first_hex:
    movb $13, %dh
    jmp verify_second_hex
give_FOURTEEN_first_hex:
    movb $14, %dh
    jmp verify_second_hex
give_FIFTEEN_first_hex:
    movb $15, %dh
    jmp verify_second_hex



give_ZERO_second_hex:
    movb $0, %dl
    jmp hex_to_dec
give_ONE_second_hex:
    movb $1, %dl
    jmp hex_to_dec
give_TWO_second_hex:
    movb $2, %dl
    jmp hex_to_dec
give_THREE_second_hex:
    movb $3, %dl
    jmp hex_to_dec
give_FOUR_second_hex:
    movb $4, %dl
    jmp hex_to_dec
give_FIVE_second_hex:
    movb $5, %dl
    jmp hex_to_dec
give_SIX_second_hex:
    movb $6, %dl
    jmp hex_to_dec
give_SEVEN_second_hex:
    movb $7, %dl
    jmp hex_to_dec
give_EIGHT_second_hex:
    movb $8, %dl
    jmp hex_to_dec
give_NINE_second_hex:
    movb $9, %dl
    jmp hex_to_dec
give_TEN_second_hex:
    movb $10, %dl
    jmp hex_to_dec
give_ELEVEN_second_hex:
    movb $11, %dl
    jmp hex_to_dec
give_TWELVE_second_hex:
    movb $12, %dl
    jmp hex_to_dec
give_THIRTEEN_second_hex:
    movb $13, %dl
    jmp hex_to_dec
give_FOURTEEN_second_hex:
    movb $14, %dl
    jmp hex_to_dec
give_FIFTEEN_second_hex:
    movb $15, %dl
    jmp hex_to_dec

verify_nature:
    pop %ecx
    cmpb $0x38, %cl
    je print_pos_const
    cmp $0x39, %cl
    je print_neg_const
    cmp $0x41, %cl
    je print_var
    cmp $0x43, %cl
    je decide_op

decide_op:
    cmp $0, %eax
    je print_let
    cmp $1, %eax
    je print_add
    cmp $2, %eax
    je print_sub
    cmp $3, %eax
    je print_mul
    cmp $4, %eax
    je print_div

print_pos_const:
    pushl %eax
    pushl $formatPrintf_const
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_neg_const:
    pushl %eax
    pushl $formatPrintf_neg_const
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_var:
    pushl %eax
    pushl $formatPrintf_var
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_let:
    pushl $str_let
    pushl $formatPrintf_op
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_add:
    pushl $str_add
    pushl $formatPrintf_op
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_sub:
    pushl $str_sub
    pushl $formatPrintf_op
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_mul:
    pushl $str_mul
    pushl $formatPrintf_op
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

print_div:
    pushl $str_div
    pushl $formatPrintf_op
    call printf
    popl %edi
    popl %edi
    pushl $0
    call fflush
    popl %edi
    jmp et_loop

et_exit:
    pushl $formatPrintf_newline
    call printf
    popl %edi
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
