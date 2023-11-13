	.data
d1:	.double 5.0
d2:	.double 9.0
d3:	.double 32.0
	.eqv read_double, 7
	.eqv print_str, 4
	.eqv print_double, 3
str1:	.asciiz "Insira um valor em double!"
	.text
	.globl main

main:
	addiu	$sp, $sp, -4			#
	sw	$ra, 0($sp)			#	
	la	$a0, str1			#
	li	$v0, print_str
	syscall					# print_str(str1);
	li	$v0, read_double		
	syscall					# 
	mov.d 	$f12, $f0			# $f12 = read_double();
	jal	f2c				# $f0 = f2c($f12);
	mov.d	$f12, $f0			# $f12 = $f0;
	li	$v0, print_double
	syscall					# print_double($f12);
	lw	$ra, 0($sp)			#	
	addiu	$sp, $sp, 4			#
	jr	$ra				#		






#----------------------------------------------------------------
f2c:						# double f2c(double ft){
	la $t0, d1
	la $t1, d2
	la $t3, d3
	l.d $f0, 0($t0)				# 	$f0 = 5.0;
	l.d $f2, 0($t1)				# 	$f2 = 9.0;
	l.d $f4, 0($t3)				# 	$f4 = 32.0;
	div.d $f6, $f0, $f2			# 	$f6 = 5.0/9.0;				
	sub.d $f8, $f12, $f4			# 	$f8 = ft - 32.0;
	mul.d  $f0, $f6, $f8			# 	$f0 = $f6 * $f6;
	jr $ra					# 	return $v0;
						# }