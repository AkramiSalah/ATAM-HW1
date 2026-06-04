.global test_start

.section .data
str:    .asciz "abc"       # No repeats
enc:    .space 10          # Allocate space

.section .text
test_start:
    call _start

    # Check the result (The very first byte MUST be the null-terminator 0x00)
    cmpb $0, enc
    jne fail_test

pass_test:
    movq $60, %rax
    movq $0, %rdi
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi
    syscall