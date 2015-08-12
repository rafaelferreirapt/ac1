	.eqv SIZE, 12
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
	la $t0, arr
	add $t1, $t0, SIZE #last position
	li $t5, 1 #i
for:	
	bge $t0, $t1, endfor
	print_str(str4)
	print_int($t5)
	print_str(str5)
	#
	li $t3, 0 # j=0 
	#
	lw $t2, 0($t0) # arr|i|
while:
	lb $t4, 0($t2) #load byte (char)
	beq $t4, '\0', endwhile
	print_char($t4)
	print_char('-')
	addi $t2, $t2, 1
	b while
endwhile:
	addiu $t0, $t0, 4
	addi $t5, $t5, 1
	b for
endfor:
	jr $ra
	
