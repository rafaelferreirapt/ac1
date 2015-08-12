	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.include "rotinas.s"
	.data
str1:	.asciiz "\nNumero de argumentos errado"
str2:	.asciiz "\nOperacao desconhecida"
	.text
	.globl main
main:
	# $t0 = 1? number
	# $t1 = 2? number
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	# first word (number)
	lw $a0, 0($a1)
	jal atoi
	move $t0, $v0
	#----teste-----
	#move $a0, $t0
	#print_int10
	#----teste-----
	lw $a0, 4($a1)
	jal atoi
	move $t1, $v0
	#----teste-----
	#move $a0, $t1
	#print_int10
	#----teste-----
	#lw $ra, 0($sp)
	#addiu $sp, $sp, 4
	#jr $ra
	#----teste-----
	move $a0, $t0
	move $a1, $t1
	jal unsigned_div
	move $t2, $v0
	andi $a0, $t2, 0xFFFF
	print_int10
	li $a0, ';'
	print_char
	srl $a0, $t2,  16
	print_int10
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra