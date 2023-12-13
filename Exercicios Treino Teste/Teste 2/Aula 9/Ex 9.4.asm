	.data
array:	.
	.text
	.globl main

main:
#================================================================
max:
	move	$t0, $a0		# $t0 = *p;
	move	$t1, $a1		# $t1 = n;
	addi	$t1, $t1, -1		# $t1 = n–1;
	mul	$t1, $t1, 8		# $t1 = 8*$t1;
	addu	$t2, $t0, $t1		# $t2 = *u = p+n–1; 
	l.d	$f0, 0($t0)		# max = *p;
	addiu	$t0, $t0, 8		# p++;
while_max:
	bgt	$t0, $t2, endwhile_max
	l.d	$f2, 0($t0)
if_max:
	c.le.d	$f2, $f0
	bc1t	endif_max
	mov.d	$f0, $f2
	j	endif_max
endif_max:
	addi	$t0, $t0, 8
	j	while_max
endwhile_max:
	jr	$ra
#=============================================================
	