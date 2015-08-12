	.data
	
str: 	.space 20 
	
	.text
	
	
	.globl main
	
main:	li $v0, 8
	la $a0, str
	li $a1, 20
	syscall #read string
	
	li $t0, 0 #num =0
	li $t1, 0 #i=0
	
	la $t2, str
	
while:	lb $t3, 0($t2)	
	beq $t3, 0, endw #condicao do while
	
	blt $t3, '0', inc
	bgt $t3, '9', inc
	add $t0, $t0, 1 # num++
	
inc:	# addiu $t1, $t1, 1	# i++
	addiu $t2, $t2, 1
	j while
	
endw:	li $v0, 1
	move $a0, $t0
	syscall #print num
	jr $ra