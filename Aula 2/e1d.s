	# Rafael Ferreira https://github.com/gipmon/ac1

	.text
	.globl main
main: 	
	ori $t1, $0, 0x0000FF1E 
	#ori $t1, $0, 0xF5A30614
	#ori $t1, $0, 0x1ABCE543
	nor $t2, $t1, 0 #MIPS implments NOT using a NOR with one operand being zero
	jr $ra