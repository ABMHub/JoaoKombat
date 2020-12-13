#########################################################################################################################
# a0 = sprite do poder
# a2 = quantidade de frames 
# a3 = alcance máximo
# a4 = altura em colunas
#########################################################################################################################

	addi sp, sp, -4
	jal ra, IDENTIFICA_POSICAO				# a1 = 1 se personagem 1 está olhando pra direita
	
	bgt a1, zero, L_PODER_PARA_DIREITA
	
L_PODER_PARA_ESQUERDA:
	
L_PODER_PARA_DIREITA:
	la t0, CONTADORH2
	lw t0, 0(t0)
	
	la t1, CONTADORH1
	lw t1, 0(t1)
	
	sub t0, t0, t1						# t0 = distância entre os personagens

	mv t1, a3						# t1 = alcance máximo
	
	ble t0, t1, L_DISPARAR
	mv t0, t1						# 
	
L_DISPARAR:	
	# t0 = alcance do projétil
	li t1, 320
	mul t1, t1, a4
	li t0, 17
	mul t1, t1, t0						
	# t1 = canto inferior esquerdo da coluna do poder
	
	la t0, CONTADORH1
	lw t0, 0(t0)
	li t2, 16
	mul t0, t0, t2
	add t1, t1, t0
	
	li t0, 0xFF200604
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	
	bne t0, zero, FRAME1		# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0
	
FRAME0:
	li t0, 0xFF000000
	add t0, t0, t1			# t0 = endereço inicial a ser pintado
	
FRAME1:

	
		
			
				
						
DESLOCAMENTO:	
	# preparação
	la a4, PERSONAGEM1_INICIO
	mv s0, a4			# s0 = endereço da posição inicial do personagem
	lw s1, 0(s0)			# s1 = posição inicial do personagem
	
	# Decisão: frame 0 ou frame 1?
#DESLOCAMENTO:		
	li t0, 0xFF200604
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	bne t0, zero, FRAME1		# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0

FRAME0: # é a frame 0
	#Personagem está na frame 0
	#Apagar na frame 1
	#pintar na frame 1
	#mudar pra 1
	#apagar na frame 0
	#ebreak
	li t0, 0x00100000
	or s1, s1, t0			# s2 = endereço inicial do personagem na frame 1
	
	# Apagar na frame 1
	
	li a7, 0xFF100000		# a7 = inicio da frame 1
	mv a6, s1			# a6 = posição inicial do personagem
	la a4, LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, ALTURA_FRAME_0		# a5 = endereço da altura
	#li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
	#jal ra, IDENTIFICA_POSICAO########################################
	#ebreak
	#pintar na frame 1
	add s2, s1, a3			# desloca s1 a3 pixels
	sw s2, 0(s0)
	mv a6, s2
	# os argumentos são os mesmos da apagar 
	jal ra, PERSONAGEM_V2		# pinta o personagem 
	
	# MUDA DA FRAME 0 PRA FRAME 1
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	# Apagar na frame 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 0
	#mv a6, s1			# a6 = posição inicial do personagem
	li t0, 0xFF0FFFFF
	and a6, t0, s1
	la a4, LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, ALTURA_FRAME_1		# a5 = endereço da altura
	#li a1, -1 			# da esquerda para direita

	jal ra, LIMPAR			# apaga na frame 0
	#jal ra, IDENTIFICA_POSICAO########################################
	# FINALIZAÇÃO
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
############################################################################################
FRAME1: # É a frame 1
	# Personagem está na frame 1
	# Apagar na frame 0
	# pintar na frame 0
	# mudar pra 0
	# apagar na frame 1
	#ebreak
	li t0, 0xFF0FFFFF
	and s1, s1, t0			# s1 = endereço inicial do personagem na frame 0
	
	# APAGAR NA FRAME 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s1			# a6 = posição inicial do personagem
	la a4, LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, ALTURA_FRAME_1		# a5 = endereço da altura
	#li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
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
	#mv a6, s1			# a6 = posição inicial do personagem
	li t0, 0x00100000
	or a6, t0, s1
	la a4, LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, ALTURA_FRAME_0		# a5 = endereço da altura
	#li a1, -1 			# da esquerda para direita
	jal ra, LIMPAR			# apaga na frame 1
	#jal ra, IDENTIFICA_POSICAO########################################
	# Finalização
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FIM_DESLOCAMENTO:
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret
	
	
	
	
	
	
	
	