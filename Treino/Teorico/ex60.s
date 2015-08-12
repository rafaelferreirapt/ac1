	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
list:	.word 0x30313200, 0x33343536, 0x37380039
	.text
	.globl main
main:
	la $t0, list
	#
	jr $ra
