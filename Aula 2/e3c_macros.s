	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
qst1:	.asciiz "Introduza 2 numeros: \n"
qst2:	.asciiz "A soma dos dois numeros e: \n"

#macro pint string
.macro print_str(%str)
	la  $a0, %str
	li $v0, 4
	syscall
.end_macro 
#macro read int
.macro read_int
	li $v0, 5
	syscall
.end_macro
#macro end program com jr $ra
.macro done
	jr $ra
.end_macro
#print int
.macro	print_int(%int)
	or $a0, $0, %int
	li $v0, 1
	syscall
.end_macro

	.text
	.globl main
main: 	
	print_str(qst1)
	#
	read_int()
	#
	or $t0, $0, $v0
	#
	read_int()
	#
	or $t1, $0, $v0
	#
	print_str(qst2)
	#
	add $t2, $t0, $t1
	#
	print_int($t2)
	#
	done