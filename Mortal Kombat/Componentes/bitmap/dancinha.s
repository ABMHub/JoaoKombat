FRAME_DANCINHA:	
	addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)

	la s0, PERSONAGEM1_INICIO
	#la s0, PERSONAGEM1_INICIO
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	# Decisão: frame 0 ou frame 1?
	
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	# se t2 = 0 estamos na frame 0, do contrário, estamos na frame 1 
	li t2, 0xFF200604
	lw t2, 0(t2)	
	
	bne t2, zero, FRAME_DANCINHA_1	# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0

FRAME_DANCINHA_0:
	li t0, 0x00100000
	or t0, t0, s1
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posição inicial do personagem
	#la a4, LARGURA1			# a4 = endereço da largura
	#la a5, ALTURA1			# a5 = endereço da altura
	la a4, LARGURA_FRAME_0			# a4 = endereço da largura
	la a5, ALTURA_FRAME_0
	jal ra, IDENTIFICA_POSICAO
	li a3, 0
	
	
	
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
	j FIM_DANCINHA

FRAME_DANCINHA_1:
	li t0, 0xFF0FFFFF
	and t0, t0, s1 
	sw t0, 0(s0)
	
	mv a6, t0			# a6 = posição inicial do personagem
	#la a4, LARGURA1			# a4 = endereço da largura
	#la a5, ALTURA1			# a5 = endereço da altura
	la a4, LARGURA_FRAME_1			# a4 = endereço da largura
	la a5, ALTURA_FRAME_1			# a5 = endereço da altura
	jal ra, IDENTIFICA_POSICAO
	li a3, 0
	jal ra, PERSONAGEM_V2
	sw s1, 0(s0)
	
FIM_DANCINHA: 

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	ret
