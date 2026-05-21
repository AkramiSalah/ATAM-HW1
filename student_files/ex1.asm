.global _start

.section .text
_start:

# Add your code here!

# rsi will be used as the index register
mov $0, %rsi

# rci will hold the current char, using CL cuz its exactly a byte :)
mov .str, %CL

cmp $0x61, %CL
jle .is_ge_than_a


parse_char_HW1:
# put char in the char register

logic_dispatcher_HW1:
# if greater or equal to a:
# 	if less or equal to z:
# 		jmp to inc_counter_HW1
#	jmp to parse_char_HW1
# 	
# 	if 

if greater or equal to a:
	jmp to less or equal to z block
else 
	jmp to is null terminator block
	

ge_to_a_handler:
# is less 


inc_counter_HW1:
# add 1 to the counter register

termination_squence_HW1:
# put counter into the .count label


#################################
# rax will be used as the counter, rsi will be used as the index
xor %rax, %rax
xor %rsi, %rsi

# CL, the lower nibble in rcx will hold the current char, using CL cuz its exactly a byte :)
parse_char_HW1:
movb .str(%rip, %rsi, 1), %CL

cmp %CL, $0x00
je termination_squence_HW1

cmp %CL, $0x61
jg inc_index_HW1

cmp %CL, $0x7A
jl inc_index_HW1

add $1, %rax

inc_index_HW1:
add $1, %rsi
jmp parse_char_HW1

termination_squence_HW1:
movq %rax, .cout(%rip)









