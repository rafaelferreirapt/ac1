	.text
	.globl main
main:
	li $t0, 2
	mtc1 $t0, $f0
	cvt.s.w $f4, $f0
	jr $ra