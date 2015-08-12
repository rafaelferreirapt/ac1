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
	#depois desta linha vai passar para o for
for:
	#se for maior ou igual a 32 passa para o endfor
	bge $t1, 32, endfor
	#instru??o dentro do for
	andi $t2, $t0, 0x80000000
	#como em ambos casos do if vamos fazer print de um char decidi
	#meter em evid?ncia esta linha
 	li $v0, 11
 	#se n?o for igual a zero passa para o else 
 	bnez $t2, else
 	#coloca em $a0 o char '0'
 	ori $a0, $0, '0'
endif:
	#c?digo executado ap?s o endif
	syscall
	#faz o shit left l?gico de 1 unidade do $t0
	sll $t0, $t0, 1
	#adiciona 1 a $t1 que ? a variavel usada para incrementa??o do for
	addi $t1, $t1, 1	
	#jump para o for
	j for
else:
	#coloca em $a0 o char '1'
	ori $a0, $0, '1'
	#jump para label endif
	j endif	
endfor: 
	#label para acabar o for
	jr $ra