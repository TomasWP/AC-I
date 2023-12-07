# Mapa de Registos:
# $s0:	exit_value	
	.data
	.eqv	STR_MAX_SIZE, 30
	.eqv	print_string, 4
	.eqv	print_int10, 1
str1:	.asciiz	"I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "
	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	jal	strlen	
if:
	bgt	$v0, STR_MAX_SIZE, else
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
	jal	strrev
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li	$s0, 0
	j	endif
else:
	la	$a0, str4
	li	$v0 print_string
	syscall
	la	$a0, str1
	jal	strlen
	move	$a0, $v0
	li	$v0, print_int10
	syscall
	li	$s0, -1
endif:
	move	$v0, $s0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
#===================================================================
strlen:					# int strlen(char *s){
	li	$v0, 0			# 	len = 0;
while_strlen:
	lb	$t1, 0($a0)
	beq	$t1, '\0', endwhile_strlen	# 	while(*s != '0'){
	addi	$v0, $v0, 1		#		len++;
	addiu	$a0, $a0, 1		#		*s++;
	j	while_strlen			# 	}
endwhile_strlen:
	jr	$ra			# }
#========================================================
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