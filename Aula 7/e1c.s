	.include "macros.s"
	.include "rotinas.s"
	#atencao: vou invocar as macros e as rotinas 
	.data
string: .asciiz " - "

	.text 
	.globl main
main:	
	#stack
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	#
	move $s1, $a0
	li $s0, 0
for_loop1:
	bge $s0, $s1, end_for
	print_char('\n')
	sll $t2, $s0, 2
	addu $a2, $a1, $t2
	lw $a0, 0($a2)
	move $s2, $a0
	print_str
	print_str_addr(string)
	
	move $a0, $s2
	jal strlen
	
	move $v1, $v0
	
	print_int_reg($v1)
	
	addiu $s0, $s0, 1
	j for_loop1
end_for:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	
	addiu $sp, $sp, 16
	
	li $v0, 0
	jr $ra
	jr $ra