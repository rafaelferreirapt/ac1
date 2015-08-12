	.data
lista: 	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
str1:	.asciiz "\nConteudo do array:\n"
str2:	.asciiz " | "
	.text
	.globl main
main:
	la $t0, lista #*p
	addu $t1, $t0, 40 #10*4 = 40 bytes
	#
	la $a0, str1
	li $v0, 4
	syscall
	#
for:	
	bge $t0, $t1, endfor
	#
	lw $t2, 0($t0)
	#
	or $a0, $0, $t2
	li $v0, 1
	syscall 
	#
	la $a0, str2
	li $v0, 4
	syscall
	#
	addu $t0, $t0, 4
	j for
endfor:	
	jr $ra
