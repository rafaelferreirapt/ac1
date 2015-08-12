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
 	#faz o shit left logico de 1 unidade do $t0
	sll $t0, $t0, 1
	#se o $t4 for igual a 1 passa para o print
 	beq $t4, 1, print
	#se $t2 for igual a 1 $t4 vai ser 1
	seq $t4, $t2, 1
 	#se $t4 = 1 > print | $t4 = 0 > notprint
 	beq $t4, 1, print
	beq $t4, 0, notprint
print:
 	ori $a0, $t2, 0x30
	#print do caracter
	syscall
	#adiciona para a contagem de 3 unidades (4)
	addi $t3, $t3, 1
	#adiciona 1 a $t1 que e a variavel usada para incrementacao do for
	addi $t1, $t1, 1	
	#se for igual a 4 (4? q vem depois, e imprimido apos) vai imprimir espaco
	beq $t3, 4, espaco 
	#jump para o for
	j for
espaco:
	ori $a0, $0, ' '
	syscall
	li $t3, 0
	j for	
notprint:
	#adiciona 1 a $t1 que e a variavel usada para incrementacao do for
	addi $t1, $t1, 1	
	j for
endfor: 
	#label para acabar o for
	jr $ra
