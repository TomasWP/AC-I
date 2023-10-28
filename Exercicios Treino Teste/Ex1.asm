# Mapa de registos
# t0:		gray
# t1:		bin
# t2:		mask
	.data
	.eqv read_int, 5
	.eqv print_int16, 34
	.eqv print_str, 4
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nValor em código Gray: "
str3:	.asciiz "\nValor em binario: "
	.text
	.globl main
	
main:
	li $v0, print_str		#
	la $a0, str1			#
	syscall				# print_string("Intorduza um numero: ");
	li $v0, read_int		#
	syscall				#
	move $t0, $v0			# gray = read_int();
	srl $t2, $t0, 1			# mask = gray >> 1;
	move $t1, $t0			# bin = gray;
while:					#
	beq $t2, $0, endwhile		# while(mask != 0){
	xor $t1, $t1, $t2		# 	bin = bin ^ mask;
	srl $t2, $t2, 1			# 	mask = mask >> 1;
	j	while			#
endwhile:				# }	
	li $v0, print_str		#
	la $a0, str2			#
	syscall				# print_string("\nValor em código Gray: ");
	li $v0, print_int16			#
	move $a0, $t0			#
	syscall				# print_int16(gray);
	li $v0, print_str		#
	la $a0, str3			#
	syscall				# print_string("\nValor em binario: ");
	li $v0, print_int16			#
	move $a0, $t1			#
	syscall				# print_int16(bin);
	jr	$ra			# 