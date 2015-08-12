	# Rafael Ferreira https://github.com/gipmon/ac1

	.data
texto:	.space 50
	.text
	.globl main
main:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#
	la $a0, texto
	li $a1, 50
	li $v0, 8
	syscall
	#
	la $a0, texto
	jal word_count
	move $a0, $v0
	li $v0, 36
	syscall
	xD
	#teste
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
	#teste
	#
	move $s0, $v0
	la $a0, texto
	li $a1, 'a'
	#jal char_count
	#
	divu $s0, $v0
	mflo $a0
	li $v0, 36
	syscall
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
word_count:
	li $t0, 0 #count = 0
while:
	lb $t1, 0($a0)
	beq $t1, '\0', endwhile
	#
	beq $t1, ' ', if
	bne $t1, '\t', elseif
if:	
	addiu $t0, $t0, 1
	b endif
elseif:
	bne $t1, '\n', endif
	addiu $t0, $t0, 1
	li $t1, ' '
	sb $t1, 0($a0)
endif:
	addiu $a0, $a0, 1
	b while
endwhile:
	move $v0, $t0
	jr $ra
