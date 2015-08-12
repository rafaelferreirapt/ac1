	.include "rotinas.s"
	.include "macros.s"
	.data
	.text
	.globl main
main:
	#store $ra because it may change in a
	#call procedure in the next code
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	
	# see rotinas.s
	
	#restore $ra
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra