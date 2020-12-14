# A4 = PONTEIRO DA POSI��O INICIAL DO PERSONAGEM

P_PODER:
	# backup de registradores
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)

	# prepara��o
	#la a4, PERSONAGEM1_INICIO
	mv s0, a4			# s0 = endere�o da posi��o inicial do personagem
	lw s1, 0(s0)			# s1 = posi��o inicial do personagem
	
	li t1, -19200
	add s1, s1, t1
	add s1, s1, a5
	
	
	la s0, P_PODER_INICIO
	
	sw s1, 0(s0)
P_DESLOCAMENTO:		
	# Decis�o: frame 0 ou frame 1?
	
	li t0, 0xFF200604
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	bne t0, zero, P_FRAME1		# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0

P_FRAME0: # � a frame 0
	#Personagem est� na frame 0
	#Apagar na frame 1
	#pintar na frame 1
	#mudar pra 1
	#apagar na frame 0
	#ebreak
	li t0, 0x00100000
	or s1, s1, t0			# s2 = endere�o inicial do personagem na frame 1
	
	# Apagar na frame 1
	
	li a7, 0xFF100000		# a7 = inicio da frame 1
	mv a6, s1			# a6 = posi��o inicial do personagem
	la a4, P_LARGURA_FRAME_0		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_0		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	
	#jal ra, LIMPAR			# apaga na frame 1
	#jal ra, IDENTIFICA_POSICAO########################################
	#ebreak
	#pintar na frame 1
	add s2, s1, a3			# desloca s1 a3 pixels
	sw s2, 0(s0)
	mv a6, s2
	# os argumentos s�o os mesmos da apagar 
	jal ra, PERSONAGEM_V2		# pinta o personagem 
	
	# MUDA DA FRAME 0 PRA FRAME 1
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	# Apagar na frame 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 0
	#mv a6, s1			# a6 = posi��o inicial do personagem
	li t0, 0xFF0FFFFF
	and a6, t0, s1
	la a4, P_LARGURA_FRAME_1		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_1		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita

	jal ra, LIMPAR			# apaga na frame 0
	#jal ra, IDENTIFICA_POSICAO########################################
	# FINALIZA��O
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, P_FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j P_DESLOCAMENTO			# ainda faltam frames a serem pintados
	
############################################################################################
P_FRAME1: # � a frame 1
	# Personagem est� na frame 1
	# Apagar na frame 0
	# pintar na frame 0
	# mudar pra 0
	# apagar na frame 1
	#ebreak
	li t0, 0xFF0FFFFF
	and s1, s1, t0			# s1 = endere�o inicial do personagem na frame 0
	
	# APAGAR NA FRAME 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s1			# a6 = posi��o inicial do personagem
	la a4, P_LARGURA_FRAME_1		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_1		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	
	#jal ra, LIMPAR			# apaga na frame 1
	#jal ra, IDENTIFICA_POSICAO########################################
	#PINTAR NA FRAME 0
	
	add s2, s1, a3			# desloca s1 a3 pixels
	sw s2, 0(s0)
	mv a6, s2
	
	jal ra, PERSONAGEM_V2		# pinta o personagem
	
	# Mudar pra frame 0
	li t0, 0xFF200604
	li t1, 0x000
	sw t1, 0(t0)			# Muda para a frame 0
	
	# Apagar na frame 1
	li a7, 0xFF100000		# a6 = inicio da frame 1
	#mv a6, s1			# a6 = posi��o inicial do personagem
	li t0, 0x00100000
	or a6, t0, s1
	la a4, P_LARGURA_FRAME_0		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_0		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	jal ra, LIMPAR			# apaga na frame 1
	#jal ra, IDENTIFICA_POSICAO########################################
	# Finaliza��o
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, P_FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j P_DESLOCAMENTO			# ainda faltam frames a serem pintados
	
P_FIM_DESLOCAMENTO:

	li t0, 0xFF200604
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	bne t0, zero, AP_FRAME1		# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0

	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s1			# a6 = posi��o inicial do personagem
	lw a6, 0(s0)
	la a4, P_LARGURA_FRAME_1		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_1		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
	
	j AP_FIM

AP_FRAME1:
	li a7, 0xFF100000		# a6 = inicio da frame 1
	mv a6, s1			# a6 = posi��o inicial do personagem
	lw a6, 0(s0)
	la a4, P_LARGURA_FRAME_0		# a4 = endere�o da largura
	la a5, P_ALTURA_FRAME_0		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
	
AP_FIM:
	mv t0, a0
	mv t1, a7
	li a7, 32
	li a0 100
	ecall
	mv a0, t0
	mv a7, t1

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret
	
	
	
	
	
	
	
	
