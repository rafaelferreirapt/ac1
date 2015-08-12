	.include "rotinas.s"
	.include "macros.s"
	.eqv STR_MAX_SIZE 10
	.data

buf:	.word 11 # static char buf[STR_MAX_SIZE + 1];
alert:	.asciiz "String too long. Nothing done!\n"
	
	.text
	.globl main
main:
	#store $ra because it may change in a
	#call procedure in the next code
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
if_1:
	bne $a0, 1, endif_1
	lw $s0, 0($a1)
	move $a0, $s0
	jal strlen	
if_2:
	bgt $v0, STR_MAX_SIZE, else
	move $a1, $s0
	la $a0, buf
	jal strcpy
	move $a0, $v0
	print_str
	j endif_1
else:
	la $a0, alert
	print_str
	li $v0, 1
	j jr_ra
endif_1:
	li $v0, 0
jr_ra:
	#restore $ra
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra
