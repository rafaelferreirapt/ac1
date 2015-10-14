# exercício com índices	
	
	.data
str:	.space 20
 
 	.text
 	.globl main
 	
main: 
	la $a0, str #onde a str vai ser armazenada
	li $v0, 8 #opção read_string
	ori $a1, $0, 20 #tamanho da str
	syscall
	
	# num = 0
	li $t0, 0
	# i = 0
	li $t1, 0

while:
	lb $t3, str($t1)
	#  str[i] == '\n'
	beq $t3, '\n', endwhile
	
	# num++
	addi $t0, $t0, 1
	bltu $t3, '0', endif
	bgtu $t3, '9', endif

endif:
	addi $t1, $t1, 1
	j while
	
endwhile:
	li $v0, 1
	or $a0, $0, $t0
	syscall
	jr $ra
