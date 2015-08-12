	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str: 	.space 20
	.text
	.globl main
main:
	la $a0, str #onde vai colocar a string > buffer
	li $a1, 20  #a string lida vai ter tamanho 20 
	li $v0, 8
	syscall
	#
	la $t0, str #colocar em $t0 a str
while:
	lb $t1, 0($t0)
	#condicao do while
	beq $t1, '\0', endwhile
	#if($t1>='A' && $t1<='Z'):
	blt $t1, 'A', endif
	bgt $t1, 'Z', endif
	#
	subi $t1, $t1, 'A'
	addi $t1, $t1, 'a'
	sb $t1, 0($t0)
endif:	
	#p++
	addiu $t0, $t0, 1
	j while
endwhile:
	li $v0, 4
	la $a0, str
	#or $a0, $0, $t0
	syscall
	jr $ra
