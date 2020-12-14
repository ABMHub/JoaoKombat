####################################################################
# Função para uso interno. Retorna em a0 o endereço do canto       #
# inferior esquerdo do personagem na matriz de combate             #
####### Input ########                                             #
# a0 = jogador (1 ou 2)         				   #
####### Output #######						   #
# a0 = endereço do index inferior esquerdo do personagem na matriz #
# a1 = CONTADORH                 				   #
####################################################################

CALCULA_CONTADOR:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t0, 2
	beq t0, a0, CONTADOR_J2	# beq para carregar pos do jogador 1 ou 2
	
CONTADOR_J1: # Carrega posição do jogador 1
	lw t0, CONTADORV1
	lw t1, CONTADORH1
	j POS_BEQ_CONTADOR
	
CONTADOR_J2: # Carrega posição do jogador 2
	lw t0, CONTADORV2
	lw t1, CONTADORH2
	
POS_BEQ_CONTADOR:
	mv a1, t1		# a1 = CONTADORH do personagem escolhido
	li t2, 20		# 20 == largura
	mul t0, t0, t2		# medição vertical * 20 para percorrer verticalmente a matriz
	add t0, t0, t1		# t0 é o index inferior esquerdo da hitbox
	
	mv t1, a0		# carrega numero do jogador para escrever na matriz
	la t2, MATRIZ_COMBATE	# carrega endereço da matriz de combate
	add a0, t2, t0		# t0 é agora o canto inferior esquerdo da hitbox
	
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# volta

########## ZERA MATRIZ #########################
# Funcao de zerar a matriz de combate          #
# Chame ela antes de atualizar a matriz, para  #
# evitar problemas de duplicacao de personagem #
# ##					       #
# Nao precisa de parametros		       #
################################################

ZERA_MATRIZ:
	addi sp, sp, -12
	sw t0, 0(sp)
	sw t1, 4(sp)
	sw t2, 8(sp)

	la t2, MATRIZ_COMBATE
	li t1, 0
	li t0, 300
	
LOOP_ZERA_MATRIZ:
	sw zero, 0(t2)
	addi t1, t1, 4
	addi t2, t2, 4
	bne t0, t1, LOOP_ZERA_MATRIZ
	
	lw t0, 0(sp)
	lw t1, 4(sp)
	lw t2, 8(sp)
	addi sp, sp, 12
	
	ret
	
####################################################################
# Função de escrever na matriz de combate a posição do personagem  #
####### Inputs ########                                            #
# a0 = jogador (1 ou 2)                                            #
# a1 = altura (em blocos da matriz)                                #
# a2 = largura (em blocos da matriz)                               #
####################################################################
	
ESCREVE_POSICAO_MATRIZ:
	addi sp, sp, -4		# clássico backup do ra
	sw ra, 0(sp)		#

	mv t1, a0		# t1 é o jogador (1 ou 2)
	mv t3, a1		# reg t3 vira temporário para altura do personagem
	jal ra, CALCULA_CONTADOR # agora a0 = endereço do canto inferior esquerdo do personagem x na matriz
	mv a1, t3		# a1 é a altura do personagem em relação a matriz
	mv t0, a0		# t0 é o endereço do canto inferior esquerdo do personagem x na matriz

	li t2, 0		# contador de loop interno
	li t3, 0		# contador de loop externo
			
LOOP_CONTADOR:
	sb t1, 0(t0)		# salva n do jogador na posição da matriz
	addi t2, t2, 1		# aumenta contador
	addi t0, t0, 1		# itera horizontalmente
	bne t2, a2, LOOP_CONTADOR	# continua o loop caso precise
	
	# caso o loop interno (loop horizontal) acabe
	sub t0, t0, t2		# volta pro começo horizontalmente
	li t2, 0		# reseta contador interno
	addi t3, t3, 1		# aumenta contador externo
	addi t0, t0, -20	# sobe uma posição verticalmente
	bne t3, a1, LOOP_CONTADOR 	# continua loop caso precise
	
	# caso loop externo (loop vertical) acabe
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# tchauzinho
	
############################################################
# Função de testar soco					###
####### Input ########					##
# s8 = jogador (1 ou 2)              ?			###
# a1 = tipo de golpe					####
# 	0 - soco		4 - soco agachado	###
#	1 - jab			5 - alpiste		##
#	2 - chute baixo		6 - chute agachado	###
#	3 - chute alto		7 - rasteira		####
#							###
#	8 - poder					##
#########################################################
TESTE_GOLPE:
	addi sp, sp, -24	# faz backup em ra e nos registradores a's
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	sw s7, 16(sp)
	sw s0, 20(sp)
	
	mv t3, a1		# temp: t3 é tipo de golpe
	jal ra, CALCULA_CONTADOR 
	
	mv t0, a0		# t0 é endereço do index inferior esquerdo do personagem na matriz
	mv a1, t3		# a1 é o tipo de golpe
	
	lw t1, CONTADORH1	# t1 é o contador horizontal do player 1
	lw t2, CONTADORH2	# t2 é o contador horizontal do player 1
	
	sub t3, t1, t2		# 
	sub t4, t2, t1		#
	li t5, 4		# faz os testes para se 'a distancia entre os personagens for menor que t5'
	slt t3, t3, t5		#
	slt t4, t4, t5		#
	and t6, t3, t4		# t6 eh 1 se a distancia entre os pesonagens for menor que 3
	
	li t3, 2		# t3 é 2 para teste de player
	mv a0, s8
	beq t3, a0, TESTE_PER2	# se for player 2, branch
	
	sub t1, t1, t2		# t1 é negativo se o player 1 estiver na esquerda
	bgtz t1, TESTE_INVERTIDO # pula para teste invertido se player 1 estiver na direita
	j TESTE_NORMAL		# caso esteja na esquerda, faz teste normal
	
TESTE_PER2:
	sub t1, t2, t1		# t1 é negativo se o player 2 estiver na esquerda
	bgtz t1, TESTE_INVERTIDO # pula para teste invertido se player 1 estiver na direita
				# caso esteja na esquerda, faz teste normal
TESTE_NORMAL:
	addi t0, t0, 1		# vai para o canto inferior direito do personagem na matriz
	li t2, 1		# indica a direção do teste. os testes serão feitos para a direita
	j TESTE_CASE		# pula para o switch case de golpe
	
TESTE_INVERTIDO:
	li t2, -1		# indica a direção do teste. os testes serão feitos para a equerda
	
TESTE_CASE:

	li t1, 0		
	beq t1, a1, TESTE_SOCO	
	
	li t1, 1
	beq t1, a1, TESTE_JAB
	
	li t1, 2
	beq t1, a1, TESTE_CHUTE_BAIXO
	
	li t1, 3
	beq t1, a1, TESTE_CHUTE_ALTO
	
	li t1, 4		
	beq t1, a1, TESTE_SOCO_AGACHADO
	
	li t1, 5
	beq t1, a1, TESTE_ALPISTE
	
	li t1, 6
	beq t1, a1, TESTE_CHUTE_AGACHADO
	
	li t1, 7
	beq t1, a1, TESTE_RASTEIRA
	
	li t1, 8
	beq t1, a1, TESTE_PODER
	
######## SOCO NORMAL # 5 hp ##########
#  PLAYER  			     #
#   # # 			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_SOCO:
	li s0, 5
	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## JAB # 15 hp #################
#  PLAYER			     #
#   # # *			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_JAB:
	li s0, 15
	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## CHUTE BAIXO # 8 hp ##########
#  PLAYER			     #
#   # # 			     #
#   # # * *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_CHUTE_BAIXO:
	li s0, 8
	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## CHUTE ALTO # 15 hp ##########
#  PLAYER			     #
#   # #   *			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################	
TESTE_CHUTE_ALTO:
	li s0, 15
		
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## SOCO AGACHADO # 5 hp ########
#  PLAYER			     #
#   	 			     #
#   				     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################	
TESTE_SOCO_AGACHADO:
	li s0, 5
	
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## ALPISTE # 25 hp #############
#  PLAYER			     #
#   # # *			     #
#   # # * *			     #
#   # #				     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################	
TESTE_ALPISTE:
	li s0, 25
	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t5, 0(t0)
	
	addi t0, t0, 20
	add t0, t0, t2
	lb t4, 0(t0)
	
	bnez t1, HIT
	bnez t5, HIT
	bnez t4, HIT
	li s0, 0
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## CHUTE AGACHADO # 8 hp #######
#  PLAYER			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # * *			     #
#   # # * *			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_CHUTE_AGACHADO:
	li s0, 8
	
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t5, 0(t0)
	
	add t0, t0, t2
	lb t3, 0(t0)
	
	addi t0, t0, 20
	lb t4, 0(t0)
	
	bnez t1, HIT
	bnez t5, HIT
	bnez t3, HIT
	bnez t4, HIT
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## RASTEIRA # 20 hp ############
#  PLAYER			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # * *			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_RASTEIRA:
	li s0, 20
	
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
######## Poder # 15 hp ###############
#  PLAYER			     #
#   # # 			     #
#   # # * * * *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe é indicada por * #
######################################
TESTE_PODER:
	li s0, 15
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t3, 0(t0)
	
	add t0, t0, t2
	lb t4, 0(t0)
	
	add t0, t0, t2
	lb t5, 0(t0)
	
	bnez t1, HIT
	bnez t3, HIT
	bnez t4, HIT
	bnez t5, HIT
	bnez t6, LABEL_DO_JOAO
	j FIM_TESTE
	
HIT: 	# Quando houver hit, pulamos para cá. Por enquanto toca apenas um som
	# a1 = golpe sofrido
	# a0 = 1 se é IO, a0 = 2 se é IA
	
	
	li t0, 1
	beq a0, t0, COLISAO_IA
	
COLISAO_IO:	
#ebreak
	la t0, TONTO_1_IO
	beq s10, t0, ULTIMO_GOLPE_IO				# O COMBATE DEVE ACABAR 
	
	# Socos
	li t0, 0
	beq a1, t0, L_RECUADA_LEVE_IO
	li t0, 1
	beq a1, t0, L_RECUADA_LEVE_IO
	
	# Chutes
	li t0, 2
	beq a1, t0, L_RECUADA_PESADA_IO
	li t0, 3
	beq a1, t0, L_RECUADA_PESADA_IO
	li t0, 8
	beq a1, t0, L_RECUADA_PESADA_IO
	
	# Agachados
	li t0, 4 						# soco
	beq a1, t0, L_RECUADA_LEVE_AGACHADO_IO
	li t0, 6						# chute
	beq a1, t0, L_RECUADA_LEVE_AGACHADO_IO
	
	li t0, 5						# alpiste
	beq a1, t0, L_TOMOU_ALPISTE_IO
	
	li t0, 7						# rasteira
	beq a1, t0, L_LEVOU_RASTEIRA_IO
	
COLISAO_IA:
#ebreak
	la t0, TONTO_1_IA
	beq s11, t0, ULTIMO_GOLPE_IA				# O COMBATE DEVE ACABAR 
		
	# Socos
	li t0, 0
	beq a1, t0, L_RECUADA_LEVE_IA
	li t0, 1
	beq a1, t0, L_RECUADA_LEVE_IA
	
	# Chutes
	li t0, 2
	beq a1, t0, L_RECUADA_PESADA_IA
	li t0, 3
	beq a1, t0, L_RECUADA_PESADA_IA
	li t0, 8
	beq a1, t0, L_RECUADA_PESADA_IA
	
	# Agachados
	li t0, 4 						# soco
	beq a1, t0, L_RECUADA_LEVE_AGACHADO_IA
	li t0, 6						# chute
	beq a1, t0, L_RECUADA_LEVE_AGACHADO_IA
	
	li t0, 5						# alpiste
	beq a1, t0, L_TOMOU_ALPISTE_IA
	
	li t0, 7						# rasteira
	beq a1, t0, L_LEVOU_RASTEIRA_IA

#######################################################################################################################
#							IO
#######################################################################################################################
ULTIMO_GOLPE_IO:
	# se a1 == 5 então tomou alpiste
	
	ebreak
	li t1, 5
	beq t1, a1, L_FATALITY_IO
	
SO_MORREU_IO:
	
	la t0, MORREU_IO
	lw a0, 0(t0)
	
	li a2, 6
	jal ra, IDENTIFICA_POSICAO
	jal ra, FRAME_GOLPE_VGA
	
	la t0, ULTIMO_MORREU_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	
	j VITORIA_IA
	
L_FATALITY_IO:	
	la t0, FATALITY_IO
	lw a0, 0(t0)
	
	li a2, 6
	jal ra, IDENTIFICA_POSICAO
	jal ra, FRAME_GOLPE_VGA
	
	la t0, ULTIMO_FATALITY_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	
VITORIA_IA:
	la t0, VITORIA_1_IA
	lw a0, 0(t0)
	
	li a2, 2
	jal ra, IDENTIFICA_POSICAO_IA
	jal ra, FRAME_GOLPE_VGA_IA

	la t0, VITORIA_2_IA
	lw a0, 0(t0)
	
	la s11, VITORIA_2_IA
	jal ra, FRAME_DANCINHA_IA
	j ACABOU_LUTA
L_RECUADA_LEVE_IO:	
	la t0, BLOQUEANDO_EM_PE_IO
	beq s10, t0, FIM_BLOQUEANDO_IO				# se a IA estiver agachada na verdade ela não tomou
	
	la t0, RECUADA_LEVE_IO
	lw a0, 0(t0)
	
	li a2, 2						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA					# animação do golpe
	
	j FIM_EFETUA_COLISAO_IO
	
L_RECUADA_PESADA_IO:
	la t0, BLOQUEANDO_EM_PE_IO
	beq s10, t0, FIM_BLOQUEANDO_IO 

	la t0, RECUADA_PESADA_IO
	lw a0, 0(t0)
	
	li a2, 3						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA					# animação do golpe
	
	j FIM_EFETUA_COLISAO_IO
	
L_RECUADA_LEVE_AGACHADO_IO:
	la t0, BLOQUEANDO_AGACHADO_IO
	beq s10, t0, FIM_BLOQUEANDO_IO

	la t0, RECUADA_LEVE_AGACHADO_IO
	lw a0, 0(t0)
	
	li a2, 2						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA					# animação do golpe
	
	j FIM_EFETUA_COLISAO_AGACHADO_IO
	
L_TOMOU_ALPISTE_IO:
	la t0, BLOQUEANDO_EM_PE_IO
	beq s10, t0, FIM_BLOQUEANDO_IO	
	
	la t0, TOMOU_ALPISTE_IO
	lw a0, 0(t0)
	
	# Subindo
	li a3, -9600					# desloca 30 pixels para cima
	li a2, 2					# quantidade de frames
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação do pulo
	
	mv t0, a0
	li a7, 32
	li a0, 100
	ecall
	mv a0, t0
	
	# Descendo
	li a3, 9600					# desloca 30 pixels pra baixo
	li a2, 2					# 2 frames para descida
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação dele descendo
	
	mv t0, a0
	li a7, 32
	li a0, 100
	ecall
	mv a0, t0
	
	# Levantando
	li a2, 3
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA			# mostra a animação dele descendo

	mv t0, a0
	li a7, 32
	li a0, 100
	ecall
	mv a0, t0

	la s10, DANCINHA_1_IO

	j FIM_EFETUA_COLISAO_IO
	
L_LEVOU_RASTEIRA_IO:
	la t0, AGACHADO_IO
	beq s10, t0, FIM_BLOQUEANDO_IO				# se a IA estiver agachada na verdade ela não tomou
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq s10, t0, FIM_BLOQUEANDO_IO				# se a IA estiver agachada na verdade ela não tomou

	la s10, DANCINHA_1_IO

	la t0, LEVOU_RASTEIRA_IO
	lw a0, 0(t0)
	
	li a2, 7						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA					# animação do golpe

	j FIM_EFETUA_COLISAO_IO
	
#######################################################################################################################
#							IA
#######################################################################################################################
ULTIMO_GOLPE_IA:
	# se a1 == 5 então tomou alpiste
	li t1, 5
	beq t1, a1, L_FATALITY_IA
	
SO_MORREU_IA:
	ebreak
	la t0, MORREU_IA
	lw a0, 0(t0)
	
	li a2, 6
	jal ra, IDENTIFICA_POSICAO_IA
	jal ra, FRAME_GOLPE_VGA_IA
	
	la t0, ULTIMO_MORREU_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	
	j VITORIA_IO
	
L_FATALITY_IA:	
	la t0, FATALITY_IA
	lw a0, 0(t0)
	
	li a2, 6
	jal ra, IDENTIFICA_POSICAO_IA
	jal ra, FRAME_GOLPE_VGA_IA
	
	la t0, ULTIMO_FATALITY_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	
VITORIA_IO:
	la t0, VITORIA_1_IO
	lw a0, 0(t0)
	
	li a2, 2
	jal ra, IDENTIFICA_POSICAO
	jal ra, FRAME_GOLPE_VGA

	la t0, VITORIA_2_IO
	lw a0, 0(t0)

	jal ra, FRAME_DANCINHA
	
	la s10, VITORIA_2_IO	
	j ACABOU_LUTA

L_RECUADA_LEVE_IA:	
	la t0, BLOQUEANDO_EM_PE_IA
	beq s11, t0, FIM_BLOQUEANDO_IA

	la t0, RECUADA_LEVE_IA
	lw a0, 0(t0)
	
	li a2, 2						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA				# a1 é a direção do personagem 
	jal ra, FRAME_GOLPE_VGA_IA				# animação do golpe
	
		
	j FIM_EFETUA_COLISAO_IA
	
L_RECUADA_PESADA_IA:
	la t0, BLOQUEANDO_EM_PE_IA
	beq s11, t0, FIM_BLOQUEANDO_IA

	la t0, RECUADA_PESADA_IA
	lw a0, 0(t0)
	
	li a2, 3						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA					# animação do golpe
	
	j FIM_EFETUA_COLISAO_IA
L_RECUADA_LEVE_AGACHADO_IA:
	la t0, BLOQUEANDO_AGACHADO_IA
	beq s11, t0, FIM_BLOQUEANDO_IA
	
	la t0, RECUADA_LEVE_AGACHADO_IA
	lw a0, 0(t0)
	
	li a2, 2						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA					# animação do golpe
	
	j FIM_EFETUA_COLISAO_AGACHADO_IA	
L_TOMOU_ALPISTE_IA:	
	la t0, BLOQUEANDO_EM_PE_IA
	beq s11, t0, FIM_BLOQUEANDO_IA

	la t0, TOMOU_ALPISTE_IA
	lw a0, 0(t0)
	
	# Subindo
	li a3, -9600					# desloca 30 pixels para cima
	li a2, 2					# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA		# mostra a animação do pulo
	
	mv t0, a0
	li a7, 32
	li a0, 50
	ecall
	mv a0, t0
	
	# Descendo
	li a3, 9600					# desloca 30 pixels pra baixo
	li a2, 2					# 2 frames para descida
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA		# mostra a animação dele descendo
	
	
	
	# Levantando
	li a2, 3
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA			# mostra a animação dele descendo
	
	la s11, DANCINHA_1_IA					# Se tomou alpiste deve ficar em pé
	
	mv t0, a0
	li a7, 32
	li a0, 400
	ecall
	mv a0, t0

	j FIM_EFETUA_COLISAO_IA
	
L_LEVOU_RASTEIRA_IA:
	la t0, AGACHADO_IA
	beq s11, t0, FIM_BLOQUEANDO_IA			# se a IA estiver agachada na verdade ela não tomou
	
	la t0, BLOQUEANDO_AGACHADO_IA
	beq s11, t0, FIM_BLOQUEANDO_IA			# se a IA estiver agachada na verdade ela não tomou
	
	la t0, LEVOU_RASTEIRA_IA
	lw a0, 0(t0)
	
	la s11, DANCINHA_1_IA
	
	li a2, 7						# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA				# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA					# animação do golpe

	j FIM_EFETUA_COLISAO_IA
	

#######################################################################################################################
FIM_BLOQUEANDO_IO:
	li s0, 0

	addi sp, sp -4					# aloca uma word na pilha
	lw a0, 0(t0)					# a0 = sprite do estado atual
	sw a0, 0(sp)					# salva o sprite atual na pilha
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	li a2, 1					# 1 frame
	jal ra, FRAME_GOLPE_VGA				# pinta o personagem no estado atual em uma das frames
	lw a0, 0(sp)					# recupera o sprite
	jal ra, FRAME_DANCINHA				# pinta o personagem no estado atual na outra frame
	addi sp, sp, 4					# recupera a pilha
	
	li a0, 60  
	li a1, 500
	li a2, 120
	li a3, 50
	li a7, 31
	ecall
	
	j FIM_TESTE
	
FIM_BLOQUEANDO_IA:
	li s0, 0

	addi sp, sp -4					# aloca uma word na pilha
	lw a0, 0(t0)					# a0 = sprite do estado atual
	sw a0, 0(sp)					# salva o sprite atual na pilha
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	li a2, 1					# 1 frame
	jal ra, FRAME_GOLPE_VGA_IA			# pinta o personagem no estado atual em uma das frames
	lw a0, 0(sp)					# recupera o sprite
	jal ra, FRAME_DANCINHA_IA			# pinta o personagem no estado atual na outra frame
	addi sp, sp, 4					# recupera a pilha
	
	li a0, 60  
	li a1, 500
	li a2, 120
	li a3, 50
	li a7, 31
	ecall
	
	j FIM_TESTE
	
FIM_EFETUA_COLISAO_AGACHADO_IA:	
	li a2, 1
	lw a0, 0(s11)
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA

	lw a0, 0(s11)
	jal ra, FRAME_DANCINHA_IA
	j FINALIZAR
	
FIM_EFETUA_COLISAO_AGACHADO_IO:	
	li a2, 1
	lw a0, 0(s10)
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA

	lw a0, 0(s10)
	jal ra, FRAME_DANCINHA
	j FINALIZAR
	
FIM_EFETUA_COLISAO_IO:
	li a2, 1
	la t0, DANCINHA_1_IO
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	la t0, DANCINHA_2_IO
	lw a0, 0(t0)

	jal ra, FRAME_DANCINHA

FINALIZAR:	
	li a0, 60  
	li a1, 500
	li a2, 0
	li a3, 50
	li a7, 31
	ecall
	
	j FIM_TESTE
	
FIM_EFETUA_COLISAO_IA:	
	li a2, 1
	la t0, DANCINHA_1_IA
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	la t0, DANCINHA_2_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	
	li a0, 60  
	li a1, 500
	li a2, 0
	li a3, 50
	li a7, 31
	ecall
	
	j FIM_TESTE
	
LABEL_DO_JOAO:
	#$$$$$$$$$$$
	la t0, TONTO_1_IO
	beq s10, t0, FIM_TESTE
	
	la t0, TONTO_1_IA
	beq s11, t0, FIM_TESTE
  
	li t0, 2
	bne a0, t0 CONSERTAR_IA
	
CONSERTAR_IO:
 	lw a0, 0(s10)
	la t0, DANCINHA_1_IO
	
	li a2, 1 
	jal ra, IDENTIFICA_POSICAO	
	jal ra, FRAME_GOLPE_VGA
	
	beq a0, t0, IO_EM_PE

# não está em pé
	lw a0, 0(s10)
	jal ra, FRAME_DANCINHA
	j FIM_TESTE

IO_EM_PE:
	la t0, DANCINHA_2_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j FIM_TESTE

CONSERTAR_IA:	
	la t0, DANCINHA_1_IA
	lw a0, 0(t0)
	li a2, 1 
	jal ra, IDENTIFICA_POSICAO_IA	
	jal ra, FRAME_GOLPE_VGA_IA
	
	beq a0, t0, IA_EM_PE

# não está em pé
	lw a0, 0(s11)
	jal ra, FRAME_DANCINHA_IA
	j FIM_TESTE

IA_EM_PE:
	la t0, DANCINHA_2_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	
	j FIM_TESTE

	li a0, 60  
	li a1, 500
	li a2, 40
	li a3, 50
	li a7, 31
	ecall
	
FIM_TESTE: # Caso não haja hit ou depois da lógica de hit, encerra o programa
	beq s0, zero, SEM_DANO
	jal ra, APLICA_DANO

ACABOU_LUTA:
SEM_DANO:
	lw ra, 0(sp)		# restora ra
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	lw s7, 16(sp)
	lw s0, 20(sp)
	addi sp, sp, 24		# restora sp
	
	ret			# tchauzinho
	
###################################################
# Funções de colisão de movimento		  #
####### Input  ########                           #
# a0 = 1 (player 1), 2 (player 2)                 #
####### Output ########				  #
# a0 = 1 (caso tenha colisão), 0 (caso não tenha) #
###################################################

VERIFICA_CONTADOR_ESQUERDA:
	addi sp, sp, -16		# faz backups
	sw ra, 0(sp)
	sw a1, 4(sp)
	sw t0, 8(sp)
	sw t1, 12(sp)
	
	mv t1, a0			# ????????? 
	jal ra, CALCULA_CONTADOR	
	mv t0, a0			# t0 = endereço do index inferior esquerdo do personagem na matriz
	mv t1, a1			# t1 = CONTADORH
	
	li t2, 0			# carrega posição da parede esquerda
	ble t1, t2, COLISAO		# se t1 < 0, houve colisão com a parede esquerda
	
	lb t1, -1(t0)			# checa posição anterior horizontalmente do personagem
	bnez t1, COLISAO		# se estiver ocupada com outro personagem, terá colisão
	
	li a0, 0			# seta output para 0 se não houver colisão
	j FIM_VERIFICA_CONTADOR
	
VERIFICA_CONTADOR_DIREITA:
	addi sp, sp, -16			# faz backups
	sw ra, 0(sp)
	sw a1, 4(sp)
	sw t0, 8(sp)
	sw t1, 12(sp)
	
	mv t1, a0			# ????????? 
	jal ra, CALCULA_CONTADOR
	mv t0, a0			# t0 = endereço do index inferior esquerdo do personagem na matriz
	mv t1, a1			# t1 = CONTADORH
	
	li t2, 18			# carrega posição da parede direita
	bge t1, t2, COLISAO		# se t1 > 18, houve colisão com a parede esquerda
	
	lb t1, 2(t0)			# checa posição posterior horizontalmente do personagem
	bnez t1, COLISAO		# se estiver ocupada com outro personagem, terá colisão
	
	li a0, 0			# seta output para 0 se não houver colisão
	j FIM_VERIFICA_CONTADOR
		
COLISAO:
	li a0, 1			# seta output para 1 se houver colisão
	
FIM_VERIFICA_CONTADOR:
	lw ra, 0(sp)		# restora ra
	lw a1, 4(sp)
	lw t0, 8(sp)
	lw t1, 12(sp)
	addi sp, sp, 16		# restora sp
	
	ret			# tchauzinh
