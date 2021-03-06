	# Rafael Ferreira https://github.com/gipmon/ac1

.macro print_int10
	li $v0, 1
	syscall
.end_macro 
.macro read_str_simple
	li $v0, 8
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
.macro print_char(%int)
	li $a0, %int
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
.macro print_float
	li $v0, 2
	syscall
.end_macro
.macro print_enter
	li $v0, 11
	li $a0, '\n'
	syscall
.end_macro
.macro read_double
	li $v0, 7
	syscall #$f0 -> result
.end_macro
.macro print_virgula
	li $a0, ','
	li $v0, 11
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
.end_macro
.macro print_double
	li $v0, 3
	syscall
.end_macro
