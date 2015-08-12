	.data
n_par: 	.asciiz "Nr. de parametros: "
n_car:	.asciiz "Nr. de caracteres: "
n_p:	.asciiz "\nP"
dois_p:	.asciiz ": "
length: .asciiz ", length: "
letras:	.asciiz ", n letras: "
maior:	.asciiz "\nString com mais caracteres: "
.macro print_str(%str)
	la $a0, %str
	li $v0, 4
	syscall
.end_macro
.macro print_str_simple
	li $v0, 4
	syscall
.end_macro
.macro print_int(%int)
	or $a0, $0, %int
	li $v0, 1
	syscall
.end_macro
	.text
	.globl main
main:
	move $t0, $a0 # argc-count .length
	li $t1, 0 # i
	print_str(n_par)
	print_int($t0)
	li $t7, 0 # i_max_ln
for:
	bge $t1, $t0, endfor
	#word
	print_str(n_p)
	print_int($t1)
	print_str(dois_p)
	sll $t2, $t1, 2 # i*4
	addu $t2, $a1, $t2 # a1+$t2 = position
	lw $t2, 0($t2) #word
	move $a0, $t2 #arg for macro
	print_str_simple
	#word
	#count of the length
	li $t3, 0 #length = 0
	li $t6, 0 #n caracteres
	move $t5, $t2 #copia da ref da word
do:
	lb $t4, 0($t5)
	beq $t4, '\0', enddo
	addi $t3, $t3, 1 #length
	addi $t5, $t5, 1 #word+1
	#codigo para numero de letras
	blt $t4, 'A', notcount
	bgt $t4, 'z', notcount
	ble $t4, 'Z', count
	bge $t4, 'a', count
	b notcount
count:
	addi $t6, $t6, 1
	#numero de letras
notcount:
	j do
enddo:
	print_str(length)
	print_int($t3)
	#count of the length
	#if(length > i_max_len)
	blt $t3, $t7, endif
	move $t7, $t1
endif:
	print_str(letras)
	print_int($t6)
	addiu $t1, $t1, 1
	j for
endfor:
	print_str(maior)
	#
	sll $t7, $t7, 2
	addu $t7, $a1, $t7
	lw $a0, 0($t7)
	print_str_simple
	#
	li $v0, 0
	jr $ra
