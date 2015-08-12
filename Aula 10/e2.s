	.include "macros.s"
	.include "routines.s"
	.data
str1:	.asciiz "Fahrenheit: "
str2:	.asciiz "Celsius: "
	.text
	.globl main
main:	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, str1
	print_str
	#
	read_double #returns in $f0
	mov.d $f12, $f0 #arguments registers: $f12 .. $f15
	#
	jal f2c #return in $f0
	#
	la $a0, str2
	print_str
	#
	mov.d $f12, $f0
	print_double
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
