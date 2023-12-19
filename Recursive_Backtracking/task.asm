.data
    formatScanf: .asciz "%[^\n]s"
    formatPrintf: .asciz "%d "
    formatPrintf_newline: .asciz "\n"
    formatPrintf_exceptie: .asciz "%d\n"
    chDelim: .asciz " "
    N: .space 4
    M: .space 4
    input: .space 185
    car: .space 361
    sol: .space 361
    gasit: .long 0
    k: .long 0

.text

afisare:

    movl $0, %ecx
    movl N, %eax
    movl $3, %ebx
    mull %ebx               # %eax = 3 * n

    afisare_loop:
    cmpl %ecx, %eax
    jne afis
    pushl $formatPrintf_newline
    call printf             # printf("\n")
    popl %ebx
    # return
    movl $1, %eax
    movl %eax, gasit
    ret

    afis:
    pushl %ecx
    pushl %eax
    pushl (%esi, %ecx, 4)
    pushl $formatPrintf
    call printf             # printf("%d ", sol[i])
    popl %ebx
    popl %ebx
    popl %eax
    popl %ecx
    incl %ecx               # i++
    jmp afisare_loop

solutie:
    pushl %ecx

    solutie_primul_if:
    xorl %edx, %edx
    movl N, %eax
    movl $3, %ebx
    mull %ebx
    subl $1, %eax       # %eax = 3 * n - 1
    movl k, %ebx        # %ebx = k
    cmpl %ebx, %eax
    jg solutie_return_0

    lea car, %edi
    # for-ul
    movl $-1, %ecx
    solutie_loop:
    incl %ecx
    cmpl %ecx, %eax
    jl solutie_return_1
    solutie_doilea_if:
    movl (%edi, %ecx, 4), %ebx      # %ebx = car[i]
    movl (%esi, %ecx, 4), %edx      # %edx = sol[i]
    cmpl $0, %ebx
    je solutie_loop
    solutie_treilea_if:
    cmpl %edx, %ebx
    je solutie_loop

    # return 0
    solutie_return_0:
    movl $0, %edx
    popl %ecx
    ret

    # return 1
    solutie_return_1:
    movl $1, %edx
    popl %ecx
    ret

ok:
    pushl %ecx

    movl k, %ebx
    movl (%esi, %ebx, 4), %edx      # %edx = sol[k]

    xorl %ebx, %ebx                 # counter = 0
    # simulez primul for
    movl $-1, %ecx
    ok_loop_1:
    incl %ecx                       # i++
    movl k, %eax
    cmpl %eax, %ecx
    je ok_doilea_if
    movl (%esi, %ecx, 4), %eax      # %eax = sol[i]
    
    ok_primul_if:
    cmpl %eax, %edx                 # if(sol[i] == sol[k])
    jne ok_loop_1
    incl %ebx
    jmp ok_loop_1

    ok_doilea_if:
    cmpl $3, %ebx                   # if(counter >= 3)
    jl ok_treilea_if

    # return 0
    ok_return_0:
    movl $0, %edx
    popl %ecx
    ret

    ok_treilea_if:
    movl k, %ebx
    cmpl $0, %ebx       # if(k > 0)
    jg min

    # return 1
    ok_return_1:
    movl $1, %edx
    popl %ecx
    ret

    # k - min(k, m)
    min:
    movl M, %eax        # %eax = M
    movl k, %edx        # %edx = k
    cmpl %eax, %edx
    jl k_mic_m
    jmp m_mic_k

    k_mic_m:
    movl $0, %edx
    jmp here

    m_mic_k:
    subl %eax, %edx

    # simulez al doilea for
    here:
    movl (%esi, %ebx, 4), %eax      # %eax = sol[k]
    movl %ebx, %ecx                 # %ecx = k
    ok_loop_2:
    subl $1, %ecx
    cmpl %ecx, %edx
    jg ok_return_1
    ok_patrulea_if:
    movl (%esi, %ecx, 4), %edi      # %edi = sol[i]
    cmpl %edi, %eax                 # if(sol[i] == sol[k])
    je ok_return_0
    jmp ok_loop_2

back:

    pushl %ecx
    xorl %ecx, %ecx
    back_for:
    incl %ecx
    cmpl N, %ecx
    jg break
    back_primul_if:
    movl gasit, %eax
    cmpl $1, %eax                   # if(gasit == 1)
    je break
    sol_k:
    movl k, %eax
    movl %ecx, (%esi, %eax, 4)      # sol[k] = i
    back_doilea_if:
    call ok
    cmpl $0, %edx       # if(ok() == 0)
    je back_for
    back_treilea_if:
    call solutie
    cmpl $0, %edx       # if(solutie() == 0)
    je recall
    call afisare
    jmp break

    recall:
    movl k, %eax
    incl %eax
    movl %eax, k        # k++
    call back
    movl k, %eax
    subl $1, %eax
    movl %eax, k        # k--
    jmp back_for

    break:
    popl %ecx
    ret


.global main

main:

    # citesc inputul
    pushl $input
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    # populez N si M
    pop_N:
    pushl $chDelim
    pushl $input
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    movl %eax, N

    pop_M:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    movl %eax, M

    # transform inputul in vector
    lea car, %esi
    xorl %ecx, %ecx
    
    str_to_arr:
    pushl %ecx
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmpl $0, %eax
    je apel_back

    pushl %eax
    call atoi
    popl %ebx

    popl %ecx
    movl %eax, (%esi, %ecx, 4)
    incl %ecx
    jmp str_to_arr

    apel_back:
    lea sol, %esi
    call back
    
    # verific daca s-a gasit solutia
    movl gasit, %eax
    cmpl $0, %eax
    jne exit
    # daca nu s-a gasit, afisez -1
    pushl $-1
    pushl $formatPrintf_exceptie
    call printf
    popl %ebx
    popl %ebx

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80