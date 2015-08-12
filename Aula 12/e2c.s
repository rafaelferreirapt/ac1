#	C—digo C     | Alinhamento | Dimens‹o | Offset
#int id_number;   	   4 	        4         0
#char first_name[18];      1            18        4
#char last_name[15];       1	        15        22
#float grade;              4	        4	  40
#student 		   4 		40
#----------------------------
	.include "macros.s"
.eqv std_id, 0 # 0
.eqv std_fname, 4 # 0+4
.eqv std_lname, 22 # 4+18 = 22
.eqv std_grade, 40 # 40 = 4+18+15=37+pad3=40
.eqv std_sizeof, 44
# dim
.eqv std_dim_fname, 18 # +1 '\0' = 18
.eqv std_dim_lname, 15 # +1 '\0' = 14
# num students
.eqv num_students 2
#-----------------------------
	.data
students: .space 88
#
string_nmec: .asciiz "Nmec: "
string_fname: .asciiz "First Name: "
string_lname: .asciiz "Last Name: "
string_grade: .asciiz "Grade: "
string_media: .asciiz "Media: "
	.align 2
media:	.float 13.44
#----------------------------
	.text
	.globl main
main:
	#--- MAIN ---#
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	# read Students
	li $s0, 0
for_1:
	bge $t1, num_students, endfor_1
	#
	mul $t1, $s0, 44
	la $t0, students
	addu $a0, $t0, $t1
	jal readStudent
	#
	addiu $s0, $s0, 1
	b for_1
endfor_1:
	#print Students
	li $s0, 0
for_2:
	bge $t1, num_students, endfor_2
	#
	mul $t1, $s0, 44
	la $t0, students
	addu $a0, $t0, $t1
	jal printStudent
	#
	addiu $s0, $s0, 1
	b for_2
endfor_2:
	#
	la $a0, students
	li $a1, num_students
	la $a2, media
	jal max
	move $a3, $v0
	#
	la $a0, string_media
	li $v0, 4
	syscall
	#
	l.s $f12, media
	li $v0, 2
	syscall
	#
	move $a0, $a3
	jal printStudent
	#
	lw $ra, 0($sp)
	sw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
	#--- MAIN ---#
	#--- readStudent ---#
readStudent:
	move $t0, $a0
	la $a0, string_nmec
	li $v0, 4
	syscall
	#
	li $v0, 5
	syscall
	sw $v0, std_id($t0)
	#
	la $a0, string_fname
	li $v0, 4
	syscall
	#
	li $v0, 8
	addiu $a0, $t0, std_fname
	li $a1, std_dim_fname
	syscall
	#
	la $a0, string_lname
	li $v0, 4
	syscall
	#
	li $v0, 8
	addiu $a0, $t0, std_lname
	li $a1, std_dim_lname
	syscall
	#
	la $a0, string_grade
	li $v0, 4
	syscall
	#
	li $v0, 6
	syscall
	s.s $f0, std_grade($t0)
	#
	jr $ra
	#--- readStudent ---#
	#--- printStudent ---#
printStudent:
	move $a1,$a0
	lw $a0,std_id($a1)
	print_int10
	print_char('\n')
	
	la $a0,std_fname($a1)
	li $v0,4
	syscall
	
	la $a0,std_lname($a1)
	li $v0,4
	syscall
	
	l.s $f12,std_grade($a1)
	li $v0,2
	syscall
	jr $ra
	#
	.data
	.align 2
f_zero: .float 0.0
f_const_m20: .float -20.0
	.text
max:
	move $t0, $a0
	mul $t1, $a1, std_sizeof # 44 * num_students
	addu $t1, $t0, $t1 # ponteiro para o fim do ultimo
	#
	l.s $f0, f_zero
	l.s $f2, f_const_m20
max_for:
	bge $t0, $t1, max_endfor
	#
	l.s $f4, std_grade($t0) #load da nota do aluno
	add.s $f0, $f0, $f4 #sum para a media
	c.le.s $f4, $f2 # p->grade <= max_grade (1)
	bc1t max_endif #quando a condicao for verdadeira salta
	mov.s $f2, $f4
	move $v0, $t0 # return pmax
max_endif:
	#
	addiu $t0, $t0, std_sizeof
	b max_for
max_endfor:
	mtc1 $a1, $f2
	cvt.s.w $f2, $f2
	div.s $f0, $f0, $f2
	s.s $f0, 0($a2)
	jr $ra
	#--- printStudent ---#