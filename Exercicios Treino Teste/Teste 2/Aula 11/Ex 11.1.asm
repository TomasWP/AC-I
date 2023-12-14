	.data
	.eqv	id_number, 0
	.eqv	first_name, 4
	.eqv	last_name, 22
	.eqv	grade, 40
	.eqv	print_str, 4
	.eqv	print_intu10, 36
	.eqv	print_char, 11
	.eqv	print_float, 2
	.eqv	read_int, 5
	.eqv	read_str, 8
	.eqv	read_float, 6
	.align 2	
stg:	.word	72343
	.asciiz	"Napoleao"
	.space 9				# 18 - 9
	.asciiz "Bonaparte"
	.space 5				# 15 - 10
	.float	5.1
str1:	.asciiz	"\nN. Mec: "
str2:	.asciiz	"\nNome: "
str3:	.asciiz	"\nNota: "
	.text
	.globl main
		
main:	
	la	$t0, stg
	
	la	$a0, str1
	li	$v0, print_str
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, id_number($t0)
	la	$a0, str2
	li	$v0, print_str
	syscall
	addiu	$a0, $t0, first_name
	li	$a1, 17
	li	$v0, read_str
	syscall	
	addiu	$a0, $t0, last_name
	li	$a1, 17
	li	$v0, read_str
	syscall	
	la	$a0, str3
	li	$v0, print_str
	syscall
	li	$v0, read_float
	syscall
	s.s	$f0, grade($t0)

	la	$a0, str1
	li	$v0, print_str
	syscall
	lw	$a0, id_number($t0)
	li	$v0, print_intu10
	syscall
	la	$a0, str2
	li	$v0, print_str
	syscall
	addiu 	$a0, $t0, last_name
	li	$v0, print_str
	syscall
	li	$a0, ','
	li	$v0, print_char
	syscall
	addiu 	$a0, $t0, first_name
	li	$v0, print_str
	syscall
	la	$a0, str3
	li	$v0, print_str
	syscall
	l.s	$f12, grade($t0)
	li	$v0, print_float
	syscall
	jr	$ra