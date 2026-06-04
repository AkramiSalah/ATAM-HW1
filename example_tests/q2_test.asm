.global test_start

.section .data
exp:    .asciz "{[()]}"    # The test string (Balanced)
valid:  .int 0             # The output variable

.section .text
test_start:
    call _start            # Call your submission code

    # Check the result
    cmpl $1, valid         # We expect 'valid' to be 1 for a balanced string
    jne fail_test

pass_test:
    movq $60, %rax         # syscall number for sys_exit
    movq $0, %rdi          # 0 = success exit code
    syscall

fail_test:
    movq $60, %rax
    movq $1, %rdi          # 1 = failure exit code
    syscall