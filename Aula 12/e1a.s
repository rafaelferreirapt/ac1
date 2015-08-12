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
#-----------------------------
	.data
student:
	.word 67405 # 4
	#isto sem leitura de dados
	.asciiz "Rafael" # 18 - 7 (6+'\0') = 11
	.space 11
	#-------
	.asciiz "Ferreira" #15 - 8 = 7
	.space 7
	#-------
	.align 2
	.float 18 #grade
#----------------------------
	.text
	.globl main
main:
	la $t0, student
	lw $a0, std_id($t0)
	print_int10
	li $a0, ','
	print_char
	#
	la $a0, std_fname($t0)
	print_str
	li $a0, ','
	print_char
	#
	la $a0, std_lname($t0)
	print_str
	li $a0, ','
	print_char
	#
	l.s $f12, std_grade($t0)
	print_float
	jr $ra
