	.data
str1: .asciiz "Uma string qualquer"
str2: .asciiz "AC1 - P"
      .eqv    print_string,4

	.text
	.globl main
main:	la $a0,str2		# $a0 = "Uma string qualquer"
				# instruc�o virtual, composta pelo
				# assembler em 2 instru��es nativas
	ori $v0,$0,print_string	# $v0 = 4
	syscall			# print_string(str2);
	jr $ra