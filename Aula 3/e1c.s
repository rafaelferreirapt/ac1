	.data
str1:	.asciiz "Introduza um n?mero: "
str2:	.asciiz "\nO valor em bin?rio: "
	.text
	.globl main	
main:	
	#print da str1
	la $a0, str1
	li $v0, 4
	syscall
	#vai ler um inteiro
	li $v0, 5
	syscall
	#grava o numero para $t0
	or $t0, $0, $v0 
	#print da str2
	la $a0, str2
	li $v0, 4
	syscall 
	#o $t1 vai ser usado para incrementar no for
	li $t1, 0 
	#no $t3 vou fazer a contagem dos bits
	li $t3, 0 
	#depois desta linha vai passar para o for
	#
	# O mais importante a reter neste tipo de aproximacao e usar
	# o OR bitwise entre o numero que a mascara retorna fazendo um 
	# shit logical right de 31 unidades para o bit LSB (less significant bit)
	# pois o valor retornado na mascara encontra-se no MSB 0x80...
	# fazendo o OR bitwise entre 0x30 e 0 da 0x30, 0x30(16) em (2) e 00110000
	# or bit a bit d? 00110000 ou seja 0x30;
	# se for 1 o bit encontrado e fizermos or bit a bit temos 00110000 (2) or com
	# 1 em (16) 0001(2) isto da 00110001 que em base (16) e 0x31 ou seja '1' em
	# codigo ASCII, apos isso so fazer o print 
	#
for:
	#se for maior ou igual a 32 passa para o endfor
	bge $t1, 32, endfor
	#instru??o dentro do for
	andi $t2, $t0, 0x80000000
	#como em ambos casos do if vamos fazer print de um char decidi
	#meter em evid?ncia esta linha
 	li $v0, 11
 	#vou fazer o shit right logical de 31 unidades
 	srl $t2, $t2, 31
 	ori $a0, $t2, 0x30
	#se for igual a 3 vai imprimir o espaco
	#se nao vai incrementar uma unidade
	beq $t3, 3, espaco
	addi $t3, $t3, 1
print:
	#print do caracter
	syscall
	#faz o shit left l?gico de 1 unidade do $t0
	sll $t0, $t0, 1
	#adiciona 1 a $t1 que ? a variavel usada para incrementa??o do for
	addi $t1, $t1, 1	
	#jump para o for
	j for
espaco:
	syscall
	ori $a0, $0, ' '
	li $t3, 0
	j print	
endfor: 
	#label para acabar o for
	jr $ra
