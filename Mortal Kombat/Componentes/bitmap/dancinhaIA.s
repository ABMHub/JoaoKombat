FRAME_DANCINHA_IA:	

	addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)

	la s0, PERSONAGEM2
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
		
	# Decis�o: frame 0 ou frame 1?
	
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	# se t2 = 0 estamos na frame 0, do contr�rio, estamos na frame 1 
	li t2, 0xFF200604
	lw t2, 0(t2)	
	
	bne t2, zero, FRAME_DANCINHA_1_IA	# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0

FRAME_DANCINHA_0_IA:
	li t0, 0x00100000
	or t0, t0, s1
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posi��o inicial do personagem
	#la a4, LARGURA1			# a4 = endere�o da largura
	#la a5, ALTURA1			# a5 = endere�o da altura
	la a4, LARGURA_FRAME_0_IA			# a4 = endere�o da largura
	la a5, ALTURA_FRAME_0_IA
	jal ra, IDENTIFICA_POSICAO_IA
	li a3, 0
	
	
	
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
	j FIM_DANCINHA_IA

FRAME_DANCINHA_1_IA:
	li t0, 0xFF0FFFFF
	and t0, t0, s1 
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posi��o inicial do personagem
	#la a4, LARGURA1			# a4 = endere�o da largura
	#la a5, ALTURA1			# a5 = endere�o da altura
	la a4, LARGURA_FRAME_1_IA			# a4 = endere�o da largura
	la a5, ALTURA_FRAME_1_IA			# a5 = endere�o da altura
	jal ra, IDENTIFICA_POSICAO_IA
	li a3, 0
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
FIM_DANCINHA_IA: 

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	ret
