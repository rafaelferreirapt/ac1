	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.include "rotinas.s"
	.data
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	li $a0, 6 # base
	li $a1, 6 # number
	jal print_int_ac # 10
	#
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	#
	jr $ra
#---------------------------#
print_int_ac:
	#---------#
	.data
buf:	.space 33
	.text
	#---------#
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a3, buf
	#
	jal itoa
	#
	move $a0, $v0
	print_str
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra
#---------------------------#