	.include "macros.s"
	.include "rotinas.s"	
	.data
	
str: 	.asciiz "String a ser invertido"
str_r:	.asciiz "odditrevi res a gnirts"

	.text 
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	
	la $a0, str_r
	jal strrev
	#
	move $a0, $v0
	print_str
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	li $v0, 0
	jr $ra
