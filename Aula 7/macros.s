	# Rafael Ferreira https://github.com/gipmon/ac1

.macro print_int_simple
	li $v0, 1
	syscall
.end_macro 
.macro print_int_reg(%int)
	move $a0, %int
	li $v0, 1
	syscall
.end_macro
.macro print_str
	li $v0, 4
	syscall
.end_macro 
.macro print_char(%char)
	li $a0, %char
	li $v0, 11
	syscall
.end_macro 
.macro print_str_addr(%addr)
	la $a0, %addr
	li $v0, 4
	syscall
.end_macro 