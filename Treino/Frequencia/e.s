	# Rafael Ferreira https://github.com/gipmon/ac1

	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
doze:	.float 12
quinze:	.float 15
	.text
	.globl main
main:
	l.s $f0, doze
	l.s $f2, quinze
	#
	c.le.s $f0, $f2 # 12 <= 15
	bc1t else
	li $t0, 1
	b endif
else:
	li $t0 0
endif:
	#
	jr $ra