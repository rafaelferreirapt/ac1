	# Rafael Ferreira https://github.com/gipmon/ac1

	.eqv SIZE, 3
	.data
#declaration
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz	"\nString #"
str5:	.asciiz ": "
	.align 2
arr:	.word str1, str2, str3
#macros
.macro print_str(%str)
	la $a0, %str
	li $v0, 4
	syscall
.end_macro
.macro print_int(%int)
	or $a0, $0, %int
	li $v0, 1
	syscall
.end_macro
.macro print_char(%char)
	or $a0, $0, %char
	li $v0, 11
	syscall
.end_macro
	.text
	.globl main
main:
	#la $t0, arr
	li $t1, 0	# i=0
for:	
	bge $t1, SIZE, endfor
	print_str(str4)
	print_int($t1)
	print_str(str5)
	#
	sll $t2, $t1, 2 # i*4
	lw $t2, arr($t2) # arr|i|
	#
	li $t3, 0 # j=0 
	#
while:
	add $t4, $t2, $t3
	lb $t4, 0($t4) #load byte (char)
	beq $t4, '\0', endwhile
	print_char($t4)
	print_char('-')
	addi $t3, $t3, 1
	b while
endwhile:
	addi $t1, $t1, 1
	b for
endfor:
	jr $ra
	
