########################################################################################################################
#Procedimento responsável pelo controle do teclado, quando uma tecla é pressionada uma
#interrupção se inicia. De acordo com a tecla que é pressionada algo pode ou não acontecer.
#Não há entradas nem saídas aqui
#
#Obs_SubZero: Esse procedimento chama dois outros_SubZero: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0, s1, s4, s3, s5 e s8 são alterados$$$$$$$$
######################################################################################################################## 

.macro UPDATE_MATRIZ
	addi sp, sp, -16		# Faz backups dos a's para nao zoar a KDInterrupt
	sw a0, 0(sp)			
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw ra, 12(sp)
	
	jal ra, ZERA_MATRIZ		# Chama funcao de zerar matriz
		
	li a1, 3			# Altura do novo personagem na matriz eh temporariamente 3
	
	la t0, AGACHADO_IO		
	beq s10, t0, AGACHADO_MACRO_P1	# Checa se player 1 esta agachado
	la t0, BLOQUEANDO_AGACHADO_IO
	beq s10, t0, AGACHADO_MACRO_P1
					
	li a1, 5			# se nao estiver, sua altura eh 5
AGACHADO_MACRO_P1:			# Se estiver, sua altura eh 3

	li a0, 1			# informa o procedimento que eh o player 1
	li a2, 2			# largura do personagem na matriz sera 2
	jal ra, ESCREVE_POSICAO_MATRIZ	# escreve personagem 1
	
################ player 2 ##############
	
	li a1, 3			# Altura do novo personagem na matriz eh temporariamente 3
	
	la t0, AGACHADO_IA
	beq s11, t0, AGACHADO_MACRO_P2	# Checa se player 2 esta agachado
	la t0, BLOQUEANDO_AGACHADO_IA
	beq s11, t0, AGACHADO_MACRO_P2
	
	li a1, 5			# se nao estiver, sua altura eh 5	
AGACHADO_MACRO_P2:			# Se estiver, sua altura eh 3

	li a0, 2			# informa o procedimento que eh o player 2
	li a2, 2
	jal ra, ESCREVE_POSICAO_MATRIZ	# escreve personagem 2
	
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw a2, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16			# restora sp
.end_macro

.text
KDInterrupt:  
	addi sp, sp, -16			# aloca espaço na pilha
	sw ra, 0(sp)				# salva ra na pilha
	sw s8, 4(sp)
	sw s7, 8(sp)
	sw s6, 12(sp)
	li s8,1					# define que é o personagem 1 quem está agindo
	
	csrrci zero,0,1     			# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
        
        la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt
        
        la t0, VITORIA_2_IO
        beq t0, s10, Fim_KDInterrupt
        
SWITCH_CASE_TECLA: 			
	li t3, 'd'
	beq t3, t2, L_DIREITA_IO		# verifica se a tecla pressionada é 'd'
	
	li t3, 'a'
	beq t3, t2, L_ESQUERDA_IO
	
	li t3, 'w'
	beq t3, t2, L_CIMA_IO
	
	li t3, 's'
	beq t3, t2, L_BAIXO_IO
	
	li t3, 'x'
    	beq t3, t2, L_CHUTE_1_IO	        	#verifica se a tecla pressionada é 'x'
    	
    	li t3, 'c'
    	beq t3, t2, L_SOCO_1_IO
    	
    	li t3, 'z'
        beq t3, t2, L_CHUTE_2_IO
        
        li t3, 'v'
        beq t3, t2, L_SOCO_2_IO
  
        li t3, 'f'
        beq t3, t2, L_BLOCK_IO
        
        li t3, 'e'
        beq t3, t2, L_CAMBALHOTA_PRA_FRENTE_IO
        
        li t3, 'q'
        beq t3, t2, L_CAMBALHOTA_PRA_TRAS_IO
        
        li t3, ' '
        beq t3, t2, L_PODER_IO
        li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado

	j Fim_KDInterrupt			# Se não for nenhuma dessas não faz nada
########################################################################################################################
L_DIREITA_IO:
	la t0, AGACHADO_IO			# Carrega o endereço do ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver tonto não faz nada
	
	la s10, DANCINHA_1_IO			# Coloca em s10 o estado atual
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				# t1 = contador
	li a3, 0				# inicializa o deslocamento em 0
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA	# verifica se houve colisão
	
	bne a0, zero, L_LIMITE_DIREITA_IO	# a0 != 0 => houve colisão
	sw t1, 0(t0)
					# guarda o novo valor do contador somente se não houve colisão
	UPDATE_MATRIZ
	
	# Se não houve colisão
	li a3, 4				# deslocamento da caminhada
	
L_LIMITE_DIREITA_IO:
	la t0, CAMINHAR_DIREITA_IO 		# se houve colisão
	lw a0, 0(t0)				# a0 = sprite da caminhada

	j L_CAMINHAR_IO
########################################################################################################################
L_ESQUERDA_IO:

	la t0, AGACHADO_IO					
	beq t0, s10, Fim_KDInterrupt		# se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver tonto não faz nada

	la s10, DANCINHA_1_IO			# Coloca em s10 o estado atual
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				# t1 = valor do contador
	li a3, 0				# deslocamento = 0
	addi t1, t1, -1				# subtrai um do contador
	jal ra, VERIFICA_CONTADOR_ESQUERDA	# verifica se houve colisão
	bne a0, zero L_LIMITE_ESQUERDA_IO		# se a0 = 1 => houve colisão
	sw t1, 0(t0)				# salva o novo contador somente se não houve colisão
	
	UPDATE_MATRIZ
	#Se não houve colisão
	li a3, -4					# deslocamento da caminhada

L_LIMITE_ESQUERDA_IO:					# Se houve colisão
	la t0, CAMINHAR_ESQUERDA_IO				# move pra trás
	lw a0, 0(t0)					# a0 = sprite a ser pintado
	j L_CAMINHAR_IO	
#######################################################################################################################
L_CIMA_IO:	
	la t0, DANCINHA_1_IO				# Se estiver em pé tem que pular
	beq t0, s10, L_PULAR_IO
	
	la t0, AGACHADO_IO				# se estiver agachado tem que levantar
	beq t0, s10, L_LEVANTAR_IO
	
	j Fim_KDInterrupt
	
L_PULAR_IO:
	# Subindo
	la t0, PULAR_1_IO				# ponteiro do sprite do pulo
	lw a0, 0(t0)					# carrega o sprite do pulo
	li a3, -9600					# desloca 30 pixels para cima
	li a2, 2					# o pulo são 2 frames
	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação do pulo
	
	# Descendo
	la t0, PULAR_2_IO				# ponteiro do sprite da descida do pulo
	lw a0, 0(t0)					# pulo descendo
	li a3, 9600					# desloca 30 pixels pra baixo
		
	li a2, 1					# 2 frames para descida
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação dele descendo
	
	j L_TOTAL_RESET_EM_PE_IO			# vai para dancinha
	
	# Levantar
L_LEVANTAR_IO: 
	la s10, DANCINHA_1_IO				# faz com que s10 tenha ele em pé
	la t0, LEVANTAR_IO
	lw a0, 0(t0)					# carrega o sprite dele agaixado
	li a2, 1
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA				# 1 frame
	
	j L_TOTAL_RESET_EM_PE_IO
#######################################################################################################################
L_BAIXO_IO:
	la t0, AGACHADO_IO				# Ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt			# Se já estiver agachado não faz nada			
	
	la t0, DANCINHA_1_IO				# Ponteiro para dancinha
	beq t0, s10, L_AGACHAR_IO			# se estiver em pé tem que abaixar

	j Fim_KDInterrupt

L_AGACHAR_IO:
	la s10, AGACHADO_IO
	la t0, AGACHANDO_IO				# carrega o sprite abaixando
	lw a0, 0(t0)
	li a2, 1					# são 2 frames
	#li a3, 0					# deslocamento 0
	#jal ra, FRAME_DESLOCAMENTO_VGA			# animação
	#la s10, AGACHADO_IO				# coloca "agachado" no estado atual
	
	#lw a0, 0(s10)					# a0 = sprite dele agachado 
	#jal ra, FRAME_DANCINHA				# pinta esse sprite na outra frame
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	UPDATE_MATRIZ
	
	j L_TOTAL_RESET_AGACHADO_IO
	
	#j Fim_KDInterrupt_SubZero
#######################################################################################################################
L_CHUTE_1_IO:
    	la t0, DANCINHA_1_IO
   	beq t0, s10, L_CHUTE_1_EM_PE	     	 	# se estiver em pé chuta
   	
   	la t0, AGACHADO_IO				# se estiver abaixado dá outro tipo de chute
	beq t0, s10, L_CHUTE_1_AGACHADO
	
	j Fim_KDInterrupt
	
L_CHUTE_1_EM_PE:
	li a2, 4					# são 5 frames
	li s6, 2
	
	# Faz algo obscuro LUCAS
	#li a1, 2					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
    	
    	la t0, CHUTE_1_EM_PE_IO				# ponteiro do chute 1 normal 
    	lw a0, 0(t0)					# a0 = chute 1 normal
    	j L_GOLPE_IO						# animação
    	
L_CHUTE_1_AGACHADO:   
	li a2, 4
	li s6, 6					# são 5 frames
    	la t0, CHUTE_1_AGACHADO_IO			# ponteiro do chute 1 agachado
    	lw a0, 0(t0)					# a0 = chute 1 agachado	
    	
    	j L_GOLPE_IO
#######################################################################################################################
L_SOCO_1_IO:
    	la t0, DANCINHA_1_IO				# ponteiro da dancinha
    	beq t0, s10, L_SOCO_1_EM_PE_IO		       	# Se estiver em pé dá um soco
    	
    	la t0, AGACHADO_IO				# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, L_SOCO_1_AGACHADO_IO
	
	j Fim_KDInterrupt

L_SOCO_1_EM_PE_IO:
	li s6, 0
	li a2, 4					# são 2 frames##############
   	la t0, SOCO_1_EM_PE_IO				# ponteiro do soco 1 em pé
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	#li a1, 0					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IO						# animação
 
L_SOCO_1_AGACHADO_IO:
	li s6, 4
	li a2, 2					# são 3 frames
   	la t0, SOCO_1_AGACHADO_IO			# ponteiro do soco 1 agachado
   	lw a0, 0(t0)					# sprite do soco 1 agachado
   	j L_GOLPE_IO			
    	
#######################################################################################################################
L_CHUTE_2_IO:
        la t0, DANCINHA_1_IO				# Ponteiro da dancinha	
        beq t0, s10, L_CHUTE_2_EM_PE_IO		        # Se estiver em pé dá um tipo de soco
        
        la t0, AGACHADO_IO				# Ponteiro agachado				
	beq t0, s10, L_CHUTE_2_AGACHADO_IO		# Se estiver abaixado dá outro tipo de soco
	
	j Fim_KDInterrupt

L_CHUTE_2_EM_PE_IO:
	li s6, 3
	li a2, 5					# são 6 frames
       	la t0, CHUTE_2_EM_PE_IO				# ponteiro do sprite
       	lw a0, 0(t0)					# a0 = sprite 
       	
       	# Faz coisas obscuras LUCAS		
       	#li a1, 3					#??????????????????????????????
    	#jal ra, TESTE_GOLPE				#??????????????????????????????
    	
       	j L_GOLPE_IO

L_CHUTE_2_AGACHADO_IO:
	li s6, 7
	li a2, 4					# são 5 frames
       	la t0, CHUTE_2_AGACHADO_IO	
       	lw a0, 0(t0)

	j L_GOLPE_IO
#######################################################################################################################
L_SOCO_2_IO:
    	la t0, DANCINHA_1_IO				# ponteiro da dancinha
    	beq t0, s10, L_SOCO_2_EM_PE_IO		       	# Se estiver em pé dá um soco
    	
    	la t0, AGACHADO_IO				# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, L_SOCO_2_AGACHADO_IO
	
	j Fim_KDInterrupt

L_SOCO_2_EM_PE_IO:
	li s6, 1
	li a2, 4					# são 2 frames
   	la t0, SOCO_2_EM_PE_IO				# ponteiro do soco 1 em pé
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	#li a1, 0					#???????????????????????????????????????
    	#jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IO						# animação
 
L_SOCO_2_AGACHADO_IO:
	#la t0, TONTO_1_IA
	#beq s11, t0, FATALITY_IA

	li s6, 5
	la s10, DANCINHA_1_IO				# muda o estado para em pé
	li a2, 5					# são 6 frames
   	la t0, SOCO_2_AGACHADO_IO			# ponteiro do soco 2 agachado
   	lw a0, 0(t0)					# sprite do soco 2 agachado
   	j L_GOLPE_IO		
			
#######################################################################################################################
L_BLOCK_IO:
	la t0, BLOQUEANDO_EM_PE_IO			# block ativo em pé
	beq t0, s10, L_DESATIVAR_BLOCK_EM_PE_IO		# Desativa o block
	
	la t0, BLOQUEANDO_AGACHADO_IO			# block ativo agachado
	beq t0, s10, L_DESATIVAR_BLOCK_AGACHADO_IO	# Desativa o block agachado
	
	la t0, AGACHADO_IO				# se estiver abaixado ativa block no chao
	beq t0, s10, L_BLOCK_AGACHADO_IO
	
	la t0, DANCINHA_1_IO
	beq t0, s10, L_BLOCK_EM_PE_IO
	
	j Fim_KDInterrupt

	# Se chegou até aqui ativa o block em pé
	
L_BLOCK_EM_PE_IO:
	la s10, BLOQUEANDO_EM_PE_IO				# significa que o personagem ficará com escudo ativo
	
	la t0, BLOCK_EM_PE_IO
	lw a0, 0(t0)
	li a2, 2					# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	j L_RESET_BLOCK_EM_PE_IO
	
L_BLOCK_AGACHADO_IO:
	la s10, BLOQUEANDO_AGACHADO_IO		# significa que o personagem ficará com block no chão ativo
	la t0, BLOCK_AGACHADO_IO		
	lw a0, 0(t0)				# a0 = sprite do bloco agachado
	li a2, 2				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	j L_RESET_BLOCK_AGACHADO_IO
	
L_DESATIVAR_BLOCK_EM_PE_IO:
	la s10, DANCINHA_1_IO
	
	la t0, DESATIVAR_BLOCK_EM_PE_IO
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 1				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	j L_TOTAL_RESET_EM_PE_IO
			
L_DESATIVAR_BLOCK_AGACHADO_IO:
	la s10, AGACHADO_IO
	
	la t0, DESATIVAR_BLOCK_AGACHADO_IO
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 1				# são 2 frames
	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	j L_TOTAL_RESET_AGACHADO_IO

#######################################################################################################################
L_CAMBALHOTA_PRA_FRENTE_IO:	
	la t0, AGACHADO_IO			# Carrega o endereço do ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver tonto não faz nada
	
	# preparação
	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j L_CAMBALHOTA_IO
	
L_CAMBALHOTA_PRA_TRAS_IO: 
	la t0, AGACHADO_IO			# Carrega o endereço do ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver tonto não faz nada
	
	# Preparação
	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra trás
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra trás
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
L_CAMBALHOTA_IO:
	la t0, CAMBALHOTA_IO			# carrega o sprite da cambalhota
	lw a0, 0(t0)
	lw a3, 0(sp)
	li s4, 0				# contador
	li s3, 3				# limite do contador
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_SUBINDO_IO	
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	
LOOP_CAMBALHOTA_SUBINDO_IO:
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_SUBINDO_IO	
	#jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_IO
	
	lw a3, 4(sp)
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_IO:	
	li a2, 1				# a cambalhota são 2 frames
	jal ra, L_CONTROLE_DESCENDO_IO
	#jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_IO
	
	addi sp, sp, 8
	mv a3, zero
	
	mv t2, a1
	jal ra, IDENTIFICA_POSICAO
	beq t2, a1, L_TOTAL_RESET_EM_PE_IO
	
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
	
	bne t0, zero, CAMBALHOTA_FRAME1_IO		
CAMBALHOTA_FRAME0_IO:
	la t0, LARGURA_FRAME_0		# a4 = endereço da largura
	lw t0, 0(t0)
	
	la t1, PERSONAGEM1
	lw t2, 0(t1)
	
	mul t0, t0, a1
	add t2, t2, t0
	sw t2, 0(t1)
	
	UPDATE_MATRIZ
	
	j L_TOTAL_RESET_EM_PE_IO
	  
CAMBALHOTA_FRAME1_IO:
	la t0, LARGURA_FRAME_1		# a4 = endereço da largura
	lw t0, 0(t0)
	
	la t1, PERSONAGEM1
	lw t2, 0(t1)
	
	mul t0, t0, a1
	add t2, t2, t0
	sw t2, 0(t1)
	
	UPDATE_MATRIZ
	
	j L_TOTAL_RESET_EM_PE_IO
	
L_CONTROLE_SUBINDO_IO:
	la t0, CONTADORH1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, L_LIMITE_DIREITA_CAMBALHOTA_SUBINDO_IO
	li t2, -1
	beq t1, t2, L_LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_IO
	
L_NAO_S_IO:	
	sw t1, 0(t0)	
	
	ret

L_CONTROLE_DESCENDO_IO:
	la t0, CONTADORH1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, L_LIMITE_DIREITA_CAMBALHOTA_DESCENDO_IO
	li t2, -1
	beq t1, t2, L_LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_IO
	
L_NAO_D_IO:
	sw t1, 0(t0)	
	
	ret	
			
L_LIMITE_DIREITA_CAMBALHOTA_SUBINDO_IO:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_S_IO
	
L_LIMITE_DIREITA_CAMBALHOTA_DESCENDO_IO:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_D_IO
	
L_LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_IO:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_S_IO

L_LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_IO:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j L_NAO_D_IO

###########################################################################################
L_PODER_IO:

	la t0, AGACHADO_IO			# Carrega o endereço do ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, BLOQUEANDO_AGACHADO_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado não faz nada
	
	la t0, TONTO_1_IO
	beq t0, s10, Fim_KDInterrupt		# Se estiver tonto não faz nada
	
	la t0, PODER_IO				# ponteiro do poder
	lw a0, 0(t0)				# a0 = sprite inicial do poder
	li a2, 5				# são 5 frames na ida

	jal ra, IDENTIFICA_POSICAO
	jal ra, FRAME_GOLPE_VGA
	
	jal ra, IDENTIFICA_POSICAO
	la a0, ScorpionProjetil_1
	li a2, 4
	li a3, 0
	jal ra, P_PODER
		
	la t0, PERSONAGEM1_INICIO
	lw t0, 0(t0)
	li a1, 8
	li s8, 1
	jal ra, TESTE_GOLPE
	la t0, PERSONAGEM1_INICIO
	lw t0, 0(t0)
		
	li a3, 0
		
	j L_TOTAL_RESET_EM_PE_IO
#######################################################################################################################
L_CAMINHAR_IO:

	li a2, 3				# quantidade de frames
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA

L_TOTAL_RESET_EM_PE_IO:	
	la s10, DANCINHA_1_IO
	li a2, 1
	la t0, DANCINHA_1_IO
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_DESLOCAMENTO_VGA
	
	la t0, DANCINHA_2_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt
	
L_GOLPE_IO:
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA				# animação do golpe
	
	mv  s7, a0
	li  a2, 1
	jal ra, FRAME_GOLPE_VGA				# animação do golpe
	
	mv  a0, s7
	jal ra, FRAME_DANCINHA
	
	li t0,0xFF200604    # Escolhe o Frame 0 ou 1
   	lw t1, 0(t0)            # inicio Frame 0
	xori t1, t1, 0x001
	sw t1, 0(t0)
	
	mv a1, s6					#???????????????????????????????????????
    	jal ra, TESTE_GOLPE				#???????????????????????????????????????
	
	li a3, 0
	
	la t0, VITORIA_2_IO
	beq t0, s10, Fim_KDInterrupt
	
	la t0, DANCINHA_1_IO
	beq t0, s10, L_TOTAL_RESET_EM_PE_IO	# verifica se está em pé
	
	la t0, AGACHADO_IO
	beq t0, s10, L_TOTAL_RESET_AGACHADO_IO
	
	la t0, BLOQUEANDO_EM_PE_IO
	beq t0, s10, L_RESET_BLOCK_EM_PE_IO 

L_RESET_BLOCK_AGACHADO_IO:	
	# se chegou até aqui significa que é o block agachado
	la t0, BLOQUEANDO_AGACHADO_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt
	
L_RESET_BLOCK_EM_PE_IO: 
	la t0, BLOQUEANDO_EM_PE_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt				
													
L_TOTAL_RESET_AGACHADO_IO:	
	li a2, 1
	la t0, AGACHADO_IO
	lw a0, 0(t0)
	jal ra, IDENTIFICA_POSICAO			# a1 é a direção do personagem
	jal ra, FRAME_GOLPE_VGA
	
	la t0, AGACHADO_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt

Fim_KDInterrupt:
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
	
	lw ra, 0(sp)				# recupera ra
	lw s8, 4(sp)
	lw s7, 8(sp)
	lw s6, 12(sp)
	addi sp, sp, 16				# libera espaço na pilha
	csrrsi zero,0,0x10 			# seta o bit de habilitação de interrupção em ustatus 
	uret					# volta ao programa principal
	
	
