.section .data
enc:
    .string ""
str:
    .space 20
expected:
    .string ""

.section .text
    leaq str(%rip), %rsi
    leaq expected(%rip), %rdi
check_loop_HW1:
    movb (%rsi), %al
    movb (%rdi), %bl
    cmpb %al, %bl
    jne fail_test_HW1
    cmpb $0, %al
    je pass_test_HW1
    incq %rsi
    incq %rdi
    jmp check_loop_HW1
    
pass_test_HW1:
    movq $60, %rax
    movq $0, %rdi
    syscall
fail_test_HW1:
    movq $60, %rax
    movq $1, %rdi
    syscall