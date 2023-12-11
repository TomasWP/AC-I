	.data
	.eqv	print_int10, 1
str:	.asciiz	"2020 e 2024 sao anos bissextos"
	.text
	.globl main

main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str
	jal	atoi
	move	$a0, $v0
	li	$v0, print_int10
	syscall
	li	$v0, 0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
#============================================================
# Mapa de Registos:
# $t0:	digit
# $v0:	res
# $t1:	*s
atoi:
	li	$v0, 0
while_atoi:
	lb	$t1, 0($a0)
	blt	$t1, '0', endwhile_atoi
	bgt	$t1, '9', endwhile_atoi
	addi	$t0, $t1, -0x30
	addiu	$a0, $a0, 1
	mul	$v0, $v0, 10
	add	$v0, $v0, $t0
	j	while_atoi
endwhile_atoi:
	jr	$ra
#============================================================