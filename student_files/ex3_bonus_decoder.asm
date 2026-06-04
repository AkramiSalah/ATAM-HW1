.global _start

.section .text
_start:
    leaq enc(%rip), %rsi        # %rsi is the pointer for the source string
    leaq str(%rip), %rdi        # %rdi is the pointer for the result

read_pair_loop_HW1:
    movb (%rsi), %al            # al will hold the count value

    # Check end of string
    cmpb $0, %al
    je end_HW1

    subb $0x30, %al             # from ascii to int
    movl $0, %ecx               # ecx will act as the counter
    movb %al, %cl               # set counter to the desired count

    incq %rsi

    movb (%rsi), %dl            # %dl - char to use
    incq %rsi                   # prepare for next pair

write_letter_loop_HW1:
    cmpl $0, %ecx
    je read_pair_loop_HW1       # If count is 0, finished with this char

    movb %dl, (%rdi)
    incq %rdi
    decl %ecx                   # Decrease the counter by 1
    jmp write_letter_loop_HW1

end_HW1:
    movb $0, (%rdi)             # Add string ending
    ret
