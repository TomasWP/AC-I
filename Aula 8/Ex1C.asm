	.data
	.eqv print_int10, 1
str:	.asciiz "101101"
	.text
	.globl main
main:					# int main(void){
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str
	jal	atoi
	move	$a0, $v0
	li	$v0, print_int10
	syscall				# print_int10(atoi(str));
	li	$v0, 0	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra			# }
#--------------------------------------------------------------------
# Mapa de registos
# res:		$v0
# s:		$a0
# *s:		$t0
# digit:	$t1
		.data
		.text
atoi:
	li	$v0, 0			# res = 0;
	li	$t1, 0			# digit = 0;
atoi_while:				#
	lb	$t0, 0($a0)		#
	blt	$t0, '0', atoi_endwhile	#
	bgt	$t0, '1', atoi_endwhile	# while( (*s >= '0') && (*s <= '9') ){
	li	$t2, '0'		#
	sub	$t1, $t0, $t2		#	digit = *s – '0' ;
	addiu	$a0, $a0, 1		#	s++;
	mul	$v0, $v0, 2		#	res = res * 2;
	add	$v0, $v0, $t1		#	res = res + digit;
	j	atoi_while		# }
atoi_endwhile:				# return res;
	jr	$ra			# 
#----------------------------------------------------------------------