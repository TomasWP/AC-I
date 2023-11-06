		.data
		.eqv	print_int10, 1
str:		.asciiz "Arquitetura de Computadores I"
		.text
		.globl main
main:						# int main(void){	
	addiu	$sp, $sp, -4			#
	sw	$ra, 0($sp)			#	prólogo
	la	$a0, str			#
	jal	strlen				#
	move	$a0, $v0			#
	li	$v0, print_int10		#
	syscall					#	print_int10(strlen(str));
	li	$v0, 0
	lw	$ra, 0($sp)			#	epilogo
	addiu	$sp, $sp, 4			#
	jr	$ra				#

#----------------------------------------------------------------------------------
#Devolve o nº de caracteres de uma string
# Mapa de registos
# len:		$v0
# *s:		$a0
		.data
		.text
strlen:						# int strlen(char *s){
	li	$v0, 0				# 	len = 0;
strlen_while:					#
	lb	$t0, 0($a0)			#
	beq	$t0, '\0', strlen_endwhile	# 	while(*s++ != '\0'){
	addi	$v0, $v0, 1			# 		len++;
	addiu	$a0, $a0, 1			#
	j	strlen_while			#
strlen_endwhile:				# 	}
	jr	$ra				# 	return len;
						# }
#---------------------------------------------------------------------------------------	