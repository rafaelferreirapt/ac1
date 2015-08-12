	# Rafael Ferreira https://github.com/gipmon/ac1

.macro print_int10
	li $v0, 1
	syscall
.end_macro 
.macro print_int2
	li $v0, 35
	syscall
.end_macro
.macro print_int10_reg(%int)
	move $a0, %int
	li $v0, 1
	syscall
.end_macro
.macro print_str
	li $v0, 4
	syscall
.end_macro 
.macro print_char
	li $v0, 11
	syscall
.end_macro 
.macro print_str_addr(%addr)
	la $a0, %addr
	li $v0, 4
	syscall
.end_macro
.macro read_int
	li $v0, 5
	syscall
.end_macro 
