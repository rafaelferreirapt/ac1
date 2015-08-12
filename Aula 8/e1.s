	.include "macros.s"
	.include "rotinas.s"
	.data
str:	.asciiz "2040, o ano do fim das PPP"
	.text
	.globl main
main:
	#preserve $ra
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, str
	jal atoi
	move $a0, $v0
	print_int10
	#
	li $v0, 0
	#restore $ra
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra