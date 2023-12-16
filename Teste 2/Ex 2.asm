# Mapa de Registos
# val:
# array:
# fx:	$t0
# k:	$t1
# sum:	$f2
# aux:	$f8
	.data
d1:	.double	0.0
d2:	.double 0.035
	.text
	.globl calc

calc:					# int calc(double val, double *array){	
	li	$t0, 1			# 	fx = 1;
	li	$t1, 0			# 	k = 0;
	la	$t2, d1			# 	sum = 0.0;
	move	$t3, $a1		# 	$t3 = array;
	l.d	$f2, 0($t2)		# 	$f2 = sum;
	la	$t7, d2			
	l.d	$f10, 0($t7)		# 	$f10 = 0.035; 

do:					#	do{
	addi	$t4, $t1, 1		
	mul	$t0, $t0, $t4		# 		fx = fx * (k + 1);
	mtc1	$t0, $f4
	cvt.d.w	$f4, $f4		# 		double(fx);
	mul	$t5, $t1, 8
	addu	$t6, $t3, $t5		# 		array[k];
	l.d	$f6, 0($t6)
	div.d	$f8, $f6, $f4		# 		aux = array[k]/double(fx)
	add.d	$f2, $f2, $f8		# 		sum = sum + aux;
	s.d	$f2, 0($t6)		# 		array[k] = sum;
	addi	$t1, $t1, 1		# 		k++;
while:
	c.le.d	$f8, $f10		
	bc1f	do			# 	}while(aux>0.035);
endwhile:
	cvt.w.d	$f0, $f2
	mfc1	$v0, $f0
	jr	$ra			# }