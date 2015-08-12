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
	li $t0, 0 # num = 0
	#
	la $t1, str # $t1 = p = str, valor do str
while:
	lb $t2, 0($t1) # byte com offset 0 do $t1 (*p)
	#while(*p != '\0'): 
	beq $t2, '\0', endwhile
	#if(p* >= '0' && p* <= '9'): 
	bltu $t2, '0', endif
	bgtu $t2, '9', endif
	addi $t0, $t0, 1
endif:
	addiu $t1, $t1, 1 # p = 1++
	j while
endwhile:
	li $v0, 1
	or $a0, $0, $t0 # num de digitos
	syscall
	jr $ra