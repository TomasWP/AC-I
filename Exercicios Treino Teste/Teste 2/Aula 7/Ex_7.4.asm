	.data
	.eqv	print_string, 4
str1:	.asciiz "Arquitetura de "
str2:	.space	50
str3:	.asciiz "\n"
str4:	.asciiz "Computadores I"
	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str2
	la	$a1, str1
	jal	strcpy
	move	$a0, $v0
	li	$v0, print_string
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	la	$a0, str2
	la	$a1, str4
	jal	strcat
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li	$v0, 0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
#=====================================================
strcat:
	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	move	$s0, $a0
while_strcat:
	lb	$t0, 0($a0)
	beq	$t0, '\0', endwhile_strcat
	addiu	$a0, $a0, 1
	j	while_strcat
endwhile_strcat:
	jal	strcpy
	move	$v0, $s0	
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addiu	$sp, $sp, -8
	jr	$ra
#========================================================
strcpy:
	move	$t0, $a0
do_strcpy:
	lb	$t1, 0($a1)
	sb	$t1, 0($a0)
while_strcpy:
	addiu	$a0, $a0, 1
	addiu	$a1, $a1, 1
	beq	$t1, '\0', endwhile_strcpy
	j	do_strcpy
endwhile_strcpy:
	move	$v0, $t0
	jr	$ra
#========================================================