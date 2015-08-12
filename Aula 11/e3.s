	# Rafael Ferreira https://github.com/gipmon/ac1

	.include "macros.s"
	.include "rotines.s"
	.data
	.eqv SIZE, 11
	.eqv SIZEBYTES, 88
	.align 3
far_val:.double 8.0, -4.0, 3.0, 5.0, 12.0, -15.0, 87.0, 9.0, 27.0, 15.0, 35.0
cel_arr:.space SIZEBYTES
max_str:.asciiz "Max: "
media:	.asciiz "Media: "
mediana:.asciiz "Mediana: "
variancia:.asciiz "Variancia: "
desvio:	.asciiz "Desvio: "
	.text
	.globl main
main:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#-----------------
	li $s0, 0 #i=0
for:
	bge $s0, SIZE, endfor
	sll $t0, $s0, 3 #i*3
	l.d $f12, far_val($t0)
	jal f2c
	sll $t0, $s0, 3 #i*3
	s.d $f0, cel_arr($t0)
	addiu $s0, $s0, 1
	b for
endfor:
	#------- print max
	la $a0, max_str
	print_str
	la $a0, cel_arr
	li $a1, SIZE
	jal max
	mov.d $f12, $f0
	print_double
	li $a0, '\n'
	print_char
	#------- print media
	la $a0, media
	print_str
	la $a0, cel_arr
	li $a1, SIZE
	jal avarege
	mov.d $f12, $f0
	print_double
	li $a0, '\n'
	print_char
	#------- print mediana & sort
	la $a0, mediana
	print_str
	la $a0, cel_arr
	li $a1, SIZE
	jal sort
	mov.d $f12, $f0
	print_double
	li $a0, '\n'
	print_char
	#------- print variancia
	la $a0, variancia
	print_str
	la $a0, cel_arr
	li $a1, SIZE
	jal var
	mov.d $f12, $f0
	print_double
	li $a0, '\n'
	print_char
	#------- print devio padrao
	la $a0, desvio
	print_str
	la $a0, cel_arr
	li $a1, SIZE
	jal stdev
	mov.d $f12, $f0
	print_double
	li $a0, '\n'
	print_char
	#------- PRINT ARRAY
	la $t0, cel_arr
	addiu $t1, $t0, SIZEBYTES
print_for:
	bge $t0, $t1, print_endfor
	#
	l.d $f12, 0($t0)
	print_double
	print_virgula
	addiu $t0, $t0, 8 # ponteiro
	b print_for
print_endfor:
	#-----------------
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, -8
	jr $ra
