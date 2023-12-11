# Mapa de registos
# $t0:	res
# $t1:	val	
	.data
	.eqv read_int, 5
	.eqv print_float, 2
flt1:	.float 2.59375
flt2:	.float 0.0
	.text
	.globl main

main:
do:					# do{
	li	$v0, read_int
	syscall
	move	$t0, $v0			# 	val = read_int();
	mtc1 	$t0, $f0
	cvt.s.w $f2, $f0		#	(float)val;
	la 	$t2, flt1
	l.s 	$f4, 0($t2)
	mul.s 	$f12, $f2, $f4 		# 	res = val*2.59375;
	li 	$v0, print_float
	syscall				#	print_float(res); 
while:
	la 	$t2, flt2
	l.s 	$f6, 0($t2)
	c.eq.s 	$f12, $f6
	bc1f 	do				# } while(res != 0.0);
	jr 	$ra
