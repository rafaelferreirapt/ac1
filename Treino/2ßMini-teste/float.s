	.data
teste:	.double 3.4
	.text
	.globl main
main:
	mtc1 $zero, $f12
	cvt.d.s $f12, $f12
	li $v0, 3
	syscall
	#
	l.d $f4, teste
	cvt.w.d $f4, $f4
	mfc1 $a0, $f4
	li $v0, 1
	syscall
	jr $ra
	
