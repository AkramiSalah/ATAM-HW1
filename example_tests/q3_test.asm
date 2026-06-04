.global test_start

.section .data
str:    .asciz "aaabbcdddd"
enc:    .space 50          # Allocate 50 empty bytes for your code to write into

.section .text
test_start:
    call _start

    # Check the result (We will verify the first 3 characters: "3a2")
    cmpb $'3', enc
    jne fail_test
    cmpb $'a', enc+1
    jne fail_test
    cmpb $'2', enc+2
    jne fail_test

pass_test:
    movq $60, %rax
    movq $0, %rdi
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi
    syscall