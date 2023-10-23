# Mapa de registos
# i:		$t0;
# array:	$t1;
# &array[i]:	$t2;
	.data
	.eqv	SIZE, 3
	.eqv	print_str, 4
	.eqv	print_char, 11
array:	.word	str1, str2, str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.text
	.globl main
	
main:	
	li	$t0, 0			# i = 0;
	la	$t1, array		# &array[0} = $t1;
while:					#
	bge	$t0, SIZE, endwhile	# while (i < SIZE){
	mul	$t3, $t0, 4		#
	addu	$t2, $t1, $t3		#
	li	$v0, print_str		#
	lw	$a0, 0($t2)		#	
	syscall				# 	print_str(array[i});
	li	$v0, print_char		#
	li	$a0, '\n'		#
	syscall				# 	print_char("\n");
	addi	$t0, $t0, 1		#	i++;
	j	while			#
endwhile:				# }
	jr	$ra			