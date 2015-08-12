	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.include "recursive_rotines.s"
	.data
str:	.asciiz "teste de copia"
dst:	.word 15
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	la $a0, dst
	la $a1, str
	jal strcpy
	move $a0, $v0
	print_str
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4 
	jr $ra
