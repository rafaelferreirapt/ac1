# --------------------------------------
# STRING LENGTH
# in: $a0 = str, out: $v0 = str_length
#$ra will be used to call other routines
strlen:
	li $v0, 0
loop:	
	lb $t0, 0($a0)
	beqz $t0, exit
	addi $v0, $v0, 1
	addiu $a0, $a0, 1
	j loop
exit:
	jr $ra 
# --------------------------------------
# STRING REVERSE
# in: $a0 = str, out: $a0 = str
# ueses $t1, $a1, $s0, calls: 'exchanges'
#$ra will be used to call other routines
strrev:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	move $a1, $a0
srv_lp: #while(*p2!='\0')
	lb $t0, 0($a1)
	beqz $t0,  srv_lchar
	addi $a1, $a1, 1 #p2++
	j srv_lp
srv_lchar: #$a1 = p2
	addi $a1, $a1, -1
	move $s0, $a0
srv_wh: #while(p1<p2)
	bge $a0, $a1, srv_wh_end
	jal exchange
	addi $a0, $a0, 1
	addi $a1, $a1, -1
	j srv_wh
srv_wh_end:
	move $v0, $s0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
exchange:
	lb $v0, 0($a0)
	lb $v1, 0($a1)
	sb $v1, 0($a0)
	sb $v0, 0($a1)
	jr $ra
# ----------------------------
# STRING COPY
# this function copy an string for other location in 
# memory. in $a0 = *src, $a1 = *dst | out, $v0 = $a1
# uses registers: $s0 (preserved) 
strcpy:
	#save what i use
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp) #used to increment
	sw $a0, 8($sp) #because it will devolved in $v0
	#
strcpdo:
	lb $s0, 0($a1)
	beq $s0, '\0', strcpenddo
	sb $s0, 0($a0)
	addu $a0, $a0, 1
	addu $a1, $a1, 1
	j strcpdo
strcpenddo:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $v0, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
# ----------------------------
# STRING CONCAT
# this function concat $a1 with $a0
# in $a0 = *dst , $a1 = *src | $v0 = dst
# uses registers: $s0, $s1
strcat:
	#preserve
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	#
	move $s0, $a0
strcatwhile:
	lb $s1, 0($s0)
	beq $s1, '\0', strcatendwhile
	add $s0, $s0, 1
	j strcatwhile
strcatendwhile:
	#
	move $a0, $s0
	jal strcpy
	#
	lw $ra, 0($sp)
	lw $v0, 4($sp)
	lw $s0, 8($sp)
	lw $s1, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
