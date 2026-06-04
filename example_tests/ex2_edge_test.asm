.global test_start

.section .data
exp:    .asciz "([)]"      # Interleaved brackets (Invalid)
valid:  .int 1             # Pre-set to 1 to ensure your code actively changes it to 0

.section .text
test_start:
    call _start

    # Check the result
    cmpl $0, valid         # We expect 'valid' to be 0
    jne fail_test

pass_test:
    movq $60, %rax
    movq $0, %rdi
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi
    syscall