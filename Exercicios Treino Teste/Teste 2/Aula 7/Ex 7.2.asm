#===============================================================
# Mapa de Registos:
# $s1:	p1
# $s2:	p2
# $t0:  *p1
# $t1:	*p2
	.data
	.eqv	print_str, 4
str:	.asciiz	"ITED - orievA ed edadisrevinU"
	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str
	jal	strrev
	move	$a0, $v0
	li	$v0, print_str
	syscall
	li	$v0, 0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
strrev:					# char *strrev(char *str){
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	move	$s0, $a0
	move	$s1, $a0		# 	p1 = str;
	move	$s2, $a0		# 	p2 = str;
while:
	lb	$t0, 0($s2)
	beq	$t0, '\0', endwhile
	addiu	$s2, $s2, 1
	j	while
endwhile:
	addiu	$s2, $s2, -1
while2:
	bge	$s1, $s2, endwhile2
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange
	addiu	$s1, $s1, 1
	addiu	$s2, $s2, -1	
	j 	while2
endwhile2:
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
	