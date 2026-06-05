.global _start

.section .text
_start:

# Add your code here!

# rax will be used as the counter, rsi will be used as the char *ptr
xor %rax, %rax
leaq .str(%rip), %rsi

# CL, the lower byte in rcx will hold the current char being pointed to
parse_char_HW1:
movb (%rsi), %CL

#please note 0x00 in ascii is the NULL terminator
cmp  $0x00, %CL
je termination_squence_HW1

#please note 0x61 in ascii is 'a'
cmp $0x61, %CL
jl inc_ptr_HW1

#please note 0x61 in ascii is 'z'
cmp $0x7A, %CL
jg inc_ptr_HW1

#counter++
inc %rax

inc_ptr_HW1:
inc %rsi
jmp parse_char_HW1

termination_squence_HW1:
movq %rax, .cout(%rip)
ret
