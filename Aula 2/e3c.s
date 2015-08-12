	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
qst1:	.asciiz "Introduza 2 numeros: \n"
qst2:	.asciiz "A soma dos dois numeros e: \n"

.macro print_str(%str)
	la  $a0, %str
	li $v0, 4
	syscall
.end_macro 
	
	.text
	.globl main
main: 	
	la  $a0, qst1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	or $t0, $0, $v0
	
	li $v0, 5
	syscall
	
	or $t1, $0, $v0
	
	la  $a0, qst2
	li $v0, 4
	syscall
	
	add $a0, $t0, $t1
	li $v0, 1
	syscall
	
	jr $ra
