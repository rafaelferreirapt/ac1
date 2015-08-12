	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
nelem:	.eqv SIZE, 3
array:	.double 22.2, 44.2, 22.2 
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, array
	li $a1, SIZE
	jal total
	#
	mov.s $f12, $f0
	li $v0, 2
	syscall
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#	#
	.data
zeros:	.float 0.0
zerod:	.double 0.0
	.text
total:
	li $t0, 1
	l.s $f4, zeros
	move $t1, $a0
	sll $a1, $a1, 3
	add $t2, $a0, $a1
for:
	bge $t1, $t2, endfor
	l.d $f6, 0($t1)
	l.d $f8, zerod
	c.le.d $f6, $f8
	bc1f doit
	rem $t3, $t0, 2
	beqz $t3, endif
	#
doit:
	cvt.s.d $f6, $f6
	mtc1 $t0, $f10
	cvt.s.w $f10, $f10
	mul.s $f10, $f6, $f10
	add.s $f4, $f4, $f10
endif:
	addiu $t0, $t0, 1
	addiu $t1, $t1, 8
	b for
endfor:
	mov.s $f0, $f4
	jr $ra