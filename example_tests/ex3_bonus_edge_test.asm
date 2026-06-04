.global test_start

.section .data
enc:    .asciz "9A1z"
str:    .space 20          # Allocate space

.section .text
test_start:
    call _start

    # Check the result (We verify the 9th and 10th characters)
    # The 9th character (index 8) should be 'A'
    cmpb $'A', str+8
    jne fail_test

    # The 10th character (index 9) should be 'z'
    cmpb $'z', str+9
    jne fail_test

    # The 11th character (index 10) must be the null-terminator
    cmpb $0, str+10
    jne fail_test

pass_test:
    movq $60, %rax
    movq $0, %rdi
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi
    syscall