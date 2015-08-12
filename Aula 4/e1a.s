	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str: 	.space 20
	.eqv SIZE, 4
	.text
	.globl main
main:
	la $a0, str #onde vai colocar a string > buffer
	li $a1, 20  #a string lida vai ter tamanho 20 
	li $v0, 8
	syscall
	#
	li $t0, 0 #num = 0
	li $t1, 0 #i = 0
	#
	#la $t2, str #colocar em $t2 a str
while:
	#addu $t4, $t2, $t1
	#$t4 = $t2 + $t1 ;
	#faz o load byte para $t3 do $t4 no offset 0 
	#lb $t3, 0($t4) 
	#faz o load byte para $t3 diretamente da str com offset $t1
	lb $t3, str($t1)
	#condicao do while
	beq $t3, '\0', endwhile
	#se estiver entre 0 e 9: num++
	blt $t3, '0', endif
	bgt $t3, '9', endif
	addi $t0, $t0, 1
endif:
	addiu $t1, $t1, 1 # i++
	j while
endwhile:
	li $v0, 1
	or $a0, $0, $t0
	syscall
	jr $ra