.section .data
    # The input string. We put 2 lowercase letters ('a' and 'c')
    str: .ascii "aB3cD\0" 
    
    # The output variable, initialized to 0
    count: .int 0         

.section .text
    # Your ex1.asm will run first. When it finishes, it will "fall through"
    # the bottom of your file and land right here.

end_of_ex1:
    # Load the result from memory into a register
    movl count(%rip), %eax
    
    # Compare the result to the expected answer (2)
    cmpl $2, %eax
    je test_passed

test_failed:
    # If it doesn't match 2, exit with code 1 (Fail)
    movq $60, %rax
    movq $1, %rdi
    syscall

test_passed:
    # If it matches 2, exit with code 0 (Pass)
    movq $60, %rax
    movq $0, %rdi
    syscall