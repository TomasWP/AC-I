	.data
str1: .asciiz "Introduza 2 numeros\n"
str2: .asciiz "A soma de dois numeros é: "
      .eqv print_string,4
      .eqv read_int,5
      .eqv print_int10,1
      
      .text
      .globl main
main:  la $a0,str1		# $a0 = str1
       ori $v0,$0,print_string	# $v0 = 4
       syscall			# print_string(str1)
       ori $v0,$0,read_int	# $v0 = 5
       syscall			# read_int
       move $t0,$v0		# $t0 = $v0 = read_int()
       ori $v0,$0,read_int	# $v0 = 5
       syscall			# read_int()
       move $t1,$v0		# $t1 = $v0 = read_int()
       la $a0,str2		# $a0 = str2
       ori $v0,$0,print_string	# $v0 = 4
       syscall
       add $t2,$t0,$t1		# $t2 = $t0 + $t1
       move $a0,$t2		# $a0 = $t2
       ori $v0,$0,print_int10	# $v0 = 1
       syscall			# print_string($a0)
       jr $ra