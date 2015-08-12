	.text
	.globl main
main: 	
	#ori $t0, $0, 0 #declarar o $t0
	#ori $t1, $0, 1 #declarar o $t1
	and $t2, $t0, $t1
	or  $t3, $t0, $t1
	nor $t4, $t0, $t1
	xor $t5, $t0, $t1
	jr $ra