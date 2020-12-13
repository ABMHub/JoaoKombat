IA_BOT:		li t1,0xFF200000    			# Endereço de controle do KDMMIO
		li t0,0x01       			# bit 1 habilita/desabilita a interrupção
		sw t0,0(t1)           			# Habilita interrupção do teclado
	
		addi sp, sp, -24		#Salva valores na pilha
		sw s0, 0(sp)
		sw ra, 4(sp)
		sw a0, 8(sp)
		sw a7, 12(sp)
		sw s6, 16(sp)
		sw s7, 20(sp)
		
		la t6, DIFICULDADE_IA		#Pega o endereço com a dificuldade (tempo ocioso)
		lw t1, 0(t6)			#Pega o tempo max que fica sem fazer ação
		
		la t5, TEMPO50_IA		#Endereço que guarda se já houve redução do tempo no round
		lw t2, 0(t5)

		la s0, HP_IA			#Endereço para a barra de vida da IA
		lw s0, 0(s0)			#Quantidade de vida da IA
		
		li t3, 50			
		blt t3, s0, VIDA_OK_IA		#Verifica se a vida da IA está abaixo de 50%
		bne t2, zero, VIDA_OK_IA	#Verifica se o tempo já foi reduzido nesse round
		
		srai t1, t1, 1			#Se sim, o tempo que ela fica ociosa é reduzida pela metade, ficando mais dificil
		li t2, 1			#Valor = 1, houve redução
		
		sw t2, 0(t5)			#Coloca 1 indicando que houve redução
		sw t1, 0(t6)			#Salva o novo tempo ocioso no endereço da dificuldade
		
VIDA_OK_IA:	csrr t2, 3073			#Le o tempo atual
		sub t2, t2, s8			#Calcula o tempo que ficou para
		csrr s8, 3073
		blt t2, t1, IA_FIM		#Se for menor que o tempo max ocioso, não faz nada
		
############################### VERIFICA A DISTÂNCIA ENTRE OS PERSONAGENS #######################################################
		
		la t3, CONTADORH1		#Pega o endereço da posição do personagem 1
		lw t3, 0(t3)			#Qual coluna o player está
		la t4, CONTADORH2		#Pega o endereço da posição do personagem 2
		lw t4, 0(t4)			#Qual coluna a IA está
		
		sub t3, t4, t3			#Descobre a quantidade de colunas entre o player e o bot
		addi t3, t3, -1			#Ajusta para o valor correto de colunas entre os dois
		
		bge t3, zero, DISTANCIA_OK
		sub t3, zero, t3
DISTANCIA_OK:
		li t0, 2			#Se a distância entre os dois for < ou = 2, ataca ou defender (área de combate)
		bge t0, t3, ATK_DEF_IA		#Pula para o caso de ataque e defesa
		
		la t5, AGACHADO_IA
		beq t5, s11, L_CIMA_IA		#Se tiver agachado levanta :D
		
		li t0, 6			#Se a distância entre os dois for < ou = 7, tenta fazer o poder
		bge t0, t3, ESPECIAL_IA		#Vai para o caso de especial

VOLTA_IA:	li t0, 16			#Se a distância entre os dois for < ou = 16 (default), se movimenta
		bge t0, t3, L_ESQUERDA_IA	#Se aproxima
		
		li t0, 20				#Se a distância entre os dois for < 20, dá uma cambalhota
		bge t0, t3, L_CAMBALHOTA_PRA_TRAS_IA	#Se aproxima
		
		j IA_FIM
		
############################### COMPORTAMENTOS DA IA #########################################################################

ESPECIAL_IA:	li a7, 41			#Gera um número aleatório
		ecall
		
		li t1, 10			
		remu a0, a0, t1			#Faz o mod 4 do número aleatório (usado como probabilidade)
		
		beq a0, zero, L_PODER_IA	#Tem 10% de chance de fazer o poder
		jal zero, VOLTA_IA		#Caso não faça, ele se movimenta
		
ATK_DEF_IA:	la t3,  HITS_IA			#Endereço que guarda quantos hits a IA tomou consecutivamente
		lw t3, 0(t3)			#Pega a quantidade de hits tomados
		
		li t1, 3			#Quantidade de hits mínimos para que a IA fuja
		blt t3, t1, ACAO_IA		#Se a quantidade de hits é >= 3
		
		li a7, 41			#Gera um número aleatório
		ecall
		
		li t1, 3			
		remu a0, a0, t1			#Faz o mod 3 do número aleatório (usado como probabilidade)
		
		li t1, 2
		beq a0, t1, ACAO_IA		#Se o resto for igual a 2 (33,33%) não recua
		
		li t1, 50
		blt s0, t1, L_CAMBALHOTA_PRA_FRENTE_IA	#Se tiver menos da metade da vida, dá uma cambalhota para trás
		bge s0, t1, L_DIREITA_IA		#Se tiver mais da metade, só avança para atrás
		
ACAO_IA:	li t2, 7			#Valor referente a 70%

		li a7, 41			#Gera um número aleatório
		ecall
		
		li t1, 10						
		remu a0, a0, t1			#Faz o mod 10 do número aleatório (usado como probabilidade)
		
		li t1, 50			
		bge s0, t1, ATACA_MAIS_IA	#Se tiver com mais de 50% de vida, ela age mais agressivamente
		blt a0, t2, DEFESA_IA		#Caso contrário, ela age mais defensivamente, com 70% de chance de defender
		j ATAQUE_IA			#30% de chance de atacar
		
		
ATACA_MAIS_IA:	blt a0, t2, ATAQUE_IA		#Se age agressivamente, com 70% de chance de atacar
		j DEFESA_IA			#30% de chance de defender
		
		
ATAQUE_IA:	li a7, 41			#Gera um número aleatório
		ecall
		
		li t1, 4			
		remu a0, a0, t1			#Faz o mod 4 do número aleatório (usado como probabilidade)
		
		la t5, AGACHADO_IA		#Carrega o endereço do estado do personagem
		bne t5, s11, EM_PE_IA		#Se está agachado realiza os golpes agachados, se está em pé, realiza os golpes em pé
		
		beq a0, zero, L_CHUTE_2_IA	#Se resto = 0, faz a rasteira
		
		li t1, 1
		beq a0, t1, L_CHUTE_1_IA	#Se resto = 1, faz o chute agachado
		
		li t1, 2
		beq a0, t1, L_SOCO_1_IA		#Se resto = 2, faz o soco abaixado
		
		li t1, 3
		beq a0, t1, L_SOCO_2_IA		#Se resto = 3, faz o alpiste
		
		
EM_PE_IA:
		beq a0, zero, L_CHUTE_2_IA	#Se resto = 0, faz o chute alto
		
		li t1, 1
		beq a0, t1, L_CHUTE_1_IA	#Se resto = 1, faz o chute baixo
		
		li t1, 2
		beq a0, t1, L_SOCO_1_IA		#Se resto = 2, faz o soco
		
		li t1, 3
		beq a0, t1, L_SOCO_2_IA		#Se resto = 3, faz o jab
		

DEFESA_IA:	li a7, 41			#Gera um número aleatório
		ecall

		la t5, AGACHADO_IA		#Endereço do sprite da IA_agachada
		la t6, AGACHADO_IO		#Endereço do sprite da IO_agachada
		
		beq t5, s11, IA_BAIXA		#Vê se a IA está agachada
		beq t6, s10, IO_BAIXA		#Vê se o Player está agachado
		
		li t1, 3			
		remu a0, a0, t1			#Faz o mod 3 do número aleatório (usado como probabilidade)
		
		li t1, 2
		blt t1, a0, L_BLOCK_IA		#Realiza a defesa com 66,66% de chance
		j L_BAIXO_IA			#Se não abaixa
		
IO_BAIXA:	li t1, 3			
		remu a0, a0, t1			#Faz o mod 3 do número aleatório (usado como probabilidade)
		
		li t1, 2
		blt t1, a0, L_BLOCK_IA		#Realiza a defesa com 66,66% de chance
		j L_CIMA_IA			#Se não pula

IA_BAIXA:	j L_BLOCK_IA

############################## MOVIMENTAÇÃO DA IA ################################################################
L_DIREITA_IA:
	#la t0, AGACHADO_IA			# Carrega o endereço do ponteiro para agachado
	#beq t0, s11, IA_FIM			# Se estiver agachado não faz nada
	
	#la t0, BLOQUEANDO_AGACHADO_IA
	#beq t0, s11, IA_FIM			# Se estiver agachado não faz nada
	
	la s11, DANCINHA_1_IA			# Coloca em s11 o estado atual
	la t0, CONTADORH2			# carrega o contador
	lw t1, 0(t0)				# t1 = contador
	li a3, 0				# inicializa o deslocamento em 0
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA	# verifica se houve colisão
	
	bne a0, zero, L_LIMITE_DIREITA_IA	# a0 != 0 => houve colisão
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não houve colisão
	
	UPDATE_MATRIZ
	
	# Se não houve colisão
	li a3, 4				# deslocamento da caminhada
	
L_LIMITE_DIREITA_IA:
	la t0, CAMINHAR_DIREITA_IA 		# se houve colisão
	lw a0, 0(t0)				# a0 = sprite da caminhada

	j L_CAMINHAR_IA
########################################################################################################################
L_ESQUERDA_IA:

	#la t0, AGACHADO_IA					
	#beq t0, s11, IA_FIM			# se estiver agachado não faz nada
	
	#la t0, BLOQUEANDO_AGACHADO_IA
	#beq t0, s11, IA_FIM			# Se estiver agachado não faz nada

	la s11, DANCINHA_1_IA			# Coloca em s11 o estado atual
	la t0, CONTADORH2			# carrega o contador
	lw t1, 0(t0)				# t1 = valor do contador
	li a3, 0				# deslocamento = 0
	addi t1, t1, -1				# subtrai um do contador
	jal ra, VERIFICA_CONTADOR_ESQUERDA	# verifica se houve colisão
	bne a0, zero L_LIMITE_ESQUERDA_IA	# se a0 = 1 => houve colisão
	sw t1, 0(t0)				# salva o novo contador somente se não houve colisão
	
	UPDATE_MATRIZ
	
	#Se não houve colisão
	li a3, -4				# deslocamento da caminhada

L_LIMITE_ESQUERDA_IA:				# Se houve colisão
	la t0, CAMINHAR_ESQUERDA_IA		# move pra trás
	lw a0, 0(t0)				# a0 = sprite a ser pintado
	j L_CAMINHAR_IA	
#######################################################################################################################
L_CIMA_IA:	
	la t0, DANCINHA_1_IA				# Se estiver em pé tem que pular
	beq t0, s11, L_PULAR_IA
	
	la t0, AGACHADO_IA				# se estiver agachado tem que levantar
	beq t0, s11, L_LEVANTAR_IA
	
	j IA_FIM
	
L_PULAR_IA:
	# Subindo
	la t0, PULAR_1_IA				# ponteiro do sprite do pulo
	lw a0, 0(t0)					# carrega o sprite do pulo
	li a3, -9600					# desloca 30 pixels para cima
	li a2, 2					# o pulo são 2 frames
	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA			# mostra a animação do pulo
	
	# Descendo
	la t0, PULAR_2_IA				# ponteiro do sprite da descida do pulo
	lw a0, 0(t0)					# pulo descendo
	li a3, 9600					# desloca 30 pixels pra baixo
	
	li a2, 1					# 2 frames para descida
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA			# mostra a animação dele descendo
	
	j L_TOTAL_RESET_EM_PE_IA			# vai para dancinha
	
	# Levantar
L_LEVANTAR_IA: 
	la s11, DANCINHA_1_IA				# faz com que s11 tenha ele em pé
	la t0, LEVANTAR_IA
	lw a0, 0(t0)					# carrega o sprite dele agaixado
	li a2, 1
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA				# 1 frame
	
	j L_TOTAL_RESET_EM_PE_IA
#######################################################################################################################
L_BAIXO_IA:
	la t0, AGACHADO_IA				# Ponteiro para agachado
	beq t0, s11, IA_FIM			# Se já estiver agachado não faz nada			
	
	la t0, DANCINHA_1_IA				# Ponteiro para dancinha
	beq t0, s11, L_AGACHAR_IA			# se estiver em pé tem que abaixar

	j IA_FIM

L_AGACHAR_IA:
	la s11, AGACHADO_IA
	la t0, AGACHANDO_IA				# carrega o sprite abaixando
	lw a0, 0(t0)
	li a2, 1					# são 2 frames
	#li a3, 0					# deslocamento 0
	#jal ra, FRAME_DESLOCAMENTO_VGA_IA			# animação
	#la s11, AGACHADO_IA				# coloca "agachado" no estado atual
	
	#lw a0, 0(s11)					# a0 = sprite dele agachado 
	#jal ra, FRAME_DANCINHA_IA				# pinta esse sprite na outra frame
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	UPDATE_MATRIZ
	
	j L_TOTAL_RESET_AGACHADO_IA
	
	#j IA_FIM_SubZero
#######################################################################################################################
L_CHUTE_1_IA:
    	la t0, DANCINHA_1_IA
   	beq t0, s11, L_CHUTE_1_EM_PE_IA	     	 	# se estiver em pé chuta
   	
   	la t0, AGACHADO_IA				# se estiver abaixado dá outro tipo de chute
	beq t0, s11, L_CHUTE_1_AGACHADO_IA
	
	j IA_FIM
	
L_CHUTE_1_EM_PE_IA:
	li a2, 4					# são 5 frames
	li s6, 2
	
	# Faz algo obscuro LUCAS
	#li a1, 2					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
    	
    	la t0, CHUTE_1_EM_PE_IA				# ponteiro do chute 1 normal 
    	lw a0, 0(t0)					# a0 = chute 1 normal
    	j L_GOLPE_IA						# animação
    	
L_CHUTE_1_AGACHADO_IA:   
	li a2, 4
	li s6, 6					# são 5 frames
    	la t0, CHUTE_1_AGACHADO_IA			# ponteiro do chute 1 agachado
    	lw a0, 0(t0)					# a0 = chute 1 agachado	
    	
    	j L_GOLPE_IA
#######################################################################################################################
L_SOCO_1_IA:
    	la t0, DANCINHA_1_IA				# ponteiro da dancinha
    	beq t0, s11, L_SOCO_1_EM_PE_IA		       	# Se estiver em pé dá um soco
    	
    	la t0, AGACHADO_IA				# Se estiver abaixado dá outro tipo de soco
	beq t0, s11, L_SOCO_1_AGACHADO_IA
	
	j IA_FIM

L_SOCO_1_EM_PE_IA:
	li s6, 0
	li a2, 4					# são 2 frames##############
   	la t0, SOCO_1_EM_PE_IA				# ponteiro do soco 1 em pé
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	#li a1, 0					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IA						# animação
 
L_SOCO_1_AGACHADO_IA:
	li s6, 4
	li a2, 2					# são 3 frames
   	la t0, SOCO_1_AGACHADO_IA			# ponteiro do soco 1 agachado
   	lw a0, 0(t0)					# sprite do soco 1 agachado
   	j L_GOLPE_IA			
    	
#######################################################################################################################
L_CHUTE_2_IA:
        la t0, DANCINHA_1_IA				# Ponteiro da dancinha	
        beq t0, s11, L_CHUTE_2_EM_PE_IA		        # Se estiver em pé dá um tipo de soco
        
        la t0, AGACHADO_IA				# Ponteiro agachado				
	beq t0, s11, L_CHUTE_2_AGACHADO_IA		# Se estiver abaixado dá outro tipo de soco
	
	j IA_FIM

L_CHUTE_2_EM_PE_IA:
	li s6, 3
	li a2, 5					# são 6 frames
       	la t0, CHUTE_2_EM_PE_IA				# ponteiro do sprite
       	lw a0, 0(t0)					# a0 = sprite 
       	
       	# Faz coisas obscuras LUCAS		
       	#li a1, 3					#??????????????????????????????
    	#jal ra, TESTE_GOLPE				#??????????????????????????????
    	
       	j L_GOLPE_IA

L_CHUTE_2_AGACHADO_IA:
	li s6, 7
	li a2, 4					# são 5 frames
       	la t0, CHUTE_2_AGACHADO_IA	
       	lw a0, 0(t0)

	j L_GOLPE_IA
#######################################################################################################################
L_SOCO_2_IA:
    	la t0, DANCINHA_1_IA				# ponteiro da dancinha
    	beq t0, s11, L_SOCO_2_EM_PE_IA		       	# Se estiver em pé dá um soco
    	
    	la t0, AGACHADO_IA				# Se estiver abaixado dá outro tipo de soco
	beq t0, s11, L_SOCO_2_AGACHADO_IA
	
	j IA_FIM

L_SOCO_2_EM_PE_IA:
	li s6, 1
	li a2, 4					# são 2 frames
   	la t0, SOCO_2_EM_PE_IA				# ponteiro do soco 1 em pé
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	#li a1, 0					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IA						# animação
 
L_SOCO_2_AGACHADO_IA:
	li s6, 5
	la s11, DANCINHA_1_IA				# muda o estado para em pé
	li a2, 5					# são 6 frames
   	la t0, SOCO_2_AGACHADO_IA			# ponteiro do soco 1 agachado
   	lw a0, 0(t0)					# sprite do soco 1 agachado
   	j L_GOLPE_IA			
#######################################################################################################################
L_BLOCK_IA:
	la t0, BLOQUEANDO_EM_PE_IA			# block ativo em pé
	beq t0, s11, L_DESATIVAR_BLOCK_EM_PE_IA		# Desativa o block
	
	la t0, BLOQUEANDO_AGACHADO_IA			# block ativo agachado
	beq t0, s11, L_DESATIVAR_BLOCK_AGACHADO_IA	# Desativa o block agachado
	
	la t0, AGACHADO_IA				# se estiver abaixado ativa block no chao
	beq t0, s11, L_BLOCK_AGACHADO_IA
	
	la t0, DANCINHA_1_IA
	beq t0, s11, L_BLOCK_EM_PE_IA
	
	j IA_FIM

	# Se chegou até aqui ativa o block em pé
	
L_BLOCK_EM_PE_IA:
	la s11, BLOQUEANDO_EM_PE_IA				# significa que o personagem ficará com escudo ativo
	
	la t0, BLOCK_EM_PE_IA
	lw a0, 0(t0)
	li a2, 2					# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	j L_RESET_BLOCK_EM_PE_IA
	
L_BLOCK_AGACHADO_IA:
	la s11, BLOQUEANDO_AGACHADO_IA		# significa que o personagem ficará com block no chão ativo
	la t0, BLOCK_AGACHADO_IA		
	lw a0, 0(t0)				# a0 = sprite do bloco agachado
	li a2, 2				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	j L_RESET_BLOCK_AGACHADO_IA
	
L_DESATIVAR_BLOCK_EM_PE_IA:
	la s11, DANCINHA_1_IA
	
	la t0, DESATIVAR_BLOCK_EM_PE_IA
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 1				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	j L_TOTAL_RESET_EM_PE_IA
			
L_DESATIVAR_BLOCK_AGACHADO_IA:
	la s11, AGACHADO_IA
	
	la t0, DESATIVAR_BLOCK_AGACHADO_IA
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 1				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	j L_TOTAL_RESET_AGACHADO_IA

#######################################################################################################################
L_CAMBALHOTA_PRA_FRENTE_IA:	
	la t0, AGACHADO_IA			# Carrega o endereço do ponteiro para agachado
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IA
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada

	
	# preparação
	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j L_CAMBALHOTA_IA
	
L_CAMBALHOTA_PRA_TRAS_IA: 
	la t0, AGACHADO_IA			# Carrega o endereço do ponteiro para agachado
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IA
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada
	
	# Preparação
	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra trás
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra trás
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
L_CAMBALHOTA_IA:
	la t0, CAMBALHOTA_IA			# carrega o sprite da cambalhota
	lw a0, 0(t0)
	lw a3, 0(sp)
	li s4, 0				# contador
	li s3, 3				# limite do contador
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_SUBINDO_IA	
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA		# mostra a animação da cambalhota
	
LOOP_CAMBALHOTA_SUBINDO_IA:
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_SUBINDO_IA	
	#jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_IA
	
	lw a3, 4(sp)
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_IA:	
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_DESCENDO_IA
	#jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_IA
	
	addi sp, sp, 8
	mv a3, zero
	
	mv t2, a1
	jal ra, IDENTIFICA_POSICAO_IA
	beq t2, a1, L_TOTAL_RESET_EM_PE_IA
	
	#mudaram de posição
	#la t0, PERSONAGEM1
	#lw t1, 0(t0)
	#li t3, 16
	#mul t3, t3, t2
	#add t1, t1, t3
	#sw t1, 0(t0)
	#jal ra, IDENTIFICA_POSICA########################################
	li t0, 0xFF200604
	lw t0, 0(t0)			# Descobre em que frame estamos
	
	bne t0, zero, CAMBALHOTA_FRAME1_IA		
CAMBALHOTA_FRAME0_IA:
	la t0, LARGURA_FRAME_0		# a4 = endereço da largura
	lw t0, 0(t0)
	
	la t1, PERSONAGEM1
	lw t2, 0(t1)
	
	mul t0, t0, a1
	add t2, t2, t0
	sw t2, 0(t1)
	j L_TOTAL_RESET_EM_PE_IA
	  
CAMBALHOTA_FRAME1_IA:
	la t0, LARGURA_FRAME_1		# a4 = endereço da largura
	lw t0, 0(t0)
	
	la t1, PERSONAGEM1
	lw t2, 0(t1)
	
	mul t0, t0, a1
	add t2, t2, t0
	sw t2, 0(t1)
	j L_TOTAL_RESET_EM_PE_IA
	
L_CONTROLE_SUBINDO_IA:
	la t0, CONTADORH2
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, L_LIMITE_DIREITA_CAMBALHOTA_SUBINDO_IA
	li t2, -1
	beq t1, t2, L_LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_IA
	
L_NAO_S_IA:	
	sw t1, 0(t0)	
	
	UPDATE_MATRIZ
	
	ret

L_CONTROLE_DESCENDO_IA:
	la t0, CONTADORH2
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, L_LIMITE_DIREITA_CAMBALHOTA_DESCENDO_IA
	li t2, -1
	beq t1, t2, L_LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_IA
	
L_NAO_D_IA:
	sw t1, 0(t0)
	
	UPDATE_MATRIZ
			
	ret	
			
L_LIMITE_DIREITA_CAMBALHOTA_SUBINDO_IA:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_S_IA
	
L_LIMITE_DIREITA_CAMBALHOTA_DESCENDO_IA:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_D_IA
	
L_LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_IA:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_S_IA

L_LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_IA:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_D_IA

###########################################################################################
L_PODER_IA:

	la t0, AGACHADO_IA			# Carrega o endereço do ponteiro para agachado
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IA
	beq t0, s11, IA_FIM		# Se estiver agachado não faz nada
	
	la t0, PODER_IA				# ponteiro do poder
	lw a0, 0(t0)				# a0 = sprite inicial do poder
	li a2, 5				# são 5 frames na ida

	jal ra, IDENTIFICA_POSICAO_IA
	jal ra, FRAME_GOLPE_VGA_IA
	j L_TOTAL_RESET_EM_PE_IA
#######################################################################################################################
L_CAMINHAR_IA:

	li a2, 3				# quantidade de frames
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA

L_TOTAL_RESET_EM_PE_IA:	
	li a2, 1
	la t0, DANCINHA_1_IA
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA_IA
	
	la t0, DANCINHA_2_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	j IA_FIM
	
L_GOLPE_IA:
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA				# animação do golpe
	
	mv  s7, a0
	li  a2, 1
	jal ra, FRAME_GOLPE_VGA_IA				# animação do golpe
	
	mv  a0, s7
	jal ra, FRAME_DANCINHA_IA
	
	li t0,0xFF200604    # Escolhe o Frame 0 ou 1
   	lw t1, 0(t0)            # inicio Frame 0
	xori t1, t1, 0x001
	sw t1, 0(t0)
	
	mv a1, s6					#???????????????????????????????????????
    	jal ra, TESTE_GOLPE				#???????????????????????????????????????
	
	li a3, 0
	la t0, DANCINHA_1_IA
	beq t0, s11, L_TOTAL_RESET_EM_PE_IA	# verifica se está em pé
	
	la t0, AGACHADO_IA
	beq t0, s11, L_TOTAL_RESET_AGACHADO_IA
	
	la t0, BLOQUEANDO_EM_PE_IA
	beq t0, s11, L_RESET_BLOCK_EM_PE_IA 

L_RESET_BLOCK_AGACHADO_IA:	
	# se chegou até aqui significa que é o block agachado
	la t0, BLOQUEANDO_AGACHADO_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	j IA_FIM
	
L_RESET_BLOCK_EM_PE_IA: 
	la t0, BLOQUEANDO_EM_PE_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	j IA_FIM				
													
L_TOTAL_RESET_AGACHADO_IA:	
	li a2, 1
	la t0, AGACHADO_IA
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO_IA			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA_IA
	
	la t0, AGACHADO_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	j IA_FIM

IA_FIM: 	
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw a0, 8(sp)
	lw a7, 12(sp)
	lw s6, 16(sp)
	lw s7, 20(sp)
	addi sp, sp, 24			#Recupera valores da pilha
	
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
		
	ret
