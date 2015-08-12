	# Rafael Ferreira https://github.com/gipmon/ac1

	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	li $a0, 3
	jal eval
	mov.d $f12, $f0
	li $v0, 3
	syscall
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#
	.data 
zero:	.double 0.0
um:	.double 1.0
dois:	.double 2.0
	.text
eval:
	bnez $a0, else
	l.d $f0, um
	b endif
else:
	addiu $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	s.d $f20, 16($sp)
	#
	move $s0, $a0
	l.d $f20, zero
	li $s1, 0
for:
	bge $s1, $s0, endfor
	move $a0, $s1 
	jal eval
	add.d $f20, $f20, $f0
	addiu $s1, $s1, 1
	b for
endfor:
	mtc1 $s0, $f4
	cvt.d.w $f4, $f4
	div.d $f0, $f20, $f4
	l.d $f6, dois
	mul.d $f0, $f0, $f6
	add.d $f0, $f0, $f4
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	l.d $f20, 16($sp)
	addiu $sp, $sp, 24
endif:
	jr $ra