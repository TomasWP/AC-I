#--------------------------------------------------------------------

exchange:					# void exchange(char *c1, char *c2){
	lb	$t0, 0($a0)			# 	aux = *c1;
	lb	$t1, 0($a1)			#	aux1 = *c2;
	sb	$t1, 0($a0)			#	*c1 = *aux1;
	sb	$t0, 0($a1)			#	*c2 = aux;		
#--------------------------------------------------------------------