# Mapa de registos 
# i: $t0 
# array: $t1 
# array+i: $t2 
# array[i]: $t3
# soma: $t4
	
	.data
array:	.word 7692, 23, 5, 234
	.eqv SIZE, 4
	.eqv print_int10, 1
	.text
	.globl main
main:
	li $t0, 0			# i = 0
	li $t4, 0			# soma = 0
	la $t1, array			# $t1 = array;
while:
	bgtu $t0, SIZE, endwhile	# while( i <= SIZE)
	mul $t5, $t0, 4			# 	i * 4;
	addu $t2, $t1, $t5		# 	array+i;
	lw $t3, 0($t2)			# 	array[i];
	add $t4, $t4, $t3		# 	soma = soma + array[i];
	addi $t0, $t0, 1		# 	i++;
	j while
endwhile:
	move $a0, $t4
	li $v0, print_int10
	syscall
	jr $ra