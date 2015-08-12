	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
	.text
	.globl main
main:
	li $t0, 0x80000000
	sra $t1, $t0, 2
	jr $ra