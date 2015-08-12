	# Rafael Ferreira https://github.com/gipmon/ac1

	.text 
	.globl main
main: 	ori $s3, $0, 3
	addi $s2, $s3, 3
	sw $s2, 8($s2)