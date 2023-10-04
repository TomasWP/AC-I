# i -> $t0; bit -> $t1; value -> $t2
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv read_int, 5
	.text
	.globl main
main:						# void main(){
	li	$v0, print_string
	la	$a0, str1			
	syscall					#	print_str(str1);
	li	$v0, read_int			
	syscall					
	move	$t2, $v0			#	value = read_int();
	li	$v0, print_string		
	la	$a0, str2
	syscall					#	print_str(str2);
while:
	bge	$t0, 32, endw			#	while (i < 32){
if:
	rem	$t4, $t0, 4
	bne	$t4, $0, endif			#		if ((i % 4) == 0){
	li	$v0, print_char
	li	$a0, ' '
	syscall					#			print_char(' ');
	j	endif
endif:
	li	$t3, 0x80000000
	and	$t1, $t2, $t3					
	srl	$t1, $t1, 31			#		bit = (value & 0x80000000) >> 31;	
	addi	$t5, $t1, 0x30
	move	$a0, $t5
	li 	$v0, print_char
	syscall					#		print_char('0' + bit);	
	sll	$t2, $t2, 1			#		value = value << 1;
	addi	$t0, $t0, 1			#		i++;
	j	while				#	}
endw:	
	jr	$ra				# }