	.data
	.eqv	MAX_STR_SIZE, 33
	.eqv	read_int, 5
	.eqv	print_string, 4
str:	.space 33
str1:	.asciiz "\n"	
	.text
	.globl main

main:
	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
do:
	li	$v0, read_int
	syscall
	move	$s0, $v0
	
	move	$a0, $s0
	li	$a1, 2
	la	$a2, str
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li	$v0, print_string
	la	$a0, str1
	syscall
	
	move	$a0, $s0
	li	$a1, 8
	la	$a2, str
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li	$v0, print_string
	la	$a0, str1
	syscall
	
	move	$a0, $s0
	li	$a1, 16
	la	$a2, str
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
while:
	bne	$s0, 0, do
	li	$v0, 0
	lw	$ra, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 8
	jr	$ra
#============================================================
# Mapa de Registos
# $s0:	n
# $s1:	b
# $s3:	p
# $t2:	digit
	.text
	.globl itoa
	
itoa:
	addiu	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a2
do_itoa:
	rem	$t0, $s0, $s1
	div	$s0, $s1
	mflo	$s0
	move	$a0, $t0
	jal	toascii
	sb	$v0, 0($s3)
	addiu	$s3, $s3, 1
while_itoa:
	bgt	$s0, 0, do
	sb	$0, 0($s3)
	move	$a0, $s2
	jal	strrev
	move	$v0, $s2
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	addiu	$sp, $sp, 20
	jr	$ra
#===========================================================
toascii:
	addi	$v0, $a0, '0'
if_toascii:
	ble	$v0, '9', endif_toascii
	addi	$v0, $v0, 7
endif_toascii:
	jr	$ra
#============================================================
strrev:					# char *strrev(char *str){
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	move	$s0, $a0
	move	$s1, $a0		# 	p1 = str;
	move	$s2, $a0		# 	p2 = str;
while_strrev:
	lb	$t0, 0($s2)
	beq	$t0, '\0', endwhile_strrev
	addiu	$s2, $s2, 1
	j	while_strrev
endwhile_strrev:
	addiu	$s2, $s2, -1
while_strrev2:
	bge	$s1, $s2, endwhile_strrev2
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange
	addiu	$s1, $s1, 1
	addiu	$s2, $s2, -1	
	j 	while_strrev2
endwhile_strrev2:
	move	$v0, $s0
	lw	$s2, 12($sp)
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 16
	jr	$ra
#=================================================================
exchange:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	sb	$t0, 0($a1)
	sb	$t1, 0($a0)
	jr	$ra
#=========================================================