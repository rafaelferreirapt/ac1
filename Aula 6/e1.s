	.eqv SIZE, 3
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "Ponteiros"
	.align 2
list:	.word str1, str2, str3
	.text
	.globl main
main:
	la $t0, list #ponteiro do array list para $t2
	li $t1, 0 #i=0
for:
	bge $t1, SIZE, endfor
	sll $t2, $t1, 2 # 4*i bytes
	#
	li $v0, 4
	lw $a0, list($t2)
	syscall
	#
	li $v0, 11
	or $a0, $0, '\n'
	syscall
	#
	addi $t1, $t1, 1
	b for
endfor:
	jr $ra
