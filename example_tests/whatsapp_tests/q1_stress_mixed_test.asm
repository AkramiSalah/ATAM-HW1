.section .data
str:
    .fill 15000, 1, 'Z'
    .fill 5000, 1, 'a'
    .fill 10000, 1, '9'
    .fill 6000, 1, 'z'
    .fill 25000, 1, '!'
    .byte 0
count:
    .int 9999

.section .text
    cmpl $11000, count(%rip)
    jne fail_test_HW1
pass_test_HW1:
    movq $60, %rax
    xorq %rdi, %rdi
    syscall
fail_test_HW1:
    movq $60, %rax
    movq $1, %rdi
    syscall
