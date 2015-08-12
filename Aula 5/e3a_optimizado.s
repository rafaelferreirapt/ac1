	.eqv lastIndex, 9
	.eqv SIZE, 10
	.data
#lista:	.space 40	#4bytes * 10words = 40bytes  	
lista:	.word 10, 5, 20, 7, 15, 20, 40, 50, 43, 50
	#
.macro print_str(%str)
	la $a0, %str
	li $v0, 4
	syscall
.end_macro
.macro print_int(%int)
	or $a0, $0,  %int
	li $v0, 1
	syscall
.end_macro 
	#
str1:	.asciiz "Insira um numero: "
str2:	.asciiz " : "
str3:	.asciiz " \n "
	#
	.text
	.globl main
main:
j enddo_2
	la $t0, lista	#*array
	la $t1, SIZE
	sll $t1, $t1, 2
	addu $t1, $t0, $t1	#last_position
	#
do_1:	
	#Leitura de dados 
	#(print da str)
	print_str(str1)
	#Ler inteiro
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	#add 4bytes
	addiu $t0, $t0, 4
	bge $t0, $t1, enddo_2
	#jump
	j do_1
enddo_2:
	li $t7, lastIndex
do_2:
	li $t1, 0 # houveTroca = 0
	li $t2, 0 # i = 0
for_1:	
	#condicao do while
	bge $t2, $t7, endfor_1
	#enderecos
	sll $t3, $t2, 2 # i*4
	lw $t4, lista($t3) # lista|i|
	addiu $t3, $t3, 4  #i*4+4
	lw $t5, lista($t3) # lista|i+1|
	#if(lista|i|>lista|i+1|)
	ble $t4, $t5, endif
	#
	move $t6, $t4 #aux = lista|i|
	addiu $t3, $t3, -4  #i-4
	sw $t5, lista($t3) #lista|i| = lista|i+1|
	addiu $t3, $t3, 4  #i+4
	sw $t6, lista($t3) #lista|i+1| = aux
	#
	li $t1, 1
endif:
	addiu $t2, $t2, 1
	j for_1
endfor_1:
	#while do print
	print_int($t7)
	print_str(str2)
	subiu $t7, $t7, 1 #optimizado
	bnez $t1, do_2
#codigo de impressao do conteudo do arrray
	li $t1, 0
	print_str(str3)
for_2:
	bge $t1, 10, endfor_2
	sll $t2, $t1, 2
	lw $t2, lista($t2)
	print_int($t2)
	print_str(str2)
	addiu $t1, $t1, 1
	j for_2
endfor_2:
	jr $ra
