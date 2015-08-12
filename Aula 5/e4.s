	# Rafael Ferreira https://github.com/gipmon/ac1

	.eqv byteSIZE, 40
	.data
	#
	.align 2
list:	.space byteSIZE #.word 0:SIZE 
	#
str1:	.asciiz "Insira um numero: "
str2:	.asciiz " : "
	#
	.text
	.globl main
main:
	la $t0, list #*p
	addiu $t1, $t0, byteSIZE #*pUltimo
for_1:
	bge $t0, $t1, endfor_1
	la $a0, str1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	addiu $t0, $t0, 4
	b for_1
endfor_1:
	la $t0, list
	addiu $t1, $t0, 36#*pUltimo
do_1:
	la $t0, list #*p
	li $t2, 0 # houveTroca
for_2:
	bge $t0, $t1, endfor_2
	#words
	lw $t3, 0($t0) #word *p
	lw $t4, 4($t0) #word *p+1
	#if
	ble $t3, $t4, endif
	#
	move $t5, $t3 #aux = *p
	sw $t4, 0($t0)
	sw $t5, 4($t0)
	#
	li $t2, 1
endif:
	addiu $t0, $t0, 4
	b for_2
endfor_2:
	bnez $t2, do_1
#codigo de impressao
	la $t0, list
	addi $t1, $t0, 40 
do_2:
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	addiu $t0, $t0, 4
	blt $t0, $t1, do_2
	jr $ra