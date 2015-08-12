	.include "macros.s"
.eqv std_id, 0 # 0
.eqv std_fname, 4 # 0+4
.eqv std_lname, 22 # 4+18 = 22
.eqv std_grade, 40 # 40 = 4+18+15=37+pad3=40 
	#Comprimento do First Name
.eqv std_comp_fname, 18 
#-----------------------------
	.data
student:
	.word 67405 # 4
	.asciiz "Rafael" # 18 - 7 (6+'\0') = 11
	.space 11
	#
	.asciiz "Ferreira" #15 - 8 = 7
	.space 7
	.align 2
	.float 17
str1:	.asciiz "N. mec: "
str2:	.asciiz "Primeiro Nome: "
#----------------------------
	.text
	.globl main
main:
	#--------------------
	la $t0, student
	#--------------------
	la $a0, str1
	print_str
	#--------------------
	read_int
	sw $v0, std_id($t0)
	#--------------------
	la $a0, str2
	print_str
	#--------------------
	la $a0, std_fname($t0)
	li $a1, std_comp_fname
	#--------------------
	read_str_simple
	#---------------------
	lw $a0, std_id ($t0)
	print_int10
	li $a0, '\n'
	print_char
	#--------------------
	la $a0, std_fname($t0)
	print_str
	print_char
	#--------------------
	la $a0, std_lname($t0)
	print_str
	li $a0, '\n'
	print_char
	#--------------------
	l.s $f12, std_grade($t0)
	print_float
	jr $ra
#----------------------------