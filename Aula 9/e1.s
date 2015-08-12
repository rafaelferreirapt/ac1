	.include "macros.s"
	.include "recursive_rotines.s"
	#
	.data
str:	.asciiz	"teste eheheheh" #14 char's
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, str
	jal strlen
	move $a0, $v0
	print_int10
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra
