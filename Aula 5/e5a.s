	# Rafael Ferreira https://github.com/gipmon/ac1

	.eqv SIZE, 40
	.eqv lastPos, 36
	.eqv inc, 4
	.data
str1:	.asciiz "Introduza um valor: "
str2:	.asciiz " | "
	.align 2
#lista:	.word 0:SIZE
lista:	.word 40, -4, 10, 20, 30, 4, 1, 35, 4, 10
	.text
	.globl main
main:
sequential_sort:
	li $t0, 0 # i=0
for_1:
	bge $t0, lastPos,  endfor_1
	lw $t1, lista($t0) #$t3 = lista|i|
	addiu $t2, $t0, inc # j=i+1
for_2:
	bge $t2, SIZE, endfor_2
	#
	lw $t3, lista($t2) #$t5 = lista|j|
	#if(lista|i| > lista |j|):
	ble $t1, $t3, endif
	#
	move $t4, $t1 #aux = lista|i|
	move $t1, $t3
	move $t3, $t4
	#
	sw $t1, lista($t0)
	sw $t3, lista($t2) 
endif:
	addiu $t2, $t2, inc # j++
	j for_2
endfor_2:
	addiu $t0, $t0, inc # i++
	j for_1
endfor_1:
#codigo de impressao
	la $t0, lista
	addi $t1, $t0, SIZE 
do_2:
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	addiu $t0, $t0, inc
	blt $t0, $t1, do_2
	jr $ra
