	.data
	.eqv	SIZE, 10
	.eqv	read_double, 7
	.eqv	print_double, 3
d1:	.double 0.0
array:	.space 80
	.text
	.globl main

main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	li	$t0, 0			# i = 0;
	la	$t1, array		# $t1 = array
while:
	bge	$t0, SIZE, endwhile
	mul	$t2, $t0, 8
	addu	$t3, $t1, $t2
	li	$v0, read_double
	syscall
	s.d	$f0, 0($t3)
	addi	$t0, $t0, 1
	j	while
endwhile:
	la	$a0, array
	li	$a1, SIZE
	jal	average
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
#===========================================================
average:
	la	$t2, d1			# double sum = 0.0;
	l.d	$f0, 0($t2)
	move	$t1, $a0		# $t1 = $(array);
	move	$t6, $a1		# $t6 = n;
	addi	$t0, $t6, -1		# int i = n-1;
while_average:
	blt	$t0, 0, endwhile_average
	mul	$t5, $t0, 8
	addu	$t3, $t1, $t5
	l.d	$f4, 0($t3)
	add.d	$f0, $f0, $f4
	addi	$t0, $t0, -1
	j	while_average
endwhile_average:
	mtc1	$t6, $f6
	cvt.d.w	$f6, $f6
	div.d	$f0, $f0, $f6		# return sum / (double)n;
	jr	$ra 
#==========================================================
