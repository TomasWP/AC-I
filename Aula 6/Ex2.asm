# Mapa de registos
# pultimo:	$t0;
# p:		$t1;
# *p:		$t2;
	.data
	.eqv SIZE, 3
	.eqv print_char, 11
	.eqv print_str, 4
array:	str1, str2, str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.text
	.globl main

main:
	la	$t1, array		# p = array;
	li	$t3, SIZE
	mul	$t3, $t3, 4		# SIZE = SIZE * 4;
	add	$t0, $t1, $t3		# pultimo = array + SIZE;
while:
	bge	$t1, $t0, endwhile	# while ( p < pultimo) {
	lw	$t2, 0($t1)		# 	*p = p[0];
	li	$v0, print_str
	move	$a0, $t2
	syscall				# 	print_str(*p);
	li	$a0, '\n'
	li	$v0, print_char
	syscall				# 	print_char('\n');
	addiu	$t1, $t1, 4		# 	p++;
	j	while
endwhile:				# }
	jr	$ra