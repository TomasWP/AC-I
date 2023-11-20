# Mapa de registos
# i:		$s1
# result:	$t2
	.data
	.eqv	print_float, 2
	.eqv	print_str, 4
	.eqv	read_int, 5
	.eqv	read_float, 6
result:	.float 1.0
str1:	.asciiz	"Insira um valor inteiro!"
str2:	.asciiz	"Insira um valor float!"
	.text
	.globl main

main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	la	$a0, str1
	li	$v0, print_str
	syscall
	li	$v0, read_int
	syscall
	move	$a0, $v0
	
	la	$a0, str2
	li	$v0, print_str
	syscall
	li	$v0, read_float
	syscall
	mov.s	$f12, $f0
	jal	xtoy
	li	$v0, print_float
	syscall
#------------------------------------------------------------------
xtoy:					# float xtoy(float x, int y){
	addiu	$sp, $sp, -20
	sw	$ra, 0($sp)
	s.s	$f20, 4($sp)		# x
	sw	$s0, 8($sp)		# y
	s.s	$f22, 12($sp)		# result
	sw	$s1, 16($sp)		# i
	move	$s0, $a0		#	$s0 = y;
	mov.s	$f20, $f12		#	$f20 = x;
	li	$s1, 0			#	$s1 = i = 0;
	la	$t2, result		#	result = 1.0;
	l.s	$f22, 0($t2)		#       $f22 = result;
	move	$a0, $s0		#	$a0 = y;
	jal	abs
xtoywhile:
	bge	$s1, $v0, xtoyendwhile	#	while(i<abs(y)){
xtoyif:					
	ble	$s0, 0, xtoyelse	#		if(y>0){
	mul.s	$f22, $f22, $f20	#			result*=x;
	j	xtoyendif
xtoyelse:				#		}else{
	div.s	$f22, $f22, $f20	#			result/=x;
xtoyendif:				#		}
	addi	$s1, $s1, 1		# 		i++;
	j	xtoywhile
xtoyendwhile:				#	}
	mov.s	$f12, $f22
	l.s	$f20, 4($sp)		# x
	lw	$s0, 8($sp)		# y
	l.s	$f22, 12($sp)		# result
	lw	$s1, 16($sp)		# i
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 20
	jr	$ra
#------------------------------------------------------------------
abs:					# int abs(int val){
absif:
	bge $a0, 0, absendif		# 	if (val<0){
	sub $v0, $0, $a0		#		val = -val;

absendif: 
	jr	$ra			# }
#-------------------------------------------------------------------