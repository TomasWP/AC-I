	.data
	.text
	.globl main
main:	ori $t0,$0,0xE543	# $t0 = 0x0614
	xori $t1,$t0,0x0000FFFF	# $t1 = $t0 ^ 0x0000FFFF ----> mascara aplicada para negar cada bit