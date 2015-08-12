	# Rafael Ferreira https://github.com/gipmon/ac1

	.text 
	.globl main
main: 	ori $v0, $0, 5
	syscall

	or $t0, $0, $v0 #$t0 = x (substituir val_x pelo valor de x pretendido), 1 ? o val_x n?o podemos ter variaveis declaradas
	ori $t2, $0, 8 #$t2 = 8
	add $t1, $t0, $t0 #$t1 = x + x = 2 * x
	add $t1, $t1, $t2 #$t1 = y = 2 * x + 8
	or $a0, $0, $t1
	ori $v0, $0, 36 # print_int10 > $v0 1 ; print_int16 > %$v 34 ; printintu10 > $v0 26
	syscall
	jr  $ra	#fim do programa
