	.data
wd:	.word 0x82
	.text
	.globl main
main:
	la $t1, wd
	lb $t0, 0($t1)
	jr $ra