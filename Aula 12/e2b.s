	# Rafael Ferreira https://github.com/gipmon/ac1

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
	#--- printStudent ---#