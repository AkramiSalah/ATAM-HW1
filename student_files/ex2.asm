.global _start

.section .text
_start:
    movq $0, %r11           #r11 will be the stack
    movq $0, %r12           #r12 will be the counter
    leaq exp(%rip), %r13    #r13 is the pointer for the current char

loop_HW1:
    movb (%r13), %al        #al holds the current char value

    cmpb $0, %al
    je end_of_string_HW1

string_not_empty_HW1:
    #open bracket section:
    #if the next char opens a bracket then it is legal.
    #bracket by numbers: 1 = [ , 2 = {, 3 = (
    cmpb $0x5B, %al #[
    jne check_bracket2_HW1
    shlq $2, %r11
    addq $1, %r11
    incq %r12
    jmp go_next_char_HW1

check_bracket2_HW1:
    cmpb $0x7B, %al #{
    jne check_bracket3_HW1
    shlq $2, %r11
    addq $2, %r11
    incq %r12
    jmp go_next_char_HW1

check_bracket3_HW1:
    cmpb $0x28, %al #(
    jne check_closing_bracket_HW1
    shlq $2, %r11
    addq $3, %r11
    incq %r12
    jmp go_next_char_HW1

check_closing_bracket_HW1:
    #if the stack is empty, we are not searching for a closing bracket and so fail.
    cmpq $0, %r12
    je return_0_HW1

    #get bracket being searched.
    movq %r11, %r14
    andq $3, %r14       #3 is the mask for the lsb 2 bits i.e. the code of the bracket we are searching for.
    
    #dl will hold the value of the closing bracket being searched

    cmpq $1, %r14
    jne compare_2_closing_HW1
    movb $0x5D, %dl
    jmp check_closing_bracket_match_HW1

compare_2_closing_HW1:
    cmpq $2, %r14
    jne compare_3_closing_HW1
    movb $0x7D, %dl
    jmp check_closing_bracket_match_HW1

compare_3_closing_HW1:
    cmpq $3, %r14
    jne return_0_HW1        #if the char isnt a type 3 bracket then it is an invalid char, fail
    movb $0x29, %dl

check_closing_bracket_match_HW1:
    cmpb %dl, %al
    jne return_0_HW1    #if current char isn't the closing bracket being searched

    #the closing bracket matches, remove it from the stack and counter.
    shrq $2, %r11
    subq $1, %r12

go_next_char_HW1:
    incq %r13
    jmp loop_HW1

end_of_string_HW1:
    # If the counter isnt set to 0, we are still searching for a closing bracket and so fail.
    cmpq $0, %r12
    je return_1_HW1
    jmp return_0_HW1

return_1_HW1:
    movl $1, valid
    ret

return_0_HW1:
    movl $0, valid
    ret
