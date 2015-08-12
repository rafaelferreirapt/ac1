	.include "macros.s"
	.include "recursive_rotines.s"
	.data
int_arr:.word 12, 33, 25, -10
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	# ------------------
	la $a0, int_arr
	li $a1, 4
	jal soma
	move $a0, $v0
	print_int10
	# ------------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	# ------------------
	jr $ra