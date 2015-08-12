	# Rafael Ferreira https://github.com/gipmon/ac1

#needs recursive_rotines.s
#------------------------------------------
#  void print_msg(int t1, int t2, int cnt)
print_msg:
	.data
new_line: .asciiz "\n" #substituir por char
mover:	.asciiz " - Mover disco de topo de "
para:	.asciiz " para "
	.text
	#
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	#sw $s2, 12($sp) nao e necessario
	move $s0, $a0
	move $s1, $a1
	###
	la $a0, new_line
	print_str
	###
	move $a0, $a3
	li $a1, 10
	jal print_int_ac1 
	###
	la $a0, mover
	print_str
	###
	move $a0, $s0
	li $a1, 10
	jal print_int_ac1 #Thats stupid... print_int...
	###
	la $a0, para
	print_str
	###
	move $a0, $s1
	li $a1, 10
	jal print_int_ac1
	###
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
#--------------------------------------------
# void tohanoi(int n, int p1, int p2, int p3)
	.data
count:	.word 0 #static int count = 0
	.text
tohanoi:
	addiu $sp $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	#
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	#
	beq $a0, 1, tohanoi_else
	hanoi_do:
	#
	addi $a0, $a0, -1
	move $a1, $s1
	move $a2, $s3
	move $a3, $s2
	jal tohanoi
	#
	move $a0, $s1
	move $a1, $s2
	## get count, increment, store and pass
	la $t0, count
	lw $t1, 0($t0)
	addiu $a2, $t1, 1
	sw $a2, 0($t0)
	jal print_msg
	#
rafa:
	addi $a0, $s0, -1
	move $a1, $s3
	move $a2, $s2
	move $a3, $s1
	jal tohanoi
	#
	b tohanoi_endif	
tohanoi_else:
	move $a0, $s1
	move $a1, $s2
	## get count, increment, store and pass
	lw $a2, count
	addiu $a2, $a2, 1
	sw $a2, count
	jal print_msg
	#
tohanoi_endif:
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp $sp, 20
	jr $ra
#--------------------------------------------
