	.include "macros.s"
	.include "rotinas.s"	
	.data
	
str: 	.asciiz "\n"

	.text 
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	# store arg0 e arg1 because may be changed in 
	# procedura strrev
	move $s0, $a0
	move $s1, $a1
	#
	li $s2, 0
do:	
	bge $s2, $s0, enddo
	sll $t1, $s2, 2
	addu $t1, $s1, $t1
	#
	lw $a0, 0($t1)
	jal strrev
	#
	move $a0, $v0
	print_str
	#
	la $a0, str
	print_str
	#
	addiu $s2, $s2, 1
	j do
enddo:
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	li $v0, 0
	jr $ra
