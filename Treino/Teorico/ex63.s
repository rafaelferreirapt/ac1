	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
list:	.word 0xFFFFFF82
	.text
	.globl main
	
main:
	la $t0,list
	lb $t0,0xFF($t0)
	
	jr $ra