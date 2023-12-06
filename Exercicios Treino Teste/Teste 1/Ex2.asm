# Mapa de registos
# p:		$t0
# *p:		$t1
	.data
	.eqv print_str, 4
	.eqv read_str, 8
	.eqv SIZE, 20
str1:	.asciiz "Introduza uma string: "
str:	.space 21
	.text
	.globl main
main:
	li $v0, print_str		# 
	la $a0, str1			#
	syscall				# print_string("Introduza uma string: ");
	la $a0, str			#
	li $a1, SIZE			#
	li $v0, read_str		#
	syscall				# read_string(str, SIZE);
	la $t0, str			# p = str;
while:					#
	lb $t1, 0($t0)			#
	beq $t1, '\0', endwhile		#	while(*p != '\0'){
	ori $t2, $0, 0x61		#
	ori $t3, $0, 0x41		#
	subu $t4, $t1, $t2 		#
	addu $t1, $t4, $t3		#		*p = *p – 'a' + 'A';	
	sb $t1, 0($t0)			#
	addi $t0, $t0, 1		#		p++;
	j	while
endwhile:				# }
	li $v0, print_str		#
	la $a0, str			#
	syscall				# print_string(str);
	jr	$ra