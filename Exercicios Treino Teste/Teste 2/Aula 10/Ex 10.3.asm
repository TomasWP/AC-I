	.data
	.eqv	SIZE, 10
	.eqv	read_double, 7
	.eqv	print_double, 3
d1:	.double 0.0
d2:	.double 0.5
aux:	.double	1.0
xn:	.double	1.0
result:	.float	1.0
array:	.space 80
	.text
	.globl main

main:					# int main(void){
	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	li	$s0, 0			# 	i = 0;
	la	$s1, array		# 	$s1 = array;
while:
	bge	$s0, SIZE, endwhile	#	while(i < SIZE){
	mul	$t2, $s0, 8
	addu	$t3, $s1, $t2
	li	$v0, read_double
	syscall				#		arr[i] = read_double(); 
	s.d	$f0, 0($t3)
	addi	$s0, $s0, 1
endwhile:				#	}
	la	$a0, array
	li	$a1, SIZE
	jal	average
	move	$a0, $v0
	li	$v0, print_double
	syscall				#	print_double( average(arr, SIZE) );
	la	$a0, array
	jal	var
	move	$a0, $v0
	li	$v0, print_double
	syscall				#	print_double( var(arr, SIZE) );
	la	$a0, array
	jal	stdev
	move	$a0, $v0
	li	$v0, print_double
	syscall				#	print_double( stdev(arr, SIZE) );
	li	$v0, 0			# 	return 0; 
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 12
	jr	$ra			# }
#================================================================================
var:					# double var(double *array, int nval){
	addiu	$sp, $sp, -30
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 14($sp)
	sw	$s2, 18($sp)
	s.s	$f20, 22($sp)		# 	$f20 = media;
	s.s	$f22, 26($sp)		# 	$f22 = soma;
	li	$s0, 0			# 	$s0 = i = 0;
	move	$s1, $a0		# 	$s1 = array;
	move	$s2, $a1		# 	$s2 = nval;
	
	move	$a0, $s1
	move	$a1, $s2
	jal	average			# 	$v0 = (float)average(array, nval);
	mtc1	$v0, $f20		# 	media = $v0;
while_var:
	bge	$s0, $s2, endwhile_var	#	while(i < nval){
	addu	$t0, $s1, $s0
	l.s	$f12, 0($t0)		
	cvt.s.d	$f12, $f12
	sub.s	$f12, $f12, $f20
	li	$a0, 2
	jal	xtoy
	add.s	$f22, $f22, $f0		#		soma += xtoy((float)array[i] - media, 2);
	addi	$s0, $s0, 1		#		i++;
endwhile_var:				#	}
	cvt.d.s	$f0, $f22
	l.d	$f2, 0($s2)
	cvt.d.s	$f2, $f2
	div.d	$f0, $f0, $f2		#	return (double)soma / (double)nval; 
	l.s	$f22, 26($sp)
	l.s	$f20, 22($sp)
	lw	$s2, 18($sp)
	lw	$s1, 14($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 30
	jr	$ra			# }
#==========================================================
sqrt:					# double sqrt(double val){
	la	$t0, aux
	la	$t1, xn
	la	$t2, d1
	la	$t4, d2	
	l.d	$f2, 0($t0)		# 	$f2 = aux;
	l.d	$f0, 0($t1)		# 	$f0 = xn;
	l.d	$f4, 0($t2)		# 	$f4 = d1;
	l.d	$f10, 0($t4)		#	$f10 = d2;
	li	$t3, 0			# 	i = 0;
	mov.d	$f6, $f12		# 	$f6 = val;

if_sqrt:
	c.le.d $f6, $f4			#	if(val > 0.0){ 
	bc1t	else_sqrt
do_sqrt:				#		do{
	mov.d	$f2, $f0		#			aux = xn;
	div.d	$f8, $f6, $f0		#			$f8 = val/xn;
	add.d	$f0, $f0, $f8		#			$f0 = xn + $f8;
	mul.d	$f0, $f10, $f0		#			$f0 = 0.5 * $f0;
	addi	$t3, $t3, 1		#			i++;
while_sqrt:				
	c.eq.d	$f2, $f0
	bc1t	endif_sqrt
	bge	$t3, 25, endif_sqrt	#		}while((aux != xn) && (i < 25));
	j	do_sqrt		
else_sqrt:				#	}else
	mov.d	$f0, $f4		#  		xn = 0.0; 
 					# 	return xn;
endif_sqrt:
	jr	$ra			# } 
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
stdev:					# double stdev(double *array, int nval){
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	jal	var
	mov.d	$f12, $f0
	jal	sqrt			#	return sqrt( var(array, nval) );
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra			# }
#==========================================================
#========================================================
xtoy:					# float xtoy(float x, int y){
	addiu	$sp, $sp,-20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)		# 	$s0 = i;
	s.s	$f22, 8($sp)		# 	$f22 = result;
	s.s	$f20, 12($sp)		# 	$f20 = x;
	sw	$s1, 16($sp)		# 	$s2 = y;

	li	$s0, 0			# 	$s0 = i = 0;
	la	$t0, result
	l.s	$f22, 0($t0)		# 	$f22 = result = 1.0	
	mov.s	$f20, $f12		#	$f20 = x;
	move	$s1, $a0		# 	$s1 = y;
	move	$a0, $s1
	jal	abs
while_xtoy:
	bge	$s0, $v0, endwhile_xtoy	# 	for(i=0, result=1.0; i < abs(y); i++){
if_xtoy:
	ble	$s1, 0, else_xtoy	# 		if(y > 0) 
	mul.s	$f22, $f22, $f20	#			result *= x;
	j	endif_xtoy
else_xtoy:				#	 	else
	div.s	$f22, $f22, $f20	#			result /= x; 
endif_xtoy:
	addi	$s0, $s0, 1 		#		i++;
	j	while_xtoy		# 	}
endwhile_xtoy:
	mov.s	$f0, $f22		#	return result;
	lw	$s1, 16($sp)
	l.s	$f20, 12($sp)
	l.s	$f22, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp,20
	jr	$ra
#=========================================================
abs:
	move	$v0, $a0
if:
	bge	$v0, 0, endif
	mul	$v0, $v0, -1
endif:
	jr	$ra
#=========================================================