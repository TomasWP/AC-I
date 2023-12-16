# Mapa da Registos
# argc:	$s0
# argv:	$s1
# i:	$t1
# p:	$t0
	.data
	.eqv	print_float, 2
	.eqv	print_string, 4
	.eqv	SIZE, 20
str1:	.asciiz	"Invalid argc"
	.align	2
fla:	.space	80
	.text
	.globl print

print:
	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	move	$s0, $a0		# $s0 = argc
	la	$s1, fla		# $s1 = &fla 
	move	$t0, $s1		# *p = fla
	li	$t1, 0			# i = 0;
if:
	ble	$s0, 1, else
	bgt	$s0, SIZE, else
while:
	bge	$t1, $s0, endwhile
	addu	$t2, $a1, $t1
	lb	$t3, 0($t2)		# # $t4 = char argv
	move	$a0, $t3
	li	$a1, 10
	jal	tof			# tof(argv[i],10)

	s.s	$f0, 0($t0)
	addi	$t1, $t1, 1
	addiu	$t0, $t0, 4
	j	while
endwhile:
	move	$a0, $s1
	move	$a1, $s0
	jal	aver
	mov.s	$f12, $f0
	li	$v0, print_float	# print_float(aver(fla,argc)
	syscall
	j	endif
else:
	la	$a0, str1
	li	$v0, print_string
	syscall
endif:
	mtc1	$s1, $f0
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 12
	jr	$ra