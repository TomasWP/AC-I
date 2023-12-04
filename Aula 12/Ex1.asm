# Mapa de Registos:
# pmax:		$t0

		.data
		.eqv	id_number, 0
		.eqv	first_name, 4
		.eqv	last_name, 22
		.eqv	grade, 40
		.eqv	print_float, 2
		.eqv	print_string, 4
		.eqv	MAX_STUDENTS, 4
str1:		.asciiz	"\nMedia: "
media:		.space 4
		.text
		.globl main
st_array:	.space 176		# 44x4 = 176 
main:
		addiu	$sp, $sp, -4
		sw	$ra, 0($sp)
		
		la	$a0, st_array
		li	$a1, MAX_STUDENTS
		jal	read_data
		la	$a0, st_array
		li	$a1, MAX_STUDENTS
		la	$a2, media
		jal	max
		move	$t0, $v0
		la	$a0, str1
		li	$v0, print_string
		syscall
		la	$t1, media
		l.s	$f12, 0($t1)
		li	$v0, print_float
		syscall
		move	$a0, $t0
		jal	print_student
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		li	$v0, 0
		jr	$ra