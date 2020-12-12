########################################################################################################################
# a1 retorna 1 se o personagem 1 está a esquerda e -1 se está a direita
########################################################################################################################
IDENTIFICA_POSICAO:
	la t0, CONTADORH1
	lw t0, 0(t0)
	la t1, CONTADORH2
	lw t1, 0(t1)
	
	slt a1, t0, t1
	bne a1, zero, FIM_IDENTIFICA_POSICAO
	li a1, -1		
FIM_IDENTIFICA_POSICAO:
	ret