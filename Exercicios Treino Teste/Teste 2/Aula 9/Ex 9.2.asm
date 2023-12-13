	.data
d1:	.double 5.0
d2:	.double 9.0
d3:	.double 32.0
	.eqv	print_string, 4
	.eqv	print_double, 3
	.eqv	read_double, 7
str1:	.asciiz "Insira a temperatura Fahrenheit em double! "
str2:	.asciiz "\n"
str3:	.asciiz " ºC"
	.text
	.globl main

main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str2
	li	$v0, print_string
	syscall
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	mov.d	$f12, $f0
	jal	f2c
	mov.d	$f12, $f0
	la	$a0, str2
	li	$v0, print_double
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	li	$v0, 0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
#===========================================================
f2c:
	la	$t0, d1
	la	$t1, d2
	la	$t2, d3
	l.d	$f2, 0($t0)
	l.d	$f4, 0($t1)
	l.d	$f6, 0($t2)
	div.d	$f0, $f2, $f4
	sub.d	$f12, $f12, $f6
	mul.d	$f0, $f12, $f0
	jr	$ra	
#==========================================================
