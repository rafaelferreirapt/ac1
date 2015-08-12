	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str1: 	.asciiz "\nIntroduza um numero: "
	
	.align 2 #ve se e um multiplo de 4 se nao for anda para a frente
list:  .space 20 # 4bytes * 5words = 20 bytes 	

	.text
	.globl main
main:
	li $t0, 0 # i = 0 
	la $t1, list # endereco inicial do array
for:
	#condicao do for
	bge $t0, 5, endfor
	#
	sll $t2, $t0, 2 # i*4
	addu $t2, $t1, $t2 #*lista|i| (ponteiro)
	lw  $t3, 0($t2) #load word to $t2
	#
	la $a0, str1
	li $v0, 4
	syscall
	#
	li $v0, 5
	syscall
	sw $v0, 0($t2)
	#
	addi $t0, $t0, 1
	j for
endfor:
	jr $ra
