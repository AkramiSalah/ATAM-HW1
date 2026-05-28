.global _start

.section .text
_start:

lea .lazer(%rip), %rax
lea .borad(%rip), %r8

lea .valid(%rip), %r9
movb $0, (%r9)

movl 0(%rax), %edx #direction
movl 4(%rax), %ecx #cols
movl 8(%rax), %ebx #rows

parse_char_HW1:
cmpl $8, %ecx
jge terminate_HW1

cmpl $8, %ebx
jge terminate_HW1


# sign extend long to quad because memeory address gotta be 64 bits otherwise issues..
movslq %ebx, %rbx  
movslq %ecx, %rcx

lea (%r8, %rbx, 8), %rsi  #claculated address of first elem in the row.
addq %rcx, %rsi #pointer arithmetic..

movb (%rsi), %al

cmpl $0x2E, %al
je DOT_case_HW1

cmpl $0x23, %al
je WALL_case_HW1

cmpl $0x54, %al
je T_case_HW1

cmpl $0x5C, %al
je backslash_case_HW1

cmpl $0x2F, %al
je forwardslash_case_HW1

# the only remaining option is the revisit case anyway and it simplifies things.
jmp revisit_case_HW1





DOT_case_HW1:
incq %r9
cmpq $256, %r9 #if we visited nodes more than 256 times then its guranteed that we visited each node at each state (up,down,left,right)
jg terminate_HW1
jmp step_HW1

WALL_case_HW1:
jmp terminate_HW1

T_case_HW1:
lea .valid(%rip), %r9
movb $1, (%r9)
jmp terminate_HW1

backslash_case_HW1:
#assumiong edx is direction
# we can jsut toggle the two lowest bits
xor $0x00000003, %edx
jmp step_HW1

forwardslash_case_HW1:
#assumiong edx is direction
# we can jsut toggle the lowest bit
xor $0x00000001, %edx
jmp step_HW1


step_HW1:
cmpl $0x30, %edx
je up_HW1

cmpl $0x31, %edx
je right_HW1

cmpl $0x32, %edx
je down_HW1

cmpl $0x33, %edx
je left_HW1


up_HW1:
decl %ebx
jmp parse_char_HW1

right_HW1:
incl %ecx
jmp parse_char_HW1

down_HW1:
incl %ebx
jmp parse_char_HW1

left_HW1:
decl %ecx
jmp parse_char_HW1

terminate_HW1:
# return 0; basically..
movl $60, %eax
xorl %edi, %edi
syscall









#proof for the xors, starting with the '/' case:
# this is shown first using words, then numbers, then binary.
# you can easily see xoring one side by 01 will get you to the other side (toggle the lsb)
# this is all within the scope of sifratiot, i just made two tables and saw the pattern.
# up <-> right, 0 <-> 1, 00 <-> 01
# left <-> down, 2 <-> 3, 10 <-> 11


# for the '\' case ill just show the binary and youll have to trust me :)
# 00 <-> 11
# 01 <-> 10
#so you can easily see that xoring by 11 will transfer use form one side to the other (otggle both of the 2 lsbs)
