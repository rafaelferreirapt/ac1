	.data
addd:	.word 0x02
s:	.float 0.222
	.text
	.globl main
main:
	li $t0, 0x3FE00000
	mtc1 $t0, $f8
	#cvt.s.w $f8, $f8
	cvt.d.s $f10, $f8
	#cvt.s.d $f8, $f10
	jr $ra
