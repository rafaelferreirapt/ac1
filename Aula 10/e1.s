	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.data
value:	.float 2.59375 #number with single precision (doesnt need more)
zero:	.float 0.0
	.text
	.globl main
main:
	l.s $f2, zero
do:
	read_int
	mtc1 $v0, $f0 #move para o Floating Point Unit - Coprocessor 1 
	cvt.s.w $f0, $f0 #converte value to single precison from integer
	l.s $f1, value #load single precision value stored in label value || equals to lwc1 
	#
	mul.s $f12, $f0, $f1 #mul single precision values
break:
	print_float #print float stored in floting register f12
	print_enter
	#
	c.eq.s $f0, $f2 #compare equal $f0 with $f2, se true flag 0
	bc1f do #se a flag estiver a 0 entao false
	jr $ra
