.global _start

.section .text
_start:

# Add your code here!

# rax will be used as the counter, rsi will be used as the index
xor %rax, %rax
xor %rsi, %rsi

# CL, the lower nibble in rcx will hold the current char, using CL cuz its exactly a byte :)
parse_char_HW1:
movb .str(%rip, %rsi, 1), %CL

cmp  $0x00, %CL
je termination_squence_HW1

cmp $0x61, %CL
jl inc_index_HW1

cmp $0x7A, %CL
jg inc_index_HW1

inc %rax

inc_index_HW1:
inc %rsi
jmp parse_char_HW1

termination_squence_HW1:
movq %rax, .cout(%rip)
