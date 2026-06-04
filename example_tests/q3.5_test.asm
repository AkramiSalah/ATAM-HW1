.global test_start

.section .data
enc:    .asciz "4a8c2D"
str:    .space 100         # Allocate 100 empty bytes for your decoded string

.section .text
test_start:
    call _start

    # Check the result (We will verify it starts with "aaaac")
    cmpb $'a', str
    jne fail_test
    cmpb $'a', str+3       # The 4th char should still be 'a'
    jne fail_test
    cmpb $'c', str+4       # The 5th char should switch to 'c'
    jne fail_test

pass_test:
    movq $60, %rax
    movq $0, %rdi
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi
    syscall