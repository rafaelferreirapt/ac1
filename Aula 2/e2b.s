	# Rafael Ferreira https://github.com/gipmon/ac1

	.text
	.globl main
main: 	
	#ori $t1, $0, 0x12345678 #1
	#ori $t1, $0, 0x12345678 #4
	#ori $t1, $0, 0x12345678 #16
	#ori $t1, $0, 0x862A5C1B #2
	ori $t1, $0, 0x862A5C1B #4 
	
	sll $t2, $t1, 2
	srl $t3, $t1, 2
	sra $t4, $t1, 2
	
	jr $ra
