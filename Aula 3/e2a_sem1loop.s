	.data
str1: 	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em hexadecimal: "
	.text
	.globl main

main:
	li $v0, 4
	la $a0, str1
	syscall
	#
	li $v0, 5
	syscall
	# $t0 > value
	or $t0, $0, $v0
	#
	li $v0, 4
	la $a0, str2
	syscall
	#
	li $t1, 8
	li $v0, 11
dowhile:	
	#declaration of digit
	andi $t5, $t0, 0xF0000000
	sra $t5, $t5, 28
	#if
	bgt $t5, 9, else
	#keep if
	li $v0, 11
	add $a0, $t5, '0'
	syscall
	j endif
else:	
	add $t5, $t5, '0'
	add $a0, $t5, 7
	syscall
endif:
	sll $t0, $t0, 4
	sub $t1, $t1, 1
	bgtz $t1, dowhile
	#end
	jr $ra
