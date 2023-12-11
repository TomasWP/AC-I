# Mapa de Regisots:
# $f12: res
# $t0: val
	.data
	.eqv	read_int, 5
	.eqv	print_float, 2
f1:	.float	2.59375
f2:	.float	0.0
	.text
	.globl main

main:
	la	$t1, f1		# *
	l.s	$f4, 0($t1)	# *load do valor float
	la	$t2, f2
	l.s	$f6, 0($t2)
do:
	li	$v0, read_int
	syscall
	move	$t0, $v0
	mtc1	$t0, $f0	# move o input para um registo float
	cvt.s.w	$f2, $f0	# converte o input do user de int para float
	mul.s	$f12, $f2, $f4	# multiplicacao de valores
	li	$v0, print_float
	syscall
while:
	c.eq.s	$f12, $f6
	bc1f	do
	li	$v0, 0
	jr	$ra
