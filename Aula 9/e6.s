	.include "macros.s"
	.include "recursive_rotines.s"
	.data
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	li $a0, 5
	li $a1, 8
	jal xtoy
	move $a0, $v0
	print_int10 #390625
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#-----------------	
	jr $ra
