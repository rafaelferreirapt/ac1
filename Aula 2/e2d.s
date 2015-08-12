	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
	.text
	.globl main
main: 	
	#Primeiro numero
	ori $t0,  0x12345678 #valor que vamos mostrar
	
	andi $a0, $t0, 0xF0000000 #Mascara escrita em hexadecimal, mantem os 4bits mais significativos
	srl $a0, $a0, 28
	
	ori $v0, $0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	#Primeiro numero
	
	andi $a0, $t0, 0x0F000000 
	srl $a0, $a0, 24 
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x00F00000
	srl $a0, $a0, 20
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x000F0000
	srl $a0, $a0, 16
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x0000F000
	srl $a0, $a0, 12
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x00000F00
	srl $a0, $a0, 8
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x000000F0
	srl $a0, $a0, 4
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	andi $a0, $t0, 0x0000000F
	li $v0, 34 #define o registo que armazena a funcao de syscall que vou precisar, neste caso o 34 ? F
	syscall
	
	jr $ra
