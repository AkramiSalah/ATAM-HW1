.section .data
str:
    .string "aB12c!Z"
count:
    .int 9999

.section .text
    cmpl $2, count(%rip)
    jne fail_test_HW1
pass_test_HW1:
    movq $60, %rax
    xorq %rdi, %rdi
    syscall
fail_test_HW1:
    movq $60, %rax
    movq $1, %rdi
    syscall
