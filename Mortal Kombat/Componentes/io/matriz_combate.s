.text

####################################################################
# Fun��o para uso interno. Retorna em a0 o endere�o do canto       #
# inferior esquerdo do personagem na matriz de combate             #
####### Input ########                                             #
# a0 = jogador (1 ou 2)         				   #
####### Output #######						   #
# a0 = endere�o do index inferior esquerdo do personagem na matriz #
# a1 = CONTADORH                 				   #
####################################################################

CALCULA_CONTADOR:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t0, 2
	beq t0, a0, CONTADOR_J2	# beq para carregar pos do jogador 1 ou 2
	
CONTADOR_J1: # Carrega posi��o do jogador 1
	lw t0, CONTADORV1
	lw t1, CONTADORH1
	j POS_BEQ_CONTADOR
	
CONTADOR_J2: # Carrega posi��o do jogador 2
	lw t0, CONTADORV2
	lw t1, CONTADORH2
	
POS_BEQ_CONTADOR:
	mv a1, t1		# a1 = CONTADORH do personagem escolhido
	li t2, 20		# 20 == largura
	mul t0, t0, t2		# medi��o vertical * 20 para percorrer verticalmente a matriz
	add t0, t0, t1		# t0 � o index inferior esquerdo da hitbox
	
	mv t1, a0		# carrega numero do jogador para escrever na matriz
	la t2, MATRIZ_COMBATE	# carrega endere�o da matriz de combate
	add a0, t2, t0		# t0 � agora o canto inferior esquerdo da hitbox
	
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# volta

####################################################################
# Fun��o de escrever na matriz de combate a posi��o do personagem  #
####### Input ########                                             #
# a0 = jogador (1 ou 2)                                            #
# a1 = altura (em blocos da matriz)                                #
# a2 = largura (em blocos da matriz)                               #
####################################################################
	
ESCREVE_POSICAO_MATRIZ:
	addi sp, sp, -4		# cl�ssico backup do ra
	sw ra, 0(sp)		#

	mv t1, a0		# t1 � o jogador (1 ou 2)
	mv t3, a1		# reg t3 vira tempor�rio para altura do personagem
	jal ra, CALCULA_CONTADOR # agora a0 = endere�o do canto inferior esquerdo do personagem x na matriz
	mv a1, t3		# a1 � a altura do personagem em rela��o a matriz
	mv t0, a0		# t0 � o endere�o do canto inferior esquerdo do personagem x na matriz

	li t2, 0		# contador de loop interno
	li t3, 0		# contador de loop externo
		
LOOP_CONTADOR:
	sb t1, 0(t0)		# salva n do jogador na posi��o da matriz
	addi t2, t2, 1		# aumenta contador
	addi t0, t0, 1		# itera horizontalmente
	bne t2, a2, LOOP_CONTADOR	# continua o loop caso precise
	
	# caso o loop interno (loop horizontal) acabe
	sub t0, t0, t2		# volta pro come�o horizontalmente
	li t2, 0		# reseta contador interno
	addi t3, t3, 1		# aumenta contador externo
	addi t0, t0, -20	# sobe uma posi��o verticalmente
	bne t3, a1, LOOP_CONTADOR 	# continua loop caso precise
	
	# caso loop externo (loop vertical) acabe
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# tchauzinho
	
####################################################################
# Fun��o de testar soco
####### Input ########
# a0 = jogador (1 ou 2)              ?
# a1 = tipo de golpe
# 	0 - soco		4 - soco agachado
#	1 - jab			5 - alpiste
#	2 - chute baixo		6 - chute agachado
#	3 - chute alto		7 - rasteira
####################################################################

TESTE_GOLPE:
	addi sp, sp, -16	# faz backup em ra e nos registradores a's
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	
	mv t3, a1		# temp: t3 � tipo de golpe
	jal ra, CALCULA_CONTADOR 
	mv t0, a0		# t0 � endere�o do index inferior esquerdo do personagem na matriz
	mv a1, t3		# a1 � o tipo de golpe
	
	lw t1, CONTADORH1	# t1 � o contador horizontal do player 1
	lw t2, CONTADORH2	# t2 � o contador horizontal do player 1
	
	li t3, 2		# t3 � 2 para teste de player
	beq t3, a0, TESTE_PER2	# se for player 2, branch
	
	sub t1, t1, t2		# t1 � negativo se o player 1 estiver na esquerda
	bgtz t1, TESTE_INVERTIDO # pula para teste invertido se player 1 estiver na direita
	j TESTE_NORMAL		# caso esteja na esquerda, faz teste normal
	
TESTE_PER2:
	sub t1, t2, t1		# t1 � negativo se o player 2 estiver na esquerda
	bgtz t1, TESTE_INVERTIDO # pula para teste invertido se player 1 estiver na direita
				# caso esteja na esquerda, faz teste normal
TESTE_NORMAL:
	addi t0, t0, 1		# vai para o canto inferior direito do personagem na matriz
	li t2, 1		# indica a dire��o do teste. os testes ser�o feitos para a direita
	j TESTE_CASE		# pula para o switch case de golpe
	
TESTE_INVERTIDO:
	li t2, -1		# indica a dire��o do teste. os testes ser�o feitos para a equerda
	
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
	
#########SOCO NORMAL##################
#  PLAYER  			     #
#   # # 			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################
TESTE_SOCO:
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	j FIM_TESTE
	
######## JAB #########################
#  PLAYER			     #
#   # # *			     #
#   # # *			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################
TESTE_JAB:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	addi t0, t0, -20
	lb t3, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t3, HIT
	j FIM_TESTE
	
######## CHUTE BAIXO #################
#  PLAYER			     #
#   # # 			     #
#   # # 			     #
#   # # * *			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################
TESTE_CHUTE_BAIXO:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
######## CHUTE ALTO ##################
#  PLAYER			     #
#   # #   *			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################	
TESTE_CHUTE_ALTO:	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -80
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
######## SOCO AGACHADO ###############
#  PLAYER			     #
#   	 			     #
#   				     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################	
TESTE_SOCO_AGACHADO:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	j FIM_TESTE
	
######## ALPISTE #####################
#  PLAYER			     #
#   # # *			     #
#   # # * *			     #
#   # # *			     #
#   # # 			     #
#   # # 			     #
# A hitbox do golpe � indicada por * #
######################################	
TESTE_ALPISTE:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t5, 0(t0)
	
	addi t0, t0, -20
	lb t3, 0(t0)
	
	addi t0, t0, 20
	add t0, t0, t2
	lb t4, 0(t4)
	
	bnez t1, HIT
	bnez t5, HIT
	bnez t3, HIT
	bnez t4, HIT
	j FIM_TESTE
	
######## CHUTE AGACHADO ##############
#  PLAYER			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # * *			     #
#   # # * *			     #
# A hitbox do golpe � indicada por * #
######################################
TESTE_CHUTE_AGACHADO:
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	add t0, t0, t2
	lb t3, 0(t0)
	
	addi t0, t0, 20
	lb t4, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t3, HIT
	bnez t4, HIT
	j FIM_TESTE
	
######## RASTEIRA ####################
#  PLAYER			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # 			     #
#   # # * *			     #
# A hitbox do golpe � indicada por * #
######################################
TESTE_RASTEIRA:
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
HIT: # Quando houver hit, pulamos para c�. Por enquanto toca apenas um som
	li a0, 60  
	li a1, 500
	li a2, 0
	li a3, 50
	li a7, 31
	ecall
	
FIM_TESTE: # Caso n�o haja hit ou depois da l�gica de hit, encerra o programa
	lw ra, 0(sp)		# restora ra
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	addi sp, sp, 16		# restora sp
	
	ret			# tchauzinho
	
###################################################
# Fun��es de colis�o de movimento		  #
####### Input  ########                           #
# a0 = 1 (player 1), 2 (player 2)                 #
####### Output ########				  #
# a0 = 1 (caso tenha colis�o), 0 (caso n�o tenha) #
###################################################

VERIFICA_CONTADOR_ESQUERDA:
	addi sp, sp, -16		# faz backups
	sw ra, 0(sp)
	sw a1, 4(sp)
	sw t0, 8(sp)
	sw t1, 12(sp)
	
	mv t1, a0			# ????????? 
	jal ra, CALCULA_CONTADOR	
	mv t0, a0			# t0 = endere�o do index inferior esquerdo do personagem na matriz
	mv t1, a1			# t1 = CONTADORH
	
	li t2, 0			# carrega posi��o da parede esquerda
	ble t1, t2, COLISAO		# se t1 < 0, houve colis�o com a parede esquerda
	
	lb t1, -1(t0)			# checa posi��o anterior horizontalmente do personagem
	bnez t1, COLISAO		# se estiver ocupada com outro personagem, ter� colis�o
	
	li a0, 0			# seta output para 0 se n�o houver colis�o
	j FIM_VERIFICA_CONTADOR
	
VERIFICA_CONTADOR_DIREITA:
	addi sp, sp, -16			# faz backups
	sw ra, 0(sp)
	sw a1, 4(sp)
	sw t0, 8(sp)
	sw t1, 12(sp)
	
	mv t1, a0			# ????????? 
	jal ra, CALCULA_CONTADOR
	mv t0, a0			# t0 = endere�o do index inferior esquerdo do personagem na matriz
	mv t1, a1			# t1 = CONTADORH
	
	li t2, 18			# carrega posi��o da parede direita
	bge t1, t2, COLISAO		# se t1 > 18, houve colis�o com a parede esquerda
	
	lb t1, 2(t0)			# checa posi��o posterior horizontalmente do personagem
	bnez t1, COLISAO		# se estiver ocupada com outro personagem, ter� colis�o
	
	li a0, 0			# seta output para 0 se n�o houver colis�o
	j FIM_VERIFICA_CONTADOR
		
COLISAO:
	li a0, 1			# seta output para 1 se houver colis�o
	
FIM_VERIFICA_CONTADOR:
	lw ra, 0(sp)		# restora ra
	lw a1, 4(sp)
	lw t0, 8(sp)
	lw t1, 12(sp)
	addi sp, sp, 16		# restora sp
	
	ret			# tchauzinh
