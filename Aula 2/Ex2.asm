	.data
	.eqv	gray,7
	.text
	.globl main
main:	ori $t0,$0,gray		# $t0 = gray
	move $t1,$t0		# $t1 = $t0
	srl $a1,$t1,4		# $a1 = $t1 >> 4
	xor $t1,$t1,$a1 	# $t1 = $t1 ^ $a1
	srl $a2,$t1,2		# $a2 = $t1 >> 2
	xor $t1,$t1,$a2		# $t1 = $t1 ^ $a2
	srl $a3,$t1,1		# $a3 = $t1 >> 1
	xor $t1,$t1,$a3 	# $t1 = $t1 ^ $a3
	move $t2,$t1 		# $t2 = $t1
	jr  $ra			
