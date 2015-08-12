	# Rafael Ferreira https://github.com/gipmon/ac1

	# Rafael Ferreira https://github.com/gipmon/ac1

.eqv offset_nome 0
.eqv offset_telemovel 8
.eqv offset_altura 16
.eqv offset_ci 24

.eqv number_of_contactos 3
.eqv size 28
	.data
contactos: 	.space 84 # size * 3 contactos
str_nome: 	.asciiz "Nome: "
str_telemovel:  .asciiz "Telemovel: "
str_altura: 	.asciiz "Altura: "
str_ci: 	.asciiz "CI: "
	#
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a0, contactos
	li $a1, number_of_contactos
	jal read_contactos
	#
	la $a0, contactos
	jal print_contacto
	#	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-------------------------
read_contactos:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	#
	move $s0, $a0
	li $s1, 0
while:
	bge $s1, number_of_contactos, endwhile
	mul $a0, $s1, size
	add $a0, $a0, $s0
	jal read_contacto
	addiu $s1, $s1, 1
	b while
endwhile:
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
#-------------------------
read_contacto:
	move $t0, $a0
	#
	la $a0, str_nome
	li $v0, 4
	syscall
	#
	#n‹o Ž preciso o $a0
	move $a0, $t0
	li $v0, 8
	li $a1, 7 #tamano do nome, posso aumentr depois
	syscall
	#foi guardado em cima
	la $a0, str_telemovel
	li $v0, 4
	syscall
	#
	li $v0, 5
	syscall
	sw $v0, offset_telemovel($t0)
	#
	la $a0, str_altura
	li $v0, 4
	syscall
	#
	li $v0, 7
	syscall
	s.d $f0, offset_altura($t0)
	#
	la $a0, str_ci
	li $v0, 4
	syscall
	#
	li $v0, 5
	syscall
	sw $v0, offset_ci($t0)
	#
	jr $ra
#-------------------------
print_contactos:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	#
	move $s0, $a0
	li $s1, 0
while_p:
	bge $s1, number_of_contactos, endwhile_p
	mul $a0, $s1, size
	add $a0, $a0, $s0
	jal print_contacto
	#
	addiu $s1, $s1, 1
	b while_p
endwhile_p:
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
print_contacto:
	move $t0, $a0
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	move $a0, $t0
	li $v0, 4
	syscall
	#
	li $a0, '\n'
	li $v0, 11
	syscall
	#
	lw $a0, offset_telemovel($t0)
	li $v0, 1
	syscall
	#
	li $a0, '\n'
	li $v0, 11
	syscall
	#
	l.d $f12, offset_altura($t0)
	li $v0, 3
	syscall
	#
	li $a0, '\n'
	li $v0, 11
	syscall
	#
	lw $a0, offset_ci($t0)
	li $v0, 1
	syscall
	#
	jr $ra
