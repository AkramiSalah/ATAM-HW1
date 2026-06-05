.global _start

.section .text
_start:

    leaq str(%rip), %rsi    # %rsi is the pointer for the source string 'str'
    leaq enc(%rip), %rdi    # %rdi is the pointer for the destination string 'enc'

    movb $0 ,%bl        #eax will hold the last char, here it is set to 0 since it is an illegal char
    movl $0, %ecx       #ebx will be the counter

loop_HW1:
    movb (%rsi), %al       #al - next char

    cmpb $0, %al
    je end_of_string_HW1

    #if next char matches last one
    cmpb %al, %bl
    jne handle_next_char_is_new_HW1
    incl %ecx
    incq %rsi
    jmp loop_HW1

handle_next_char_is_new_HW1:
    cmpl $1, %ecx
    jle setup_next_char_HW1
    movb %cl, %dl
    addb $0x30, %dl         #number to ascii
    movb %dl, (%rdi)        #write char
    incq %rdi
    movb %bl, (%rdi)        #write number
    incq %rdi

setup_next_char_HW1:
    movl $1, %ecx
    movb %al, %bl
    incq %rsi
    jmp loop_HW1

end_of_string_HW1:
    #attempt writing last chain
    cmpl $1, %ecx
    jle finish_HW1

    movb %cl, %dl
    addb $0x30, %dl
    movb %dl, (%rdi)    #write char
    incq %rdi
    movb %bl, (%rdi)    #write number
    incq %rdi

finish_HW1:
    # add $0 to null terminated string
    movb $0, (%rdi)

