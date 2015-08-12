	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str1: 	.asciiz "\nIntroduza um numero: "
	
	.align 2 #ve se e um multiplo de 4 se nao for anda para a frente
list:  .space 20 # 4bytes * 5words = 20 bytes 	

	.text
	.globl main
main:
	li $t0, 0 # i = 0 
for:
	bge $t0, 5, endfor
	#
	sll $t1, $t0, 2 # i*4
	#
	la $a0, str1
	li $v0, 4
	syscall
	#
	li $v0, 5
	syscall
	sw $v0, list($t1)
	#
	addi $t0, $t0, 1
	j for
endfor:
	jr $ra
