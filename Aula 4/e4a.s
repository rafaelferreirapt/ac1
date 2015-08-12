	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
#declarar o array
arr: 	.word 7692, 23, 5, 324 #4 numeros * 3 bytes
	     #+0   ,+4 ,+8,+12
	.text
	.globl main
main:
	#vamos atribuir aos ponteiros declarados em cima
	#a posicao inicial (ponteiro) e a posicao final
	la $t0, arr
	la $t1, arr+16 # 4bytes por palavra de int's, 4 palavras = 4*4 = 16 bytes => aponta
	#para o final da ?ltima palavra 
	#int soma = 0;
	li $t2, 0 
while:
	#condicao de paragem do while
	bge $t0, $t1, endwhile #bgt 
	#obter a palavra para depois fazer a soma
	lw  $t3, 0($t0)
	# soma = soma + (*p)
	add $t2, $t2, $t3
	#p++
	addiu $t0, $t0, 4 #1 word = 4 bytes, tem de andar 4 posicoes. 4*8=32bits
	#
	j while
endwhile:
	li $v0, 1
	#move, move o registo $t2 para o $a0
	move $a0, $t2
	syscall
	#
	jr $ra
