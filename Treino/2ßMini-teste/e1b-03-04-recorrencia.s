	.data
tabelaprecos: .float 1.2, 5.3, 4.7, 4.8, 8.9, 2.5
numProdutos: .space 4 # unsigned int numProdutos
str1: .asciiz "\nNr: de produtos: "
str2: .asciiz "\nCusto total: "
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
#while:
	la $a0, numProdutos 
	jal RegistarProdutos
	#
	li $v0, 4
	la $a0, str1
	syscall
	#
	lw $a0, numProdutos($0)
	li $v0, 1
	syscall
	#
	la $a0, str2
	li $v0, 4
	syscall
	#
	mov.s $f12, $f0
	li $v0, 2
	syscall
	#
	#b while
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	.data
str3:	.asciiz "C?digo do produto (99 para terminar):"
	.text
RegistarProdutos:
	li $s0, 0 #codProd = 0
rp_while:
	beq $s0, 99, rp_endwhile
	
	b rp_while
rp_endwhile:
	jr $ra