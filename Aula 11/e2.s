	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "rotines.s"
	.include "macros.s"
	.data
x:	.double 25.4
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#----------------
	l.d $f12, x
	jal sqrt
	mov.d $f12, $f0
	print_double
	#----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
