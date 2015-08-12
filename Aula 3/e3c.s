	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str1:	.asciiz "Introduza dois numeros: "
str2:	.asciiz "Resultado: "
	.text
	.globl main
	#65535
main:
	#
	li $v0, 4
	la $a0, str1
	syscall
	#
	li $v0, 5
	syscall
	or $t0, $0, $v0 # mdor
	#
	li $v0, 5
	syscall
	or $t1, $0, $v0 # mdo
	#
	li $t2, 0 # res
	li $t3, 0 # i
while:
	#condicoes do while
	sne $t4, $t0, 0
	slti $t5, $t3, 16 #i++ < 16
	and $t5, $t5, $t4
	#increment do i
	add $t3, $t3, 1
	#if do while
	beqz $t5, endwhile
	#se for 1 keep while
	#condicoes do if dentro do while
	andi $t5, $t0, 0x00000001
	beqz $t5, jump
	addu $t2, $t2, $t1 #como acrescenta um sinal temos de sumar sem sinal
jump:	
	sll $t1, $t1, 1
	sra $t0, $t0, 1
	j while
endwhile:
	li $v0, 4
	la $a0, str2
	syscall
	#
	li $v0, 36 #print unsigned
	or $a0, $0, $t2
	syscall
	jr $ra
