###################################################################
# Função para preencher a fila de acordo com a animação escolhida #
###################################################################
# Inputs:							  #
# a0 - O endereco da fila					  #
# a1 - O endereço inicial da animação				  #
# a2 - O movimento do personagem				  #
# 	0 - soco		8 - andar Esquerda		  #
#	1 - jab			9 - andar direita		  #
#	2 - chute baixo		10 - cambalhota esquerda	  #
#	3 - chute alto		11 - cambalhota direita	  	  #
#	4 - soco agachado	12 - pular			  #
#	5 - alpiste		13 - agachar			  #
#	6 - chute agachado	14 - block			  #
#	7 - rasteira		15 - poder			  #
# a3 - Player 1 -> 1						  #
#      Player 2 -> 2						  #
###################################################################

# Endereços da Fila, para debug

# 0 deslocamento
# 4 quantidade de frames
# 8 direcao (1 se tiver olhando pra direita, -1 se for pra esquerda)
# 12 pos inicial do personagem
# o resto é a fila

PREENCHE_FILA:
	lw t0, 4(a0)			# t0 é a quantidade de frames
	li t1, 0			# t1 é o contador
	lw t4, 0(a0)			# t4 é o deslocamento
	addi a0, a0, 16			# a0 é o endereço que armazenaremos o frame
	
	j PREENCHE_DESLOCAMENTO
	
LOOP_PREENCHE_FILA:	
	sw t4, 0(a0)			# Salva na fila o deslocamento
	sw a1, 4(a0)			# Salva na fila o sprite
	addi a0, a0, 8			# Avança na fila
	addi t1, t1, 1 			# Adiciona 1 no contador
	bne t1, t0, FIM_PREENCHE_FILA	# Caso nós tenhamos salvado todos os frames, encerra
	
	lw t2, 0(a1)			# Carrega largura do frame
	lw t3, 4(a1)			# Carrega altura do frame
	mul t2, t2, t3			# Altura x Largura
	addi t2, t2, 8			# Addi mágico
	add a1, a1, t2			# Vai para o próximo frame
		
	j PREENCHE_DESLOCAMENTO		# Continua loop
	
PREENCHE_DESLOCAMENTO:
	li t2, 10
	beq a2, t2 DESLOCAMENTO_CAMB_E			# a2 == 10 -> cambalhota esquerda
	
	li t2, 11
	beq a2, t2 DESLOCAMENTO_CAMB_D			# a2 == 11 -> cambalhota direita
	
	li t2, 12
	beq a2, t2 DESLOCAMENTO_PULAR			# a2 == 12 -> pular
	
	j LOOP_PREENCHE_FILA

	DESLOCAMENTO_CAMB_E:
		li t2, 4				# t2 = 3
		bne t2, t1, LOOP_PREENCHE_FILA		# Caso não seja o 3 frame da cambalhota, volta pro loop
		li t4, 7664				# Caso seja, muda o deslocamento para baixo
		j LOOP_PREENCHE_FILA			# Volta pro loop
	
	DESLOCAMENTO_CAMB_D:
		li t2, 4				# t2 = 3
		bne t2, t1, LOOP_PREENCHE_FILA		# Caso não seja o 3 frame da cambalhota, volta pro loop
		li t4, 7696				# Caso seja, muda o deslocamento para baixo
		j LOOP_PREENCHE_FILA			# Volta pro loop

	DESLOCAMENTO_PULAR:
		li t2, 2				# t2 = 2
		bne t2, t1, LOOP_PREENCHE_FILA		# Caso não seja o 2 frame do pulo, volta pro loop
		li t4, 9600				# Caso seja, muda o deslocamento para baixo
		j LOOP_PREENCHE_FILA			# Volta pro loop
	
FIM_PREENCHE_FILA:					
	li t0, 8					# Checa se estamos andando para esquerda
	li t1, -4					# Caso estivermos, deslocamento do 'parado' é -4
	beq a2, t0, SALVA_DESLOCAMENTO			# Faz o teste
	
	li t0, 9					# Checa se estamos andando para direita
	li t1, 4					# Caso estivermos, deslocamento do 'parado' é 4
	beq a2, t0, SALVA_DESLOCAMENTO			# Faz o teste
	
	li t1, 0					# Caso não estivermos andando, o deslocamento é 0
	
	SALVA_DESLOCAMENTO:				
		sw t1, 0(a0)				# Salva o deslocamento
	
	li t0, 2					
	beq a3, t0, P2_PREENCHE_PARADO			# Checa se é player 2 (IA)
	
	P1_PREENCHE_PARADO:				
		la t1, AGACHADO_IO			# Checa se p1 está agachado
		beq s10, t1, RET_PREENCHE		# Caso seja, o último sprite da fila é o agachado
							
		PREENCHE_PARADO_IO:
			la t1, PARADO_IO		# Caso não esteja, o último sprite da fila é o em pé
	
	j RET_PREENCHE
	
	P2_PREENCHE_PARADO:
		la t1, AGACHADO_IA			# Checa se p1 está agachado
		beq s10, t1, RET_PREENCHE		# Caso seja, o último sprite da fila é o agachado
		
		PREENCHE_PARADO_IA:
			la t1, PARADO_IA		# Caso não esteja, o último sprite da fila é o em pé

RET_PREENCHE:
	lw t1, 0(t1)
	sw t1, 0(a0)
	ret						# Encerra o programa