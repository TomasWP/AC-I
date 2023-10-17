# Mapa de registos
# houveTroca:		$t0
# i:			$t1
# aux:			$t2
	.data
	.eqv SIZE, 10
	.eqv TRUE, 1
	.eqv FALSE, 0
	.eqv print_str, 4
	.eqv read_int, 5
str:	.asciiz "\nInsira um numero: "
	.align 2
lista:	.space 40
	.text
	.globl main

main:
	li	$t1, 0
while:
	bge
endwhile: