	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
str1: 	.asciiz "Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
.macro print_str(%str)
	la $a0, %str
	li $v0, 4
	syscall
.end_macro
.macro print_str_simple
#we can make a move of the register , of the content
#and print them, move $a0, %str but we can pass them 
#in the args
	li $v0, 4
	syscall
.end_macro
.macro print_int(%int)
	or $a0, $0, %int
	li $v0, 1
	syscall
.end_macro
	.text
	.globl main
main:
	move $t0, $a0 # argc-count .length
	li $t1, 0 # i
	print_str(str1)
	print_int($t0)
for:
	bge $t1, $t0, endfor
	print_str(str2)
	print_int($t1)
	print_str(str3)
	#argv|i|
	sll $t2, $t1, 2
	addu $t3, $a1, $t2
	#
	lw $a0, 0($t3)
	print_str_simple
	#
	addiu $t1, $t1, 1
	j for
endfor:
	li $v0, 0
	jr $ra