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
	la $t0, str #$t0 de p (str)
while:
	lb $t1, 0($t0) #load do byte com offset 0 do $t0 (p*)
	#while(p* != '\0'):
	beq $t1, '\0', endwhile
	#if($t1>='a' && $t1<='z'):
	blt $t1, 'a', endif
	bgt $t1, 'z', endif
	# $t1 = $t1 - 'a' + 'A'
	subi $t1, $t1, 'a'
	addi $t1, $t1, 'A'
	# store byte com offset 0 em $t1
	sb $t1, 0($t0)
endif:	
	# p = p++
	addiu $t0, $t0, 1
	j while
endwhile:
	li $v0, 4
	la $a0, str
	#or $a0, $0, $t0
	syscall
	jr $ra