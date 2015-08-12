.macro read_str(%string,%t4)
	la $a0,%string
	la $a1,%t4
	li $v0,8
	syscall
.end_macro

.macro print_str(%str_label0)
	la $a0,%str_label0
	li $v0,4
	syscall
.end_macro

.macro read_int
	li $v0,5
	syscall
.end_macro

.macro read_int(%rreg)
	li $v0,5
	syscall
	move %rreg,$v0
.end_macro

.macro print_int(%sreg)
	li $v0,1
	move $a0,%sreg
	syscall
.end_macro

.macro print_int
	li $v0,1
	syscall
.end_macro

.macro done
	li $v0,10
	syscall
.end_macro

.macro print_char(%char)
	li $a0, %char
	li $v0, 11
	syscall
.end_macro

.macro print_char_reg(%char)
	li $v0, 11
	move $a0,%char
	syscall
.end_macro

.macro print_intu(%sreg)
	li $v0,36
	move $a0,%sreg
	syscall
.end_macro
