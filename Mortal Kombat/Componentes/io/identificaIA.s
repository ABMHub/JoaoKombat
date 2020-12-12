########################################################################################################################
# Input:
# a2 = 1 se player 1, 2 se player 2
#####################################
# Ouput:
# a1 retorna 1 se o personagem 1 est� a esquerda e -1 se est� a direita
########################################################################################################################
IDENTIFICA_POSICAO_IA:
	la t0, CONTADORH1
	lw t0, 0(t0)
	la t1, CONTADORH2
	lw t1, 0(t1)
	
	slt a1, t1, t0
	bne a1, zero, FIM_IDENTIFICA_POSICAO_IA
	li a1, -1		
FIM_IDENTIFICA_POSICAO_IA:
	ret
