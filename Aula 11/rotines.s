#-----------------------------------
# fahrenheit to celsius!
# $f12 fahrenheit value < in
# $f0  return celsius < out
# uses $t0, $t1, $t2
	.data
f2c_const1: .double 5.0
f2c_const2: .double 9.0
f2c_const3: .double 32
	.text
f2c:
	l.d $f4, f2c_const1
	l.d $f6, f2c_const2
	l.d $f8, f2c_const3
	#
	div.d $f4, $f4, $f6
	sub.d $f0, $f12, $f8
	mul.d $f0, $f4, $f0
	#
	jr $ra
#-----------------------------------
# return avarege of an array of doubles
# $a0 = adress of array, $a1 = unsigned int n
# return $f0, avarege
# uses $t0
.data
zero: .double 0.0
.text
avarege:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	l.d $f0,zero		#soma=0.0;
	li $t0, 0 # i
avarege_for:
	bge $t0, $a1, avarege_endfor
	#
	sll $t1,$t0,3			#$t1=&A[i]
	addu $t1,$t1,$a0		#$f4=A[i]
	l.d $f4,0($t1)			#soma+=A[i]
	add.d $f0,$f0,$f4		#i++;
	addi $t0,$t0,1			#}
	b avarege_for
avarege_endfor:
	beqz $a1,avarege_eif		#if(n==0) avg_eif
	mtc1 $a1,$f4			
	cvt.d.w $f4,$f4			#$f4=(double)n
	div.d $f0,$f0,$f4		#ret: soma/(double)n
avarege_eif:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-----------------------------------
# return max of the array
# $a0 = adress of array, $a1 = unsigned int n
# return $f0, max
# uses $t0
max:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#
	li $t0, 0 # i
	l.d $f0, 0($a0) #comeca com o primeiro valor
max_for:
	bge $t0, $a1, max_endfor
	#
	l.d $f4, 0($a0)
	c.lt.d $f0, $f4
	bc1f max_endif
	mov.d $f0, $f4
max_endif:
	#
	addiu $a0, $a0, 8 # ponteiro
	addiu $t0, $t0, 1 # i++
	b max_for
max_endfor:
	#
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-----------------------------------
# sort array and returns mediane
# $a0 = adress of array, $a1 = signed int n
# return $f0, mediane
# uses $t0
sort:
	addiu $sp, $sp, 4
	sw $ra, 0($sp)
	#----------------
sort_do:
	li $t0, 0 # houveTroca = FALSE;
	li $t1, 0 # i=0
	addi $t2, $a1, -1 #nval-1
sort_for:
	bge $t1, $t2, sort_endfor
	#if
	sll $t3, $t1, 3 # i*8
	addu $t3, $a0, $t3 #array position
	l.d $f4, 0($t3) #$f4, o double do array i
	l.d $f6, 8($t3) #$f6, double array i+1
	#
	c.lt.d $f6, $f4
	bc1f sort_endif
	s.d $f6, 0($t3)
	s.d $f4, 8($t3)
	#
	li $t0, 1
sort_endif:
	addi $t1, $t1, 1
	b sort_for
sort_endfor:
	bnez $t0, sort_do
	#----------------
	li $t0, 2
	div $a1, $t0
	mflo $t0
	sll $t0, $t0, 3
	addu $t0, $t0, $a0
	l.d $f0, 0($t0)
	#----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, -4
	jr $ra
#-----------------------------------
# xtoy 
# $f12 double x, $a0, int y
# return $f0, x^y
# uses $s0 = i, $f0 = value1
#REGISTOS que n?o podem ser alterados de f20 a f30 (pares)
xtoy:
	.data
	value1:	.double 1.0
	.text
	#--------
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	#
	li $s0, 0 #i=0
	l.d $f0, value1 #result = 1.0
	abs $t0, $a0 #stupid label abs ... abs(y)
xtoy_for:
	bge $s0, $t0, xtoy_endfor
	blez $a0, xtoy_else
	mul.d $f0, $f0, $f12
	b xtoy_endif
xtoy_else:
	div.d $f0, $f0, $f12
xtoy_endif:
	addiu $s0, $s0, 1
	b xtoy_for
xtoy_endfor:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
#-----------------------------------
# sqrt 
# $f12 double val
# return $f0, sqrt(val)
#REGISTOS que n?o podem ser alterados de f20 a f30 (pares)
	.data
xn:	.double 1.0
meio:	.double 0.5
	.text	
sqrt:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	li $t0, 0 # i = 0;
	l.d $f4, zero # xn = 0.0;
	#-----------------
	c.le.d $f12, $f4
	bc1t sqrt_return #if val<=0.0
	#----------------
	l.d $f4, xn # xn = 1.0;
	l.d $f8, meio
sqrt_do:
	mov.d $f6, $f4 #aux = xn
	div.d $f4, $f12, $f6 # xn = val/xn
	add.d $f4, $f6, $f4 # xn = xn + val/xn
	mul.d $f4, $f8, $f4 # xn = 0.5 * (val/xn)
	#while
	c.eq.d $f6, $f4
	bc1t sqrt_return
	addiu $t0, $t0, 1
	blt $t0, 10, sqrt_do # pode-se otimizar, 5 ou 10 ou 15 ...
sqrt_return:
	mov.d $f0, $f4
	#----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-----------------------------------
# double var(double *array, int nval)
# $a0 = adress of array, $a1 = int n
var:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	#s.d $f20, 16($sp)
	#s.d $f22, 24($sp)
	#save $a0, $a1
	move $s0, $a0
	move $s1, $a1
	#-------------
	# i = $s2
	# media = $f20
	# soma = $f22
	#-------------
	jal avarege
	mov.d $f20, $f0 # media = $f0
	li $s2, 0 #i=0
	l.d $f22, zero #soma=0.0
var_for:
	bge $s2, $s1, var_endfor
	sll $t0, $s2, 3 #i*8
	add $t0, $s0, $t0 #*arrayy
	l.d $f12, 0($t0) #load word
	sub.d $f12, $f12, $f20 # array|i| - media
	li $a0, 2
	jal xtoy
	add.d $f22, $f22, $f0
	addiu $s2, $s2, 1
	b var_for
var_endfor:
	mtc1 $s1, $f0
	cvt.d.w $f0, $f0
	div.d $f0, $f22, $f0 
	#-------------
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	#l.d $f20, 16($sp)
	#l.d $f22, 24($sp)
	addiu $sp, $sp, 16
	jr $ra
#-----------------------------------
# double stdev(double *array, int nval)
# $a0 = adress of array, $a1 = int n
stdev:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	#-----------------
	jal var
	mov.d $f12, $f0
	jal sqrt
	#-----------------
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#-----------------------------------
