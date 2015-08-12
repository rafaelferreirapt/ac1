	.text
	.globl main
main:
	jal teste
	b fim
teste:	
	move $t5, $ra
	jalr $t5
fim:
	jr $ra
	