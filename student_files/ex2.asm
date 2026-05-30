.global _start

.section .text
_start:
#prolog
    pushq %rbp
    movq  %rsp, %rbp

loop_HW1:
    #rdi has pointer to char from memory
    #al holds the char value
    movb (%rdi), %al

    cmpb $0, %al
    jne string_not_empty_HW1

    #string is empty
    cmpq %rsp, %rbp  # Compare the Top (%rsp) with the Bottom (%rbp)
    je return_1_HW1  # If they are equal, all the bracets were closed.
    jmp return_0_HW1

string_not_empty_HW1:
    #open bracet section:
    #if the next char opens a bracket then it is legal.
    #bracet by numbers: 1 = [ , 2 = {, 3 = (
    cmpb $0x5B, %al #[
    jne check_bracet2_HW1
    pushq $0x5D
    jmp go_next_char_HW1

check_bracet2_HW1:
    cmpb $0x7B, %al #{
    jne check_bracet3_HW1
    pushq $0x7D
    jmp go_next_char_HW1

check_bracet3_HW1:
    cmpb $0x28, %al #(
    jne check_closing_bracet_HW1
    pushq $0x29
    jmp go_next_char_HW1

check_closing_bracet_HW1:
    #if the stack is empty, we are not searching for a closing bracet and so fail.
    cmpq %rsp, %rbp
    je return_0_HW1

    #if we encounter a closing bracet that dosnt match the one we search, fail.
    movb (%rsp), %cl # cl will hold the char that is currently being searched.
    cmpb %cl, %al
    jne return_0_HW1

    popq %rcx #remove old searched value (garbage value now)
    jmp go_next_char_HW1

go_next_char_HW1:
    incq %rdi
    jmp loop_HW1

return_1_HW1:
    movl $1, %eax
    leave
    ret

return_0_HW1:
    movl $0, %eax
    leave
    ret
