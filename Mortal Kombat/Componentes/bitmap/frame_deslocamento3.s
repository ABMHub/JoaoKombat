################################################################################################
# a0 sprite a ser pintado
# a1 = 1 se o personagem está à esquerda e -1 se o personagem está à direita
# a2 quantidade de frames
# s3 deslocamento
# a4 posição inicial do personagem
################################################################################################

FRAME_DESLOCAMENTO_VGA:

	# backup de registradores
	addi sp, sp, -24
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	sw s4, 20(sp)

#DESLOCAMENTO:	
	# preparação
	la s4, FILA_PERSONAGEM_1
	
	lw t0, 4(s4)
	beq t0, zero, FIM_DESLOCAMENTO
	
	lw s0, 12(s4)
	lw s1, 0(s0)			# s1 = posição inicial do personagem
	addi s4, s4, 16			# endereço do primeiro deslocamento
	lw t0, 4(s4)
	lw a1, 8(s4)
	beq t0, zero, FIM_DESLOCAMENTO
	
	
DESLOCAMENTO:		
	# Decisão: frame 0 ou frame 1?
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
	#ebreak
	#pintar na frame 1
	lw s3, 0(s4)
	lw a0, 4(s4)
	lw a1, 8(s4)
	add s2, s1, s3			# desloca s1 s3 pixels
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
	
	# FINALIZAÇÃO
	sw zero, 0(s4)			# zera deslocamento usado 
	sw zero, 4(s4)			# zera sprite usado
	addi s4, s4, 8			# Decrementa a quantidade de Frames a serem pintadas
	lw t0, 4(s4)			# se o sprite a ser printado for 0, encerra
	beq t0, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
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
	
	#PINTAR NA FRAME 0
	lw s3, 0(s4)
	lw a0, 4(s4)
	lw a1, 8(s4)
	add s2, s1, s3			# desloca s1 s3 pixels
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
	
	# Finalização
	sw zero, 0(s4)			# zera deslocamento usado 
	sw zero, 4(s4)			# zera sprite usado
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	lw t0, 4(s4)			# se o sprite a ser printado for 0, encerra
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FIM_DESLOCAMENTO:
	la t0, FILA_PERSONAGEM_1
	sw zero, 0(t0)
	sw zero, 4(t0)
	sw zero, 8(t0)
	sw zero, 12(t0)

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	lw s4, 20(sp)
	addi sp, sp, 24
	
	ret
