	# Rafael Ferreira https://github.com/gipmon/ac1

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
# ----------------------------
# ATOI
# in $a0 = *s | $v0 = rest
# uses registers:
atoi:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)  #char of $a0
	sw $s1, 8($sp)  #digit
	sw $s2, 12($sp) #res
	#
	li $s2, 0
	#
atoiwhile:
	lb $s0, 0($a0)
	blt $s0, '0', atoiendwhile
	bgt $s0, '9', atoiendwhile
	#
	subiu $s1, $s0, '0'
	addiu $a0, $a0, 1
	mulu $s2, $s2, 10
	addu $s2, $s2, $s1
	#
	j atoiwhile
atoiendwhile:
	move $v0, $s2
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
# ----------------------------
# ATOI - base 2
# in $a0 = *s | $v0 = rest
# uses registers:
atoi_2:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)  #char of $a0
	sw $s1, 8($sp)  #digit
	sw $s2, 12($sp) #res
	#
	li $s2, 0
	#
atoiwhile_2:
	lb $s0, 0($a0)
	blt $s0, '0', atoiendwhile_2
	bgt $s0, '1', atoiendwhile_2
	#
	subiu $s1, $s0, '0'
	addiu $a0, $a0, 1
	mulu $s2, $s2, 10
	addu $s2, $s2, $s1
	#
	j atoiwhile_2
atoiendwhile_2:
	move $v0, $s2
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
# ----------------------------
# ITOA 
# in $a0 = n, $a1 = b, $a2 = char *s | $v0 = *char
# uses registers: $s0..4
itoa:
	addiu $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)  # char *p
	sw $s1, 8($sp)  # char digit
	sw $s2, 12($sp) # for n
	sw $s3, 16($sp) # for b
	sw $s4, 20($sp) # for preserve *s
	#
	move $s2, $a0 # n
	move $s3, $a1 # b
	move $s0, $a3 # *s
	move $s4, $s0 # $s4 = $s0
	#
itoado:
	div $s2, $s3 #div n/b
	mfhi $s1 # digit = n%b
	mflo $s2 # n = n/b
	#
	#remu $s1, $s2, $s3
	#divu $s2, $s2, $s3
	#
	move $a0, $s1
	jal toascii
	sb $v0, 0($s0)
	addiu $s0, $s0, 1
	#
	bgtz $s2, itoado
#itoaenddo:
	sb $0, 0($s0)
	#
	move $a0, $s4
	jal strrev
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)  # char *p
	lw $s1, 8($sp)  # char digit
	lw $s2, 12($sp) # for n
	lw $s3, 16($sp) # for b
	lw $s4, 20($sp) # for preserve *s
	addiu $sp, $sp, 24
	#
	jr $ra
# ----------------------------
# toascii
# in $a0 = int v  | $v0 = char
toascii:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	add $v0, $a0, '0'
toasciiif:
	ble $v0, '9', toasciiendif
	addi $v0, $v0, 7
toasciiendif:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	#
	jr $ra
# ----------------------------
# unsigned int div(unsigned int dividendo, unsigned int divisor)
# int i, bit, quociente, resto;
# return (resto | quociente);
#
unsigned_div:
	addiu $sp, $sp, -20
	sw $ra, 0($sp) # ra
	sw $s0, 4($sp) # i
	sw $s1, 8($sp) # bit
	sw $s2, 12($sp) # quociente
	sw $s3, 16($sp) # resto
	#---
	# $a0 = unsigned int dividendo
	# $a1 = unsigned int divisor
	sll $a1, $a1, 16
	and $a0, $a0, 0xFFFF
	sll $a0, $a0, 1
	#
	li $s0, 0
	#
unsigned_div_for:
	bge $s0, 16, unsigned_div_endfor
	#
	li $s1, 0 #bit = 0;
	blt $a0, $a1, unsigned_div_endif
	#
	subu $a0, $a0, $a1 #dividendo = dividendo - divisor;
	li $s1, 1 #bit = 1;
	#
unsigned_div_endif:
	#
	sll $a0, $a0, 1
	or $a0, $a0, $s1
	#
	addiu $s0, $s0, 1
	b unsigned_div_for
unsigned_div_endfor:
	#
	sra $s3, $a0, 1
	andi $s3, $s3, 0xFFFF0000
	#
	andi $s2, $a0, 0xFFFF
	#
	or $v0, $s3, $s2
	#---
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20
	#
	jr $ra
# ----------------------------
