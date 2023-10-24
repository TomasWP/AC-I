# Mapa de registos
# i:		$t0;
# j:		$t1;
# array:	$t2;
# $array[i][j]:	$t3;
		.data
		.eqv SIZE, 3
		.eqv print_str, 4
		.eqv print_char, 11
		.eqv print_int10, 1
array:	.word	str1, str2, str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ": "
	.text
	.globl main

main:
	li	$t0, 0			# i = 0;
	la	$t2, array		# $t2 = array;
while:
	bge	$t0, SIZE, endwhile	# while (i < SIZE){
	la	$a0, str4
	li	$v0, print_str
	syscall				# 	print_str("\nString #");
	move	$a0, $t0
	li	$v0, print_int10
	syscall				# 	print_int10(i);
	la	$a0, str5
	li	$v0, print_str		
	syscall				# 	print_str(": ");
	li	$t1, 0			# 	j = 0;
	mul	$t4, $t0, 4
while2:
	addu	$t2, $t2, $t4
	lw	$t3, 0($t2)
	addu	$t3, $t3, $t1
	lb	$t3, 0($t3)
	li	$t4, '\0'
	beq	$t3, $t4, endwhile2	# 		while(array[i][j] != '\0'){
	li	$v0, print_char
	move	$a0, $t3
	syscall				# 			print_char(array[i][j]);
	li	$v0, print_char
	li	$a0, '-'
	syscall				#			print_char('-');
	addi	$t1, $t1, 1		#			j++;
	j	while2
endwhile2:				#		}
	addi	$t0, $t0, 1		# 	i++;
	j	while
endwhile:
	jr	$ra
