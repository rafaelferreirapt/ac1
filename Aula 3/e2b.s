	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str1: 	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em octal: "
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
	li $t1, 10 # i = 10 , 32/3=10,66
	li $v0, 11
	#como 32/3 = 10,66 temos de andar dois a dois bits para n?o desprezar informacao
	#em primeiro lugar.
if: 
	andi $t2, $t0, 0xC0000000 # c = 1100
	beqz $t2, endif #se os primeiros dois digitos forem igual a zero passa para o endif
	#se esses dois bits tiverem valor vamos imprimi-los
	#mas antes temos de shiftar para a esquerda 30 posicoes, 32 bits, 2 mais significativos para os 2 MLB
	sra $t2, $t2, 30
	addi $a0, $t2, '0'
	li $v0, 11
	syscall
	#como ja encontramos os bits que continham informacao vamos passar para o do
	j dowhile
endif:
	#aqui vamos shiftar esses dois bits que nao continham informacao
	#para a esquerda
	sll $t0, $t0, 2
while:
	#condicoes do while
	#E = 1110 consideramos apenas os primeiros 3 bits 
	andi $t2, $t0, 0xE0000000
	seq $t3, $t2, 0
	sgt $t4, $t1, 0
	and $t3, $t3, $t4
	#if do while
	#quando encontrados os primeiros 3 bits com informacao concluimos o while
	beqz $t3, dowhile #dowhile = endwhile
	#keep while
	sll $t0, $t0, 3
	sub $t1, $t1, 1
	j while
dowhile:	
	#declaration of digit
	andi $t5, $t0, 0xE0000000
	sra $t5, $t5, 29 #shiftamos 29 posicoes, 29+3=32 bits
	#print 0 - 9
	li $v0, 11
	add $a0, $t5, '0'
	syscall
	#
	sll $t0, $t0, 3
	sub $t1, $t1, 1
	bgtz $t1, dowhile
	#end
	jr $ra
