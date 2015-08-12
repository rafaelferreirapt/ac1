	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.include "recursive_rotines.s"
	.data
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	li $a0, 3
	li $a1, 2
	jal print_int_ac1
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#-----------------	
	jr $ra
