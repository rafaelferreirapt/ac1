	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
string: .asciiz "String de teste"
.macro print_int
	li $v0, 1
	syscall
.end_macro 
.macro print_str
	li $v0, 4
	syscall
.end_macro 
	.text 
	.globl main
main:	
	#stack
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, string
	print_str
	la $a0, string # a0
	jal strlen # jump to rotine
	#
	move $a0, $v0 
	print_int
	#restore $ra
	lw $ra, 0($sp)	  #restore $ra
	addiu $sp, $sp, 4 #store stack pointer
	#restore $ra
	li $v0, 0
	jr $ra
strlen:
	li $v0, 0
loop:	
	lb $t0, 0($a0)
	beqz $t0, exit
	addi $v0, $v0, 1
	addiu $a0, $a0, 1
	j loop
exit:
	jr $ra 
