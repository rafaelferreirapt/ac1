	.data
string:	.asciiz "Teste"
	.text
	.globl main
main:
	la $t0, string
	li $t1, 0xFFFF115
	li $t2, 0x0000002
	rem $t0, $t1, $t2
	jr $ra