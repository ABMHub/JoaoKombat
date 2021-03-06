#############################################################################################
# a0 = sprite a ser pintado
# a2 = quantidade frames
# a3 = deslocamento
#			$$$s0, s1, s2 e s3 s�o alterados$$$
#############################################################################################
DESLOCAMENTO_INICIO: 
	la s0, PERSONAGEM1_INICIO	# Resgata a posi��o inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO

	addi sp, sp, -4
	sw ra, 0(sp)
	
	j DESLOCAMENTO
FRAME_GOLPE_VGA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv a3, zero
	j DESLOCAMENTO
FRAME_DESLOCAMENTO_VGA: #ebreak
	la s0, PERSONAGEM1_INICIO	# Resgata a posi��o inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO

	addi sp, sp, -4
	sw ra, 0(sp)
	
	#la t0, SPRITE_DANCA
	#lw t0, 0(t0)
	#lw a4, 4(t0)
	#lw a5, 0(t0)
	#addi a4, a4, 2
	
	la t0, SubZeroDancando_2
	lw a4, 4(t0)
	lw a5, 0(t0)
	
	#addi a4, a4, 4
	addi a5, a5, 4
	
	li t2, 0xFF200604
	lw t2, 0(t2)			# Muda para a frame 0
	
	#bne t2, zero, FIRST_TIME_2
	#j FIRST_TIME_1
	#
	
DESLOCAMENTO: #ebreak
	#ebreak
	la s0, PERSONAGEM1_INICIO	# Resgata a posi��o inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	# Decis�o: frame 0 ou frame 1?
	
	li t2, 0xFF200604
	lw t2, 0(t2)			# Muda para a frame 0
	
	bne t2, zero, FRAME1		# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0

FRAME0:	# � a frame 0
	#Personagem est� na frame 0
	#Apagar na frame 1
	#pintar na frame 1
	#mudar pra 1
	#apagar na frame 0
	
	#####################BLOCO QUE APAGA NA FRAME 1#####################################
	#ebreak
	la t0, ALTURA1
	lw a4, 0(t0)			# a4 = altura do personagem
	
	la t1, LARGURA1
	lw a5, 0(t1)			# a5 = largura do personagem
FIRST_TIME_1:	
	li t2, 0x00100000
	or s2, s1, t2			# s2 = endere�o inicial do personagem na frame 1
	
	li a6, 0xFF100000		# a6 = inicio da frame 1
	mv a1, s9			# a1 = background
	mv a7, s2			# a7 = personagem 1 inicio
	 
	#la a4, ALTURA_FRAME1
	#lw a4, 0(a4)
	
	#la a5, LARGURA_FRAME1
	#lw a5, 0(a5)
	li a6, 0xFF100000		# a6 = inicio da frame 1
	mv a7, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	#####################BLOCO QUE PINTA NA FRAME 1#####################################
	add s2, s2, a3			# desloca s2 a3 pixels
	sw s2, 0(s0)
	
	addi sp, sp, -12
	sw a4, 0(sp)
	sw a5, 4(sp)
	sw a6, 8(sp)
	
	li a7, 0xFF100000		# a6 = inicio da frame 1
	mv a6, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita			# da esquerda para direita
	
	jal ra, PERSONAGEM_V2		# pinta o personagem 

	lw a4, 0(sp)
	lw a5, 4(sp)
	lw a6, 8(sp)
	addi sp, sp, 12
	
	#ebreak
	
	#####################BLOCO QUE MUDA PARA A FRAME 1##################################
	li t4, 0xFF200604
	li t5, 0x001
	sw t5, 0(t4)			# Muda para a frame 1
	#ebreak
	
	#####################BLOCO QUE APAGA NA FRAME 0#####################################
	li a7, 0xFF000000		# a6 = inicio da frame 0
	# a4 = altura do personagem
	# a5 = largura do personagem
	mv a1, s9			# a1 = background
	li t0, 0xFF0FFFFF
	and a7, s2, t0			# endere�o inicial do personagem na frame 0
t:	sub a7, a7, a3############################################################

	#la a4, ALTURA_FRAME0
	#lw a4, 0(a4)
	
	#la a5, LARGURA_FRAME0
	#lw a5, 0(a5)
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita

	jal ra, LIMPAR			# apaga na frame 0
	#ebreak
	
	########################## FINALIZA��O #############################################
	#sw s2, 0(s0)			# Salva em personagem 1 inicio a posi��o personagem na frame 1
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FRAME1: # � a frame 1
	# Personagem est� na frame 1
	# Apagar na frame 0
	# pintar na frame 0
	# mudar pra 0
	# apagar na frame 1
	
	#####################BLOCO QUE APAGA NA FRAME 0#####################################
	#ebreak
	la t0, ALTURA_FRAME0
	lw a4, 0(t0)			# a4 = altura do personagem
	
	la t1, LARGURA_FRAME0
	lw a5, 0(t1)			# a5 = largura do personagem
FIRST_TIME_2:	
	li t2, 0xFF0FFFFF
	and s2, s1, t2			# s2 = endere�o inicial do personagem na frame 0
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a1, s9			# a1 = background
	
	
	mv a6, s2			# a7 = personagem 1 inicio
	
	#la a4, ALTURA_FRAME0
	#lw a4, 0(a4)
	
	#la a5, LARGURA_FRAME0
	#lw a5, 0(a5)
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita
	
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	#####################BLOCO QUE PINTA NA FRAME 0#####################################
	add s2, s2, a3			# desloca s2 a3 pixels
	sw s2, 0(s0)
	
	addi sp, sp, -12
	sw a4, 0(sp)
	sw a5, 4(sp)
	sw a6, 8(sp)
	
	
	li a7, 0xFF000000		# a6 = inicio da frame 1
	mv a6, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita
	
	jal ra, PERSONAGEM_V2		# pinta o personagem 
	
	lw a4, 0(sp)
	lw a5, 4(sp)
	lw a6, 8(sp)
	addi sp, sp, 12
	#ebreak
	
	#####################BLOCO QUE MUDA PARA A FRAME 0##################################
	li t4, 0xFF200604
	li t5, 0x000
	sw t5, 0(t4)			# Muda para a frame 0
	#ebreak
	
	#####################BLOCO QUE APAGA NA FRAME 1#####################################
	li a7, 0xFF100000		# a6 = inicio da frame 1
	# a4 = altura do personagem
	# a5 = largura do personagem
	mv a1, s9			# a1 = background
	
	li t0, 0x00100000		
	or a7, s2, t0			# a7 = endere�o inicial do personagem na frame1
y:	sub a7, a7, a3###########################

	#la a4, ALTURA_FRAME1
	#lw a4, 0(a4)
	
	#la a5, LARGURA_FRAME1
	#lw a5, 0(a5)

	li a7, 0xFF100000		# a6 = inicio da frame 1
	mv a6, s2			# a6 = posi��o inicial do personagem
	la a4, LARGURA_FRAME0		# a4 = endere�o da largura
	la a5, ALTURA_FRAME0		# a5 = endere�o da altura
	li a1, -1 			# da esquerda para direita

	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	########################## FINALIZA��O #############################################
	#sw s2, 0(s0)			# Salva em personagem 1 inicio a posi��o personagem na frame 1
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FIM_DESLOCAMENTO:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
	
	
	
	
	
	
