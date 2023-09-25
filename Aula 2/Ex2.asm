	.data
	.eqv	Imm,1
	.text
	.globl main
main:	li $t0,0x12345678	# $t0 = 0x12345678
	sll $t2,$t0,Imm		# $t2 = $t0 << 1
	srl $t3,$t0,Imm		# $t3 = $t0 >> 1
	sra $t4,$t0,Imm		# $t4 = $t0 \ (2^1)
	jr  $ra			