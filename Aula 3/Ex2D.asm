# i -> $t0; bit -> $t1; value -> $t2; flag -> $t5;
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
str3:	.asciiz "."
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
do:						#	do{
	srl	$t1, $t2, 31			#		bit = value >> 31;
if:						#		if (flag == 1 || bit !=0){
	beq	$t5, 1, then
	beq	$t1, 0 , endif
then:
	li	$t5, 1				#			flag = 1;
if2:
	rem	$t4, $t0, 4
	bne	$t4, $0, endif2			#			if ((i % 4) == 0){
	li	$v0, print_char
	li	$a0, ' '
	syscall					#				print_char(' ');
	j	endif2
endif2:						#			}				
	addi	$t3, $t1, 0x30
	move	$a0, $t3
	li 	$v0, print_char
	syscall					#			print_char(0x30 + bit);
	j	endif	
endif:						#		}
	sll	$t2, $t2, 1			#		value = value << 1;
	addi	$t0, $t0, 1			#		i++;
	j	while				#	
while:	
	blt 	$t0, 32, do			#	}while (i < 32)
	jr	$ra				# }