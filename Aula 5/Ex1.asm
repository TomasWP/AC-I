# Mapa de ragistos
# i:		$t0
# lista:	$t1
# lista+i:	$t2
	.data
	.eqv SIZE, 5
	.eqv print_string, 4
	.eqv read_int, 5
str:	.asciiz	"\nIntroduza um numero: "
	.align 2
lista:	.space	20
	.text
	.globl main
	
main:
	li $t0, 0				# i = 0;
while:
	bge $t0, SIZE, endwhile			# while(i < SIZE){
	la $a0, str
	li $v0, print_string
	syscall					# 	print_string(str);
	la $t1, lista				#
	mul $t3, $t0, 4				#
	addu $t2, $t1, $t3			#
	li $v0, read_int			#
	syscall					#
	sw $v0, 0($t2)				#	lista[i] = read_int();
	addi $t0, $t0, 1			#	i++;
	j	while				#
						#
endwhile: 					# }
	jr	$ra