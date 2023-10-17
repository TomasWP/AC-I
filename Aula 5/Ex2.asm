# Mapa de registos
#  p:		$t0
# *p:		$t1
	.data
	.eqv SIZE, 10
	.eqv print_string, 4
	.eqv print_int10, 1
lista:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
str:	.asciiz "\nConteudo do array:\n"
str1:	.asciiz "; "
	.text
	.globl main
	
main:
	la	$a0, str				# 
	li	$v0, print_string			# 
	syscall						# print_string(str);
	la	$t0, lista				# p = lista;
	li	$t2, SIZE				#
	mul	$t2, $t2, 4				#
	addu	$t2, $t2, $t0				#
while:							#
	bge	$t0, $t2, endwhile			# while(p < lista + SIZE){
	lw	$t1, 0($t0)				#
	move	$a0, $t1				#
	li	$v0, print_int10			#
	syscall						# 	print_int10(*p);
	la	$a0, str1				#
	li	$v0, print_string			#
	syscall						# 	print_string("; "); 
	addi	$t0, $t0, 4				# 	p++;
	j	while
endwhile:						# }
	jr	$ra