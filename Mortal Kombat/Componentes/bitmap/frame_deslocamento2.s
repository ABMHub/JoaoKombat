#############################################################################################
# a0 = sprite a ser pintado
# a2 = quantidade frames
# a3 = deslocamento
#			$$$s0, s1, s2 e s3 são alterados$$$
#############################################################################################

FRAME_GOLPE_VGA:
	mv a3, zero

FRAME_DESLOCAMENTO_VGA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t0, SPRITE_DANCA
	lw t0, 0(t0)
	lw a4, 4(t0)
	lw a5, 0(t0)
	addi a4, a4, 2
	
	li t2, 0xFF200604
	lw t2, 0(t2)			# Muda para a frame 0
	
	bne t2, zero, FIRST_TIME_2
	j FIRST_TIME_1
	
	
DESLOCAMENTO:
	#ebreak
	la s0, PERSONAGEM1_INICIO	# Resgata a posição inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	# Decisão: frame 0 ou frame 1?
	   
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	li t2, 0xFF200604
	lw t2, 0(t2)			# Muda para a frame 0
	
	bne t2, zero, FRAME1		# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0

FRAME0:	# é a frame 0
	#Personagem está na frame 0
	#Apagar na frame 1
	#pintar na frame 1
	#mudar pra 1
	#apagar na frame 0
	
	#####################BLOCO QUE APAGA NA FRAME 1#####################################
	la t0, ALTURA1
	lw a4, 0(t0)			# a4 = altura do personagem
	
	la t1, LARGURA1
	lw a5, 0(t1)			# a5 = largura do personagem
FIRST_TIME_1:	
	li t2, 0x00100000
	or s2, s1, t2			# s2 = endereço inicial do personagem na frame 1
	
	li a6, 0xFF100000		# a6 = inicio da frame 1
	mv a1, s9			# a1 = background
	mv a7, s2			# a7 = personagem 1 inicio 
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	#####################BLOCO QUE PINTA NA FRAME 1#####################################
	add s2, s2, a3			# desloca s2 a3 pixels
	sw s2, 0(s0)
	jal ra, PERSONAGEM		# pinta o personagem 
	#ebreak
	
	#####################BLOCO QUE MUDA PARA A FRAME 1##################################
	li t4, 0xFF200604
	li t5, 0x001
	sw t5, 0(t4)			# Muda para a frame 1
	#ebreak
	
	#####################BLOCO QUE APAGA NA FRAME 0#####################################
	li a6, 0xFF000000		# a6 = inicio da frame 0
	# a4 = altura do personagem
	# a5 = largura do personagem
	mv a1, s9			# a1 = background
	li t0, 0xFF0FFFFF
	and a7, s2, t0			# endereço inicial do personagem na frame 0
t:	sub a7, a7, a3############################################################
	jal ra, LIMPAR			# apaga na frame 0
	#ebreak
	
	########################## FINALIZAÇÃO #############################################
	#sw s2, 0(s0)			# Salva em personagem 1 inicio a posição personagem na frame 1
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FRAME1: # É a frame 1
	# Personagem está na frame 1
	# Apagar na frame 0
	# pintar na frame 0
	# mudar pra 0
	# apagar na frame 1
	
	#####################BLOCO QUE APAGA NA FRAME 0#####################################
	la t0, ALTURA1
	lw a4, 0(t0)			# a4 = altura do personagem
	
	la t1, LARGURA1
	lw a5, 0(t1)			# a5 = largura do personagem
FIRST_TIME_2:	
	li t2, 0xFF0FFFFF
	and s2, s1, t2			# s2 = endereço inicial do personagem na frame 0
	
	li a6, 0xFF000000		# a6 = inicio da frame 1
	mv a1, s9			# a1 = background
	
	
	mv a7, s2			# a7 = personagem 1 inicio
	
	
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	#####################BLOCO QUE PINTA NA FRAME 0#####################################
	add s2, s2, a3			# desloca s2 a3 pixels
	sw s2, 0(s0)
	jal ra, PERSONAGEM		# pinta o personagem 
	#ebreak
	
	#####################BLOCO QUE MUDA PARA A FRAME 0##################################
	li t4, 0xFF200604
	li t5, 0x000
	sw t5, 0(t4)			# Muda para a frame 0
	#ebreak
	
	#####################BLOCO QUE APAGA NA FRAME 1#####################################
	li a6, 0xFF100000		# a6 = inicio da frame 1
	# a4 = altura do personagem
	# a5 = largura do personagem
	mv a1, s9			# a1 = background
	
	li t0, 0x00100000		
	or a7, s2, t0			# a7 = endereço inicial do personagem na frame1
y:	sub a7, a7, a3###########################
	jal ra, LIMPAR			# apaga na frame 1
	#ebreak
	
	########################## FINALIZAÇÃO #############################################
	#sw s2, 0(s0)			# Salva em personagem 1 inicio a posição personagem na frame 1
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FIM_DESLOCAMENTO:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
	
	
	
	
	
	
