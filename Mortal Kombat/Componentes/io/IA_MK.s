IA_BOT:	
	li t1,0xFF200000    		# Endereço de controle do KDMMIO
	li t0,0x01       		# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           		# Habilita interrupção do teclado
	
	addi sp, sp, -24		#Salva valores na pilha
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw a0, 16(sp)
	sw a7, 20(sp)
	
	la t6, DIFICULDADE_IA		#Pega o endereço com a dificuldade (tempo ocioso)
	lw t1, 0(t6)			#Pega o tempo max que fica sem fazer ação
	
	la t5, TEMPO50_IA		#Endereço que guarda se já houve redução do tempo no round
	lw t2, 0(t5)
	
	la s0, HP_IA			#Endereço para a barra de vida da IA
	lw s0, 0(s0)			#Quantidade de vida da IA
	
	la s1, HP_IO			#Endereço para a barra de vidad do jogador
	lw s1, 0(s1)			#Quantidade de vida do jogador
		
	li t3, 50			
	blt t3, s0, VIDA_OK_IA		#Verifica se a vida da IA está abaixo de 50%
	bne t2, zero, VIDA_OK_IA	#Verifica se o tempo já foi reduzido nesse round
		
	srai t1, t1, 1			#Se sim, o tempo que ela fica ociosa é reduzida pela metade, ficando mais dificil
	li t2, 1			#Valor = 1, houve redução
		
	sw t2, 0(t5)			#Coloca 1 indicando que houve redução
	sw t1, 0(t6)			#Salva o novo tempo ocioso no endereço da dificuldade

VIDA_OK_IA:	
	la t3, CONTADORH1		#Pega o endereço da posição do personagem 1
	lw t3, 0(t3)			#Qual coluna o player está
	la t4, CONTADORH2		#Pega o endereço da posição do personagem 2
	lw t4, 0(t4)			#Qual coluna a IA está
		
	sub s2, t4, t3			#Descobre a quantidade de colunas entre o player e o bot
	addi s2, s2, -1			#Ajusta para o valor correto de colunas entre os dois
	
	la t0, BLOQUEANDO_AGACHADO_IA		
	beq t0, s11, BLOCK_BAIXO_IA		#Ve se está agachado e defendendo
	
	la t0, BLOQUEANDO_EM_PE_IA
	beq t0, s11, BLOCK_ALTO_IA		#Ve se está em pé e defendendo
	
	la t0, AGACHADO_IA
	beq t0, s11, BAIXO_IA			#Ve se está agachado
	
	j EM_PE_IA

############################################# DEFESAS ####################################################################
BLOCK_ALTO_IA:
	li t1, 4
	bge s2, t1, PARA_DEFESA_IA	#Se estiver longe desativa a defesa
	
	la t3,  HITS_IA			#Endereço que guarda quantos hits a IA tomou consecutivamente
	lw t3, 0(t3)			#Pega a quantidade de hits tomados
	
	li t1, 5
	bge t1, t3, IA_FIM		#Se levou menos de 5 hits defendendo e o jogador está próximo, faz nada
	
	bge s1, s0, L_CAMBALHOTA_PRA_FRENTE_IA
	j L_DIREITA_IA
	
PARA_DEFESA_IA:
	bge s1, s0, L_BLOCK_IA			#Se o jogador tem mais vida, só desativa a defesa
	
	li t1, 9				#Vida da IA é maior
	bge s2, t1, L_CAMBALHOTA_PRA_TRAS_IA	#Se o jogador estiver muito longe, dá cambalhota
	j L_ESQUERDA_IA				#Se o jogador estiver relativamente próximo, avança


			
BLOCK_BAIXO_IA:
	li t1, 4
	bge s2, t1, L_BLOCK_IA		#Se o jogador estiver longe desativa a defesa
	j IA_FIM			#Se não, não faz nada
	
	
########################################### CASO AGACHADO ###################################################################
BAIXO_IA:	
	li t1, 4
	bge s2, t1, L_CIMA_IA		#Se estiver distante levanta

	la t3,  HITS_IA			#Endereço que guarda quantos hits a IA tomou consecutivamente
	lw t3, 0(t3)			#Pega a quantidade de hits tomados
	
	li t1, 10
	bge t3, t1, L_BLOCK_IA		#Sofreu 5 hits abertos seguidos, ela bloqueia
	
	li a7, 41			#Gera um número aleatório
	ecall
	
	li t1, 100			
	remu a0, a0, t1			#Faz um mod 100
	addi a0, a0, 1			#Um número entre 1 e 100
	
	li t1, 2
	bge t1, s2, ATAQUE_ABAIXADO_IA	#Se a distância é a distância de combate, ela tenta atacar
	j IA_FIM
	
ATAQUE_ABAIXADO_IA:
	li t1, 6
	blt a0, t1, IA_FIM		#Tem 5% de não atacar
	
	li t1, 1
	bge t1, s2, L_SOCO_1_IA		#Se a distância é de no máximo 1, ele só soca
	
	li t1, 35
	blt a0, t1, L_CHUTE_1_IA	#Com 34% de chance, ele dá um chute
	
	li t1, 68
	blt a0, t1, L_CHUTE_2_IA	#Com 33% de chance, ele dá rasteira
	
	j L_SOCO_2_IA			#Com 33% de chance, ele dá o alpiste
	
	
########################################### CASOS EM PÉ ##################################################################
EM_PE_IA:
	li a7, 41			#Gera um número aleatório
	ecall
	
	li t1, 100			
	remu a0, a0, t1			#Faz um mod 100
	addi a0, a0, 1			#Um número entre 1 e 100

	li t1, 2
	bge t1, s2, ACAO_IA		#Vê se está na distância de batalha
	
	li t1, 10
	bge t1, s2, ESPECIAL_IA		#Tenta dar o especial nessa distância

VOLTA_IA:
	li t1, 18
	bge t1, s2, L_ESQUERDA_IA	#Avança para frente se estiver longe
	
	j L_CAMBALHOTA_PRA_TRAS_IA	#Dá cambalhota se estiver muito longe
	
	
################################## ESPECIAL DA IA ##########################################################
ESPECIAL_IA:
	li t1, 50			
	blt s0, t1, SUPER_IA		#Se a vida estiver com menos com 50 pontos, tem mais chance de dar especial
	
	li t1, 6			
	bge a0, t1, VOLTA_IA		#5% de chance de fazer o especial
	j L_PODER_IA
	
SUPER_IA:
	li t1 31
	bge a0, t1, VOLTA_IA		#30% de chance de fazer o especial
	j L_PODER_IA
	
############################### AÇÃO DA IA ##############################################################
ACAO_IA:
	la t3, HITS_IA
	lw t3, 0(t3)
	
	li t1, 10
	blt t3, t1, CONTINUA_ACAO_IA	#Sofreu 5 hits abertos seguidos, ela tenta bloquea ou recua
	
	li t1, 21
	blt a0, t1, CONTINUA_ACAO_IA	#Com 20% continua seu comportamento normal
	
	li t1, 61			#Com 40% faz a defesa
	blt a0, t1, L_BLOCK_IA
	
	li t1, 51
	blt s0, t1, L_CAMBALHOTA_PRA_FRENTE_IA	#Com 40% faz a defesa e se vida está baixa faz cambalhota
	j L_DIREITA_IA				#Se a vida está alta anda para trás

		
CONTINUA_ACAO_IA:
	la t3, BLOQUEANDO_AGACHADO_IO		
	beq t3, s10, L_BAIXO_IA			#Se o jogador estiver abaixado, a IA abaixa
	
	la t3, AGACHADO_IO
	bne t3, s10, ATAQUE_IA			#Se estiver em é, vai para os ataques
	
	li t1, 11
	blt a0, t1, ATAQUE_IA			#10% de chance de tentar atacar
	
	li t1, 31
	blt a0, t1, L_CIMA_IA			#20% de chance de pular
	
	li t1, 61				
	blt a0, t1, L_BAIXO_IA			#30% de chance de abaixar
	
	j L_DIREITA_IA				#40% de chance de andar para trás
	
ATAQUE_IA:
	li t1, 2
	beq s2, t1, ATAQUES_LONGOS_IA		#Vai para o caso dos chutes
	
	li t1, 51
	blt a0, t1, L_SOCO_1_IA			#50% de fazer um soco
	j L_SOCO_2_IA				#50% de fazer um jab
	
ATAQUES_LONGOS_IA:
	li t1, 31
	blt a0, t1, L_CHUTE_1_IA		#30% de tentar fazer o chute longo
	
	li t1, 61	
	blt a0, t1, L_CHUTE_2_IA		#30% de tentar fazer o chute alto
	
	j L_ESQUERDA_IA				#Ele volta a andar
	

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
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw a0, 16(sp)
	lw a7, 20(sp)
	addi sp, sp, 24			#Recupera valores da pilha
	
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
		
	ret
