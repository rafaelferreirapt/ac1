	# Rafael Ferreira https://github.com/gipmon/ac1

	.text
	.globl main
main:
	li $t0, 0xc000000f
	sra $t0, $t0, 4
	jr $ra