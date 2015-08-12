#-----------------------------------------
#  int strlen(char *s) 
#  return number of chars of the string
strlen:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#usamos registos t poque nao ha necessidade de salvaguardar o valor de $t0
	lb $t0, 0($a0)
	beqz $t0, strlen_else
	#
	addiu $a0, $a0, 1
	jal strlen
	addi $v0, $v0, 1
	b strlen_endif	
strlen_else:
	li $v0, 0
strlen_endif:
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-----------------------------------------	
# char *strcpy(char *dst, char *src)
# return dst;
strcpy:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	#
	lb $t0, 0($a1) # *src
	sb $t0, 0($a0) # *dst = *src
	beqz $t0, strcpy_endif
	addiu $a0, $a0, 1
	addiu $a1, $a1, 1
	jal strcpy
strcpy_endif:
	#
	lw $ra, 0($sp)
	lw $v0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
#-----------------------------------------	
# int soma(int *array, int nelem)
# return $v0, soma
soma:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#
	beqz $a1, soma_else
	#
	lw $s0, 0($a0)
	addiu $a0, $a0, 4
	addiu $a1, $a1, -1
	#
	jal soma
	add $v0, $s0, $v0
	#
	b soma_endif
soma_else:
	li $v0, 0
soma_endif:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
#-----------------------------------------	
# unsigned int fact(unsigned int n)
# return facturial
unsigned_fact:	
	addiu $sp, $sp, -8 
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#
	bleu $a0, 12, unsigned_fact_endif
	li $v0, 10
	syscall	
unsigned_fact_endif:
	bleu $a0, 1, unsigned_fact_return1
	#
	move $s0, $a0
	addiu $a0, $a0, -1
	jal unsigned_fact
	mulu $v0, $s0, $v0 
	#
	b unsigned_fact_jrra
unsigned_fact_return1:
	li $v0, 1
unsigned_fact_jrra:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
#-----------------------------------------
# int xtoy(int x, unsigned int y)
# return x^y
xtoy:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	beqz $a1, xtoy_returnelse
	addiu $a1, $a1, -1
	jal xtoy
	mul $v0, $a0, $v0
	b xtoy_jrra	
xtoy_returnelse:
	li $v0, 1
xtoy_jrra:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4 	
	jr $ra
#-----------------------------------------
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
#-----------------------------------------------
# void print_int_ac1(unsigned int num, unsigned int base)
#  if(num / base)
#  print_int_ac1( num / base, base );
#  print_char( toascii(num % base) );
print_int_ac1:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#
	move $s0, $a0
	#
	divu $a0, $s0, $a1
	beqz $a0, print_int_ac1_endif
	jal print_int_ac1
print_int_ac1_endif:
	remu $a0, $s0, $a1
	jal toascii
	move $a0, $v0
	print_char
	#
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
#-----------------------------------------------
# toascii
# in $a0 = int v  | $v0 = char
toascii:
	addiu $v0, $a0, '0'
toasciiif:
	ble $v0, '9', toasciiendif
	addiu $v0, $v0, 7
toasciiendif:
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
