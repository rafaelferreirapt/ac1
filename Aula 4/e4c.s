	.eqv SIZE, 16 #4*4
	.data
#declarar o array
arr: 	.word 7692, 23, 5, 324 #4 numeros * 3 bytes
	     #+0   ,+4 ,+8,+12
	.text
	.globl main
main:
	li $t0, 0 # i = 0 
	li $t3, 0 # sum = 0
while:
	#condicao de paragem do while
	bge $t0, SIZE, endwhile #bgt 
	#obter a palavra para depois fazer a soma
	sll $t2, $t0, 2
	lw  $t2, arr($t2)
	# soma = soma + (*p)
	add $t3, $t3, $t2
	#p++
	addiu $t0, $t0, 1
	#
	j while
endwhile:
	li $v0, 1
	#move, move o registo $t2 para o $a0
	move $a0, $t3
	syscall
	#
	jr $ra
