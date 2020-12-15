M_FRAME_DANCINHA:	
	addi sp, sp, -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	li a1, 1
	la s0, MENSAGEM_POS
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	# Decisão: frame 0 ou frame 1?
	
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	# se t2 = 0 estamos na frame 0, do contrário, estamos na frame 1 
	li t2, 0xFF200604
	lw t2, 0(t2)	
	
	bne t2, zero, M_FRAME_DANCINHA_1	# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0

M_FRAME_DANCINHA_0:
	li t0, 0x00100000
	or t0, t0, s1
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posição inicial do personagem
	#la a4, LARGURA1			# a4 = endereço da largura
	#la a5, ALTURA1			# a5 = endereço da altura
	
	li a3, 0
	
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
	j M_FIM_DANCINHA

M_FRAME_DANCINHA_1:
	li t0, 0xFF0FFFFF
	and t0, t0, s1 
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posição inicial do personagem
	#la a4, LARGURA1			# a4 = endereço da largura
	#la a5, ALTURA1			# a5 = endereço da altura
	la a4, M_LARGURA_FRAME_1			# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_1			# a5 = endereço da altura
	li a3, 0
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
M_FIM_DANCINHA: 

	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp, sp, 8
	ret
	
	
