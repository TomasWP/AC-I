	.data
result:	.float	1.0
	.eqv print_string, 4
	.eqv print_float, 2
	.eqv read_float, 6
	.eqv read_int, 5
str1:	.asciiz "\nQual o valor de X? "
str2:	.asciiz "\nQual o valor de Y? "
str3:	.asciiz "\nResultado: "
	.text
	.globl main

main:					# int main(void) {
	addiu	$sp, $sp, -4		# 	poem espaco na pilha
	sw	$ra, 0($sp)		#	guarda o $ra
					#
	la	$a0, str1		#	$a0 = str1
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str1)
	li	$v0, read_float		#	$v0 = 7;
	syscall				#	read_double();
	mov.d	$f12, $f0		#	x = read_double();
					#
	la	$a0, str2		#	$a0 = str2
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str2)
	li	$v0, read_int		#	$v0 = 5;
	syscall				#	read_int();
	move	$a0, $v0			#	y = read_int();
	
	jal	xtoy			#	xtoy(x, y);
	mov.d 	$f12, $f0		#	result = return(xtoy(x, y));
	
	la	$a0, str3		#	$a0 = str3
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str3)
	li	$v0, print_float	#
	syscall				#	print_double(result);
					#	
	lw	$ra, 0($sp)		#	repoem o valor de $ra
	addiu	$sp, $sp, 4		#	repoem o tamanho da pilha
	li	$v0, 0			#	return 0;
	jr	$ra			# }
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
