################################################################################################
# a0 sprite a ser pintado
# a1 = 1 se o personagem est� � esquerda e -1 se o personagem est� � direita
# a2 quantidade de frames
# s3 deslocamento
# a4 posi��o inicial do personagem
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
	# prepara��o
	la s4, FILA_PERSONAGEM_1	# s4 � o endere�o da fila
	
	lw t0, 4(s4)			# t0 � a quantidade de frames
	beq t0, zero, FIM_DESLOCAMENTO	# se t0 for zero n�o h� frames a serem printados
	
	lw s0, 12(s4)			# s0 � o endere�o da label PERSONAGEM1
	lw a1, 8(s4)			# a1 � a direcao (1 se for pra direita, -1 se for pra esquerda)
	#lw s1, 0(s0)			# s1 = posi��o inicial do personagem
	addi s4, s4, 16			# endere�o do primeiro deslocamento
	lw t0, 4(s4)			# t0 � o endere�o do primeiro sprite
	beq t0, zero, FIM_DESLOCAMENTO	# se o endere�o � 0, a fila est� vazia (encerra o programa)
	
	
DESLOCAMENTO:		
	# Decis�o: frame 0 ou frame 1?
	lw s1, 0(s0)			# s1 = posi��o inicial do personagem
	li t0, 0xFF200604		# li para verificar qual frame estamos
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	bne t0, zero, FRAME1		# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0
	
FRAME0: # � a frame 0
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
	la a4, LARGURA_FRAME_0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME_0		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	
	#ebreak
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	#pintar na frame 1
	lw s3, 0(s4)			# s3 � o deslocamento
	lw a0, 4(s4)			# a0 � o endere�o do primeiro sprite
	add s2, s1, s3			# s2 � o endere�o do personagem deslocado
	sw s2, 0(s0)			# salva esse endere�o em PERSONAGEM1
	mv a6, s2			# mandando a6 para a fun��o PERSONAGEM_V2
	# os argumentos s�o os mesmos da apagar 
	#ebreak
	jal ra, PERSONAGEM_V2		# pinta o personagem 
	
	# MUDA DA FRAME 0 PRA FRAME 1
	li t0, 0xFF200604		#
	li t1, 0x001			#
	sw t1, 0(t0)			# Muda para a frame 1
	
	# Apagar na frame 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 0
	#mv a6, s1			# a6 = posi��o inicial do personagem
	li t0, 0xFF0FFFFF
	and a6, t0, s1
	la a4, LARGURA_FRAME_1		# a4 = endere�o da largura
	la a5, ALTURA_FRAME_1		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita

	jal ra, LIMPAR			# apaga na frame 0
	
	# FINALIZA��O
	sw zero, 0(s4)			# zera deslocamento usado 
	sw zero, 4(s4)			# zera sprite usado
	addi s4, s4, 8			# Decrementa a quantidade de Frames a serem pintadas
	lw t0, 4(s4)			# se o sprite a ser printado for 0, encerra
	beq t0, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
############################################################################################
FRAME1: # � a frame 1
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
	la a4, LARGURA_FRAME_1		# a4 = endere�o da largura
	la a5, ALTURA_FRAME_1		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	#ebreak
	jal ra, LIMPAR			# apaga na frame 1
	
	#PINTAR NA FRAME 0
	lw s3, 0(s4)
	lw a0, 4(s4)
	add s2, s1, s3			# desloca s1 s3 pixels
	sw s2, 0(s0)
	mv a6, s2
	
	#ebreak
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
	la a4, LARGURA_FRAME_0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME_0		# a5 = endere�o da altura
	#li a1, -1 			# da esquerda para direita
	jal ra, LIMPAR			# apaga na frame 1
	
	# Finaliza��o
	sw zero, 0(s4)			# zera deslocamento usado 
	sw zero, 4(s4)			# zera sprite usado
	addi s4, s4, 8			# Decrementa a quantidade de Frames a serem pintadas
	lw t0, 4(s4)			# se o sprite a ser printado for 0, encerra
	beq t0, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
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
