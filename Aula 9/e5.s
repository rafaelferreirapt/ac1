	.include "macros.s"
	.include "recursive_rotines.s"
	.data
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	li $a0, 12 
	jal unsigned_fact
	move $a0, $v0
	print_int10 #479001600
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#-----------------	
	jr $ra
