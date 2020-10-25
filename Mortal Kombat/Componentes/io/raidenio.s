############################################################################################
#Procedimento responsável pelo controle do teclado, quando uma tecla é pressionada uma
#interrupção se inicia. De acordo com a tecla que é pressionada algo pode ou não acontecer.
#Não há entradas nem saídas aqui
#
#Obs_Raiden: Esse procedimento chama dois outros_Raiden: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0, s1, s4, s3 e s5 são alterados$$$$$$$$
############################################################################################ 

KDInterrupt_Raiden:  
	addi sp, sp, -4				# aloca espaço na pilha
	sw ra, 0(sp)				# salva ra na pilha
	
	csrrci zero,0,1     			# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
        
SWITCH_CASE_TECLA_Raiden: 				
	li t3, 'd'
	beq t3, t2, DIREITA_Raiden		# verifica se a tecla pressionada é 'd'
	
	li t3, 'a'
	beq t3, t2, ESQUERDA_Raiden
	
	li t3, 'w'
AQUI2_Raiden:	beq t3, t2, PULAR_CIMA_Raiden
	
AQUI3_Raiden:	li t3, 's'
	beq t3, t2, ABAIXAR_Raiden
	
	li t3, 'x'
    	beq t3, t2, CHUTE_Raiden        	#verifica se a tecla pressionada é 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO_Raiden
    	
    	li t3, 'z'
        beq t3, t2, CHUTE_ALTO_Raiden
        
        li t3, 'v'
        beq t3, t2, JAB_Raiden
        
        li t3, 'f'
        beq t3, t2, BLOCK_Raiden
        
        li t3, 'e'
        beq t3, t2, CAMBALHOTA_PRA_FRENTE_Raiden
        
        li t3, 'q'
        beq t3, t2, CAMBALHOTA_PRA_TRAS_Raiden
        
        li t3, ' '
        beq t3, t2, PODER_Raiden
        li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado

	j Fim_KDInterrupt_Raiden		# Se não for nenhuma dessas não faz nada
###########################################################################################		
DIREITA_Raiden:
	la t0, RaidenAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden

	la t0, CONTADOR1			# carrega o contador
	lw t1, 0(t0)				
	li a3, 0				# inicializa o deslocamento em 0
	li t2, 19				# máximo do contador
	addi t1, t1, 1				# incrementa o contador
	bge t1, t2, LIMITE_DIREITA_Raiden	# verifica se o contador atingiu o limite
	
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	
RAIDEN_PRA_FRENTE_Raiden:
	li a3, 4
	
LIMITE_DIREITA_Raiden:
	#addi t1, t1, -1
	la a0, RaidenAndando_1			# move pra frente
	
	j CAMINHAR_Raiden
###########################################################################################
ESQUERDA_Raiden:
	la t0, RaidenAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden

	la t0, CONTADOR1
	lw t1, 0(t0)
	li a3, 0
	addi t1, t1, -1
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_Raiden
	sw t1, 0(t0)
	
RAIDEN_PRA_TRAS_Raiden: 
	li a3, -4
LIMITE_ESQUERDA_Raiden:
	#addi t1, t1, 1
	
	la a0, RaidenAndando_3V		# move pra trás
	j CAMINHAR_Raiden
	
##########################################################################################	
PULAR_CIMA_Raiden:	
	la t0, RaidenParado_1			# se estiver parado tem que pular
	beq t0, s10, RAIDEN_PARA_CIMA_Raiden
	
	la t0, RaidenAgachando_2		# se estiver agachado tem que levantar
	beq t0, s10, LEVANTAR_Raiden

RAIDEN_PARA_CIMA_Raiden:
	la s10, RaidenParado_1			# garante que em s10 tenha ele parado
	la a0, RaidenPulando_1			# carrega o sprite do pulo
	li a3, -9600				# desloca 30 pixels para cima
	li a2, 2				# o pulo são 2 frames
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação do pulo
	
	la a0, RaidenPulando_2			# prepara o reset
	li a3, 9600				# desloca 30 pixels pra baixo
	
	li a2, 2				# a2 já é 2 (2 frames")
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação dele descendo
	j RESET_Raiden
###########################################################################################	
LEVANTAR_Raiden: 
	la s10, RaidenParado_1			# faz com que s10 tenha ele parado
	la a0, RaidenAgachando_3V		# carrega o sprite dele agaixado
	li a2, 1				# 1 frame
	jal ra, FRAME_GOLPE_VGA			# animação
	j RESET_Raiden
###########################################################################################
ABAIXAR_Raiden:
	la t0, RaidenAgachando_2		# se já estiver abaixado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden		
	
	la t0, RaidenParado_1			# se estiver em pé tem que abaixar
	beq t0, s10, AGACHAR_Raiden

AGACHAR_Raiden:
	#li a3, 4800				# desloca 15 pixels para baixo
	la a0, RaidenAgachando_1		# carrega o sprite abaixando
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação
	la s10, RaidenAgachando_2		# seta ele a
	j Fim_KDInterrupt_Raiden

###########################################################################################
CHUTE_Raiden:
SWITCH_CASE_PERSONAGEM_CHUTE_Raiden:

    	la t0, RaidenParado_1
   	beq t0, s10, RAIDEN_CHUTE_Raiden      # se estiver em pé chuta
   	
   	la t0, RaidenAgachando_2		# se estiver abaixado dá outro chute
	beq t0, s10, CHUTE_ABAIXADO_Raiden
	
RAIDEN_CHUTE_Raiden:
	li a2, 5				# são 3 frames
    	la a0, RaidenChuteBaixo_1			
    	j GOLPE_Raiden				# animação
    	
CHUTE_ABAIXADO_Raiden:   
	li a2, 3				# são 3 frames
    	la a0, RaidenChuteAgachado_1			
    	jal ra, FRAME_GOLPE_VGA			# animação
    	
   	mv a0, s10				# reseta ele agachado
   	li a2, 1				# 1 frame
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_Raiden
SOCO_Raiden:
SWITCH_CASE_PERSONAGEM_SOCO_Raiden:
    	la t0, RaidenParado_1
    	beq t0, s10, RAIDEN_SOCO_Raiden       # Se estiver em pé dá um soco
    	
    	la t0, RaidenAgachando_2		# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, SOCO_ABAIXADO_Raiden

RAIDEN_SOCO_Raiden:
	li a2, 5				# são 2 frames
   	la a0, RaidenSoco_1
   	j GOLPE_Raiden				# animação
 
SOCO_ABAIXADO_Raiden:
	li a2, 3				# são 3 frames
   	la a0, RaidenSocoAgachado_1
   	jal ra, FRAME_GOLPE_VGA			# animação
   	
   	mv a0, s10				# reseta pra ele
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_Raiden
    	
CHUTE_ALTO_Raiden:
SWITCH_CASE_PERSONAGEM_CHUTE_ALTO_Raiden:
        la t0, RaidenParado_1
        beq t0, s10, RAIDEN_CHUTE_ALTO_Raiden         # PERSONAGEM 1 É O RAIDEN
        
        la t0, RaidenAgachando_2		# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, RASTEIRA_Raiden

RAIDEN_CHUTE_ALTO_Raiden:
	li a2, 6
       	la a0, RaidenChuteAlto_1
       	j GOLPE_Raiden

RASTEIRA_Raiden:
	li a2, 5
       	la a0, RaidenRasteira_1
       	jal ra, FRAME_GOLPE_VGA			# animação
    	
    	la a0, RaidenAgachando_2
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_Raiden

JAB_Raiden:
SWITCH_CASE_PERSONAGEM_JAB_Raiden:
        la t0, RaidenParado_1
        beq t0, s10, RAIDEN_JAB_Raiden        # PERSONAGEM 1 É O RAIDEN
        
        la t0, RaidenAgachando_2
        beq t0, s10, ALPISTE_ORH_Raiden        # PERSONAGEM 1 É O RAIDEN

RAIDEN_JAB_Raiden:
	li a2, 5
       	la a0, RaidenJab_1
       	j GOLPE_Raiden

ALPISTE_ORH_Raiden: 
       	li a2, 6
       	la a0, RaidenAlpiste_1
       	jal ra, FRAME_GOLPE_VGA			# animação
       	
    	la s10, RaidenParado_1
    	mv a0, s10
   	j RESET_Raiden
    	
BLOCK_Raiden:
	la t0, RaidenBlock_2			# block ativo
	beq t0, s10, DESATIVAR_BLOCK_Raiden
	
	la t0, RaidenBlockAgachado_2		# block ativo
	beq t0, s10, DESATIVAR_BLOCK_CHAO_Raiden
	
	la t0, RaidenAgachando_2		# se estiver abaixado ativa block no chao
	beq t0, s10, BLOCK_CHAO_Raiden

ATIVAR_BLOCK_Raiden:
	la s10, RaidenBlock_2			# significa que o personagem ficará com escudo ativo
	la a0, RaidenBlock_1
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação de block
	j Fim_KDInterrupt_Raiden
	
BLOCK_CHAO_Raiden:
	la s10, RaidenBlockAgachado_2		# significa que o personagem ficará com block no chão ativo
	la a0, RaidenBlockAgachado_1
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação
	j Fim_KDInterrupt_Raiden
	
DESATIVAR_BLOCK_Raiden:
	la t0, RaidenBlockAgachado_2
	beq t0, s10, DESATIVAR_BLOCK_CHAO_Raiden	#block chao ativo
	
	mv a0, s10				# se chegou até aqui é porque está em pé
	la s10, RaidenParado_1			# significa que o personagem ficará em pé
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# a0 tem o estado anterior de s10, anima a0
	j RESET_Raiden
			
DESATIVAR_BLOCK_CHAO_Raiden:
	mv a0, s10
	la s10, RaidenAgachando_2
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, RaidenAgachando_2
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	j Fim_KDInterrupt_Raiden
	
CAMBALHOTA_PRA_FRENTE_Raiden:	
	la t0, RaidenAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden

	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j CAMBALHOTA_Raiden
	
CAMBALHOTA_PRA_TRAS_Raiden: 
	la t0, RaidenAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden

	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra trás
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra trás
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
CAMBALHOTA_Raiden:
	la s10, RaidenParado_1			# garante que em s10 tenha ele parado
	la a0, RaidenCambalhota_1		# carrega o sprite da cambalhota
	lw a3, 0(sp)
	
	li s4, 0				# contador
	li s3, 4				# limite do contador
	
LOOP_CAMBALHOTA_SUBINDO_Raiden:
	li a2, 1				# a cambalhota são 2 frames
	jal ra, CONTROLE_SUBINDO_Raiden	
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_Raiden
	
	lw a3, 4(sp)
	
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_Raiden:	
	li a2, 1				# a cambalhota são 2 frames
	jal ra, CONTROLE_DESCENDO_Raiden
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_Raiden 
	
	addi sp, sp, 8
	j RESET_Raiden
	
CONTROLE_SUBINDO_Raiden:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_SUBINDO_Raiden
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_Raiden
	
NAO_S_Raiden:	sw t1, 0(t0)	
	ret

CONTROLE_DESCENDO_Raiden:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_DESCENDO_Raiden
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_Raiden
	
NAO_D_Raiden:	sw t1, 0(t0)	
	ret	
			
LIMITE_DIREITA_CAMBALHOTA_SUBINDO_Raiden:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_Raiden
	
LIMITE_DIREITA_CAMBALHOTA_DESCENDO_Raiden:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_Raiden
	
LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_Raiden:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_Raiden

LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_Raiden:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_Raiden
							
PODER_Raiden:
	la t0, RaidenAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_Raiden

	la a0, RaidenPoder_1			# carrega o sprite do poder
	li a2, 2				# são 3 frames na ida
	jal ra, FRAME_GOLPE_VGA
	
	j RESET_Raiden				# reseta ele parado em pé
############################################################################################
#Esse loop é responsável por realizar a animação do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs_Raiden: Apagar é chamado aqui seguido de Personagem para que uma animção ocorra
#
#Ao término do loop o personagem se desloca 16 pixels
############################################################################################
CAMINHAR_Raiden:	
	li a2, 3				# quantidade de frames
	jal ra, FRAME_DESLOCAMENTO_VGA	
	li a2, 1
	la a0, RaidenParado_1
	jal ra, FRAME_DESLOCAMENTO_VGA
	j Fim_KDInterrupt_Raiden
	
RESET_Raiden:	la a0, RaidenParado_1		# posição padrão
	li a2, 1				# contagem de frames
	jal ra, FRAME_GOLPE_VGA			# a golpe não desloca o personagem 
	j Fim_KDInterrupt_Raiden
	
GOLPE_Raiden:
    	jal ra, FRAME_GOLPE_VGA			# animação do golpe
    	la a0, RaidenParado_1			# reseta ele parado
    	li a2, 1				# 1 frame
    	jal ra, FRAME_GOLPE_VGA		
    	j Fim_KDInterrupt_Raiden
	
Fim_KDInterrupt_Raiden:
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
	
	lw ra, 0(sp)				# recupera ra
	addi sp, sp, 4				# libera espaço na pilha
	csrrsi zero,0,0x10 			# seta o bit de habilitação de interrupção em ustatus 
	uret					# volta ao programa principal
	
	
