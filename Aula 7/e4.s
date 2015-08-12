	.include "rotinas.s"
	.include "macros.s"
	.data
str:	.asciiz "Computadores"
str1:	.asciiz "Arquitectura de "
str2:	.word 50
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, str2
	la $a1, str1
	jal strcpy
	#
	la $a0, str2
	la $a1, str
	jal strcat
	#
	move $a0, $v0 
	print_str
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra