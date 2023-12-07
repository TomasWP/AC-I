# Mapa de Registos:
# $t0:	len
	.data
	.eqv print_int10, 1
str:	.asciiz	"Arquitetura de Computadores I"
	.text
	.globl main
	
main:					# int main(void){
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str		
	jal	strlen			
	move	$a0, $v0		
	li	$v0, print_int10
	syscall				# 	print_int10(strlen(str)); 
	li	$v0, 0			#	return 0;
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra			# }
	
#===================================================================
	.data
	.text
strlen:					# int strlen(char *s){
	li	$v0, 0			# 	len = 0;
while:
	lb	$t1, 0($a0)
	beq	$t1, '\0', endwhile	# 	while(*s != '0'){
	addi	$v0, $v0, 1		#		len++;
	addiu	$a0, $a0, 1		#		*s++;
	j	while			# 	}
endwhile:
	jr	$ra			# }
#===================================================================