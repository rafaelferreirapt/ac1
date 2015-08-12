	# Rafael Ferreira https://github.com/gipmon/ac1

	.text 
	.globl main
main: 	ori $t0,$0, 1 #$t0 = x (substituir val_x pelo valor de x pretendido), 1 ? o val nao podemos ter variaveis declaradas
	ori $t2, $0, 8 #$t2 = 8
	add $t1, $t0, $t0 #$t1 = x + x = 2 * x
	add $t1, $t1, $t2 #$t1 = y = 2 * x + 8
	jr  $ra	#fim do program
	#para adicionar constantes usamos o addi
