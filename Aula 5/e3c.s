	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
array:	.space 40	#4bytes * 10words = 40bytes  	
str1:	.asciiz "Insira um numero: "
str2:	.asciiz " : "
	.text
	.globl main
main:
	la $t0, array	#*array
	addu $t1, $t0, 40	#last_position
	#
do_1:	
	#Leitura de dados 
	#(print da str)
	la $a0, str1
	li $v0, 4
	syscall
	#Ler inteiro
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	#add 4bytes
	addiu $t0, $t0, 4
	bge $t0, $t1, do_2
	#jump
	j do_1
do_2:
	li $t1, 0 # houveTroca = 0
	li $t2, 0 # i = 0
for_1:	
	#condicao do while
	bge $t2, 9, endfor_1
	#enderecos
	sll $t3, $t2, 2 # i*4
	lw $t4, array($t3) # lista|i|
	addiu $t3, $t3, 4  #i*4+4
	lw $t5, array($t3) # lista|i+1|
	#if(lista|i|>lista|i+1|)
	bleu $t4, $t5, endif
	#
	move $t6, $t4 #aux = lista|i|
	addiu $t3, $t3, -4  #i-4
	sw $t5, array($t3) #lista|i| = lista|i+1|
	addiu $t3, $t3, 4  #i+4
	sw $t6, array($t3) #lista|i+1| = aux
	#
	li $t1, 1
endif:
	addiu $t2, $t2, 1
	j for_1
endfor_1:
	#while
	bnez $t1, do_2
#codigo de impressao do conteudo do arrray
	li $t1, 0
for_2:
	bge $t1, 10, endfor_2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $v0, 1
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	addiu $t1, $t1, 1
	j for_2
endfor_2:
	jr $ra
