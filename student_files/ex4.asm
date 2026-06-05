.global _start

.section .text
_start:

lea lazer(%rip), %rax
lea board(%rip), %r8

lea valid(%rip), %r9
movb $0, (%r9)


movl 0(%rax), %ebx #rows
movl 4(%rax), %ecx #cols
movl 8(%rax), %edx #direction


# sign extend long to quad because memeory address gotta be 64 bits otherwise issues..
movslq %ebx, %rbx
movslq %ecx, %rcx

# store original coords in these regs for the bonus section.
movq %rbx, %r10
movq %rcx, %r11 
movl %edx, %r12d

parse_char_HW1:

#gotta use jae instead of jge becuase jae works as unsigned, and we might go left of the left wall for example.
cmpq $8, %rcx
jae terminate_HW1

cmpq $8, %rbx
jae terminate_HW1


lea (%r8, %rbx, 8), %rsi  #claculated address of first elem in the row.
addq %rcx, %rsi #pointer arithmetic..

movb (%rsi), %al

cmpb $0x2E, %al
je DOT_case_HW1

cmpb $0x23, %al
je WALL_case_HW1

cmpb $0x54, %al
je T_case_HW1

cmpb $0x5C, %al
je backslash_case_HW1

cmpb $0x2F, %al
je forwardslash_case_HW1

jmp terminate_HW1 #its here incase we reach an unexpected/unhandeleed char.

DOT_case_HW1:
jmp step_HW1

WALL_case_HW1:
jmp terminate_HW1

T_case_HW1:
lea valid(%rip), %r9
movb $1, (%r9)
jmp terminate_HW1

backslash_case_HW1:
#assumiong rdx is direction
# we can jsut toggle the two lowest bits
xor $0x03, %dl
jmp step_HW1

forwardslash_case_HW1:
#assumiong rdx is direction
# we can jsut toggle the lowest bit
xor $0x01, %dl
jmp step_HW1


step_HW1:
cmpq $0, %rdx
je up_HW1

cmpq $1, %rdx
je right_HW1

cmpq $2, %rdx
je down_HW1

cmpq $3, %rdx
je left_HW1


up_HW1:
decq %rbx
jmp check_inf_cycle_HW1

right_HW1:
incq %rcx
jmp check_inf_cycle_HW1

down_HW1:
incq %rbx
jmp check_inf_cycle_HW1

left_HW1:
decq %rcx


check_inf_cycle_HW1:
cmpq %rbx, %r10
jne parse_char_HW1
cmpq %rcx, %r11 
jne parse_char_HW1
cmpl %edx, %r12d
jne parse_char_HW1
#itll reach the termination label if none of those cmprs made a jmp happen...


terminate_HW1:
# uhh... no idea what should be here tbh... putting ret makes me fail tests..


# explaination for the xors, starting with the '/' case:
# this is shown first using words, then numbers, then binary.
# you can easily see xoring one side by 01 will get you to the other side (toggle the lsb)
# this is all within the scope of sifratiot, i just made two tables and saw the pattern.
# up <-> right, 0 <-> 1, 00 <-> 01
# left <-> down, 2 <-> 3, 10 <-> 11


# for the '\' case ill just show the binary and youll have to trust me :)
# 00 <-> 11
# 01 <-> 10
# so you can easily see that xoring by 11 will transfer use form one side to the other (otggle both of the 2 lsbs)





