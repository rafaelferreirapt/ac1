	.include "macros.s"
	.include "recursive_rotines.s"
	.include "hanoi.s" #needs recursive_rotines.s
	.data
init:	.asciiz "\nIntroduza o numero de discos: "
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	la $a0, init
	read_int
	blez $v0, endif
	move $a0, $v0
	li $a1, 1
	li $a2, 3
	li $a3, 2
	jal tohanoi
endif:
	li $v0, 0
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#-----------------	
	jr $ra
