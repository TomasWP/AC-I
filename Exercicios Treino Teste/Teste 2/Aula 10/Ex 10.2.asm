	.data
d1:	.double 0.0
d2:	.double 0.5
aux:	.double	1.0
xn:	.double	1.0
str1:	.asciiz "Valor de X: "
str2:	.asciiz "\nResultado: "
	.eqv print_string, 4
	.eqv read_double, 7
	.eqv print_double, 3
	.text
	.globl main
	
main:					# int main(void) {
	addiu	$sp, $sp, -4		# 	poem espaco na pilha
	sw	$ra, 0($sp)		#	guarda o $ra
					#
	la	$a0, str1		#	$a0 = str1
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str1);
	li	$v0, read_double	#	$v0 = 3;
	syscall				#	read_double();
	mov.d	$f12, $f0		#	val = read_double;
	jal	sqrt			#	xtoy(val)
	la	$a0, str2		#	$a0 = str2;
	li	$v0, print_string	#	$v0 = 4
	syscall				#	prin_string(str2);
	mov.d	$f12, $f0		#
	li	$v0, print_double	#	print_double(return(xtoy(val)));
	syscall	
					#
	lw	$ra, 0($sp)		#	repoem o valor de $ra
	addiu	$sp, $sp, 4		#	repoem o tamnhao da pilha
	li	$v0, 0			#	return 0;
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
#===============================================================