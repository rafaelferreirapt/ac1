	.include "macros.s"
	.include "rotinas.s"
	.data
str1:	.asciiz "\nOperacao desconhecida"
str2:	.asciiz "\Numero de argumentos errado"
buf:	.space 16
	.text
	.globl main
main:	
	subiu $sp,$sp,28
	sw $ra,0($sp)
	sw $s0,4($sp)	# val1
	sw $s1,8($sp)	# val2
	sw $s2,12($sp)	# res
	sw $s3,16($sp)	# exit_code
	sw $s4,20($sp)	# $a1
	sw $s5,24($sp)	# &buf
	move $s4,$a1
	la $s5,buf
	
	ori $s3,$0,0		# exti_code = 0 
	bne $a0,3,else		# if(argc == 3)
	lw $a0,0($s4)		# atoi(argv[0])
	jal atoi
	move $s0,$v0		# val1 = atoi(argv[0])
	lw $a0,8($s4)
	jal atoi		# atoi(argv[2])
	move $s1,$v0		# val2 = atoi(argv[2])
	lw $t0,4($s4)		# op = argv[1]
	lb $t0,0($t0)		# op = argv[1][0]
if:
	bne $t0,'x',elseif1	# if(op == 'x')
	mul $s2,$s0,$s1		# res = val1 * val2
	j exit_code
elseif1:
	bne $t0,'/',elseif2	# else if(op == '/')
	div $s2,$s0,$s1		# res = val1 / val2
	j exit_code
elseif2:
	bne $t0,'%',elseif3	# else if(op == '%')
	rem $s2,$s0,$s1		# res = val1 % val2
	j exit_code
elseif3:
	la $a0,str1
	ori $v0,$0,4
	syscall			# print_str("\nOperacao desconhecida")
	ori $s3,$0,1		# exit_code = 1
	j return
else:	
	la $a0,str2
	ori $v0,$0,4
	syscall			# print_str("\Numero de argumentos errado")
	ori $v0,$0,2		# exit_code = 2
	j return
exit_code:
	bnez $s3,return		# if(exit_code == 0)
	move $a0,$s0
	ori $a1,$0,10
	move $a3,$s0
	jal itoa		# itoa(val1,10,buf)
	move $a0,$v0		# ler o return de itoa
	ori $v0,$0,4
	syscall			# print_int10
	lw $a0,4($s4)	
	lb $a0,0($a0)
	ori $v0,$0,11
	syscall			# print_char(op)
	move $a0,$s1
	ori $a1,$0,10
	move $a3,$s5
	jal itoa		# itoa(val2,10,buf), buf = val2
	move $a0,$v0
	ori $v0,$0,4
	syscall			# print_int10(val2)
	ori $a0,$0,'='
	ori $v0,$0,11
	syscall			# print_char('=')
	move $a0,$s2
#	ori $a1,$0,10
#	move $a3,$s2
#	jal itoa		# itoa(res,
#	move $a0,$v0
	ori $v0,$0,1
	syscall	
return:
	move $v0,$s2
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	lw $s5,24($sp)
	addiu $sp,$sp,28
	jr $ra
#---------------------------#
print_int_ac:
	#---------#
	.data
	.text
	#---------#
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	la $a3, buf
	#
	jal itoa
	#
	move $a0, $v0
	print_str
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra
#---------------------------#
