############################################################################################
#Procedimento responsável pelo controle do teclado, quando uma tecla é pressionada uma
#interrupção se inicia. De acordo com a tecla que é pressionada algo pode ou não acontecer.
#Não há entradas nem saídas aqui
#
#Obs_SubZero: Esse procedimento chama dois outros_SubZero: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0, s1, s4, s3 e s5 são alterados$$$$$$$$
############################################################################################ 

KDInterrupt_SubZero:  
	addi sp, sp, -4				# aloca espaço na pilha
	sw ra, 0(sp)				# salva ra na pilha
	
	csrrci zero,0,1     			# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
        
SWITCH_CASE_TECLA_SubZero: 				
	li t3, 'd'
	beq t3, t2, DIREITA_SubZero		# verifica se a tecla pressionada é 'd'
	
	li t3, 'a'
	beq t3, t2, ESQUERDA_SubZero
	
	li t3, 'w'
AQUI2_SubZero:	beq t3, t2, PULAR_CIMA_SubZero
	
AQUI3_SubZero:	li t3, 's'
	beq t3, t2, ABAIXAR_SubZero
	
	li t3, 'x'
    	beq t3, t2, CHUTE_SubZero        	#verifica se a tecla pressionada é 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO_SubZero
    	
    	li t3, 'z'
        beq t3, t2, CHUTE_ALTO_SubZero
        
        li t3, 'v'
        beq t3, t2, JAB_SubZero
        
        li t3, 'f'
        beq t3, t2, BLOCK_SubZero
        
        li t3, 'e'
        beq t3, t2, CAMBALHOTA_PRA_FRENTE_SubZero
        
        li t3, 'q'
        beq t3, t2, CAMBALHOTA_PRA_TRAS_SubZero
        
        li t3, ' '
        beq t3, t2, PODER_SubZero
        li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado

	j Fim_KDInterrupt_SubZero		# Se não for nenhuma dessas não faz nada
###########################################################################################		
DIREITA_SubZero:
	la t0, SubZeroAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	li a3, 0				# inicializa o deslocamento em 0
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA
	bnez a0, LIMITE_DIREITA_SubZero		# verifica se o contador atingiu o limite
	
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	
SUBZERO_PRA_FRENTE_SubZero:
	li a3, 4
	
LIMITE_DIREITA_SubZero:
	#addi t1, t1, -1
	la a0, SubZeroAndando_1			# move pra frente
	
	j CAMINHAR_SubZero
###########################################################################################
ESQUERDA_SubZero:
	la t0, SubZeroAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero

	la t0, CONTADORH1
	lw t1, 0(t0)
	li a3, 0
	addi t1, t1, -1
	jal ra, VERIFICA_CONTADOR_ESQUERDA
	bnez a0, LIMITE_ESQUERDA_SubZero		# verifica se o contador atingiu o limite
	sw t1, 0(t0)
	
SUBZERO_PRA_TRAS_SubZero: 
	li a3, -4
LIMITE_ESQUERDA_SubZero:
	#addi t1, t1, 1
	
	la a0, SubZeroAndando_3V		# move pra trás
	j CAMINHAR_SubZero
	
##########################################################################################	
PULAR_CIMA_SubZero:	
	la t0, SubZeroParado_1			# se estiver parado tem que pular
	beq t0, s10, SUBZERO_PARA_CIMA_SubZero
	
	la t0, SubZeroAgachando_2		# se estiver agachado tem que levantar
	beq t0, s10, LEVANTAR_SubZero

SUBZERO_PARA_CIMA_SubZero:
	la s10, SubZeroParado_1			# garante que em s10 tenha ele parado
	la a0, SubZeroPulando_1			# carrega o sprite do pulo
	li a3, -9600				# desloca 30 pixels para cima
	li a2, 2				# o pulo são 2 frames
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação do pulo
	
	la a0, SubZeroPulando_2			# prepara o reset
	li a3, 9600				# desloca 30 pixels pra baixo
	
	li a2, 2				# a2 já é 2 (2 frames")
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a animação dele descendo
	j RESET_SubZero
###########################################################################################	
LEVANTAR_SubZero: 
	la s10, SubZeroParado_1			# faz com que s10 tenha ele parado
	la a0, SubZeroAgachando_3V		# carrega o sprite dele agaixado
	li a2, 1				# 1 frame
	jal ra, FRAME_GOLPE_VGA			# animação
	j RESET_SubZero
###########################################################################################
ABAIXAR_SubZero:
	la t0, SubZeroAgachando_2		# se já estiver abaixado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero		
	
	la t0, SubZeroParado_1			# se estiver em pé tem que abaixar
	beq t0, s10, AGACHAR_SubZero

AGACHAR_SubZero:
	#li a3, 4800				# desloca 15 pixels para baixo
	la a0, SubZeroAgachando_1		# carrega o sprite abaixando
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação
	la s10, SubZeroAgachando_2		# seta ele a
	j Fim_KDInterrupt_SubZero

###########################################################################################
CHUTE_SubZero:
SWITCH_CASE_PERSONAGEM_CHUTE_SubZero:

    	la t0, SubZeroParado_1
   	beq t0, s10, SUBZERO_CHUTE_SubZero      # se estiver em pé chuta
   	
   	la t0, SubZeroAgachando_2		# se estiver abaixado dá outro chute
	beq t0, s10, CHUTE_ABAIXADO_SubZero
	
SUBZERO_CHUTE_SubZero:
	li a2, 5				# são 3 frames
    	la a0, SubZeroChuteBaixo_1			
    	j GOLPE_SubZero				# animação
    	
CHUTE_ABAIXADO_SubZero:   
	li a2, 5				# são 3 frames
    	la a0, SubZeroChuteAgachado_1			
    	jal ra, FRAME_GOLPE_VGA			# animação
    	
   	mv a0, s10				# reseta ele agachado
   	li a2, 1				# 1 frame
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_SubZero
SOCO_SubZero:
SWITCH_CASE_PERSONAGEM_SOCO_SubZero:
    	la t0, SubZeroParado_1
    	beq t0, s10, SUBZERO_SOCO_SubZero       # Se estiver em pé dá um soco
    	
    	la t0, SubZeroAgachando_2		# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, SOCO_ABAIXADO_SubZero

SUBZERO_SOCO_SubZero:
	li a2, 5				# são 2 frames
   	la a0, SubZeroSoco_1
   	j GOLPE_SubZero				# animação
 
SOCO_ABAIXADO_SubZero:
	li a2, 3				# são 3 frames
   	la a0, SubZeroSocoAgachado_1
   	jal ra, FRAME_GOLPE_VGA			# animação
   	
   	mv a0, s10				# reseta pra ele
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_SubZero
    	
CHUTE_ALTO_SubZero:
SWITCH_CASE_PERSONAGEM_CHUTE_ALTO_SubZero:
        la t0, SubZeroParado_1
        beq t0, s10, SUBZERO_CHUTE_ALTO_SubZero         # PERSONAGEM 1 É O SUBZERO
        
        la t0, SubZeroAgachando_2		# Se estiver abaixado dá outro tipo de soco
	beq t0, s10, RASTEIRA_SubZero

SUBZERO_CHUTE_ALTO_SubZero:
	li a2, 6
       	la a0, SubZeroChuteAlto_1
       	j GOLPE_SubZero

RASTEIRA_SubZero:
	li a2, 5
       	la a0, SubZeroRasteira_1
       	jal ra, FRAME_GOLPE_VGA			# animação
    	
    	la a0, SubZeroAgachando_2
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# animação
    	j Fim_KDInterrupt_SubZero

JAB_SubZero:
SWITCH_CASE_PERSONAGEM_JAB_SubZero:
        la t0, SubZeroParado_1
        beq t0, s10, SUBZERO_JAB_SubZero        # PERSONAGEM 1 É O SUBZERO
        
        la t0, SubZeroAgachando_2
        beq t0, s10, ALPISTE_ORH_SubZero        # PERSONAGEM 1 É O SUBZERO

SUBZERO_JAB_SubZero:
	li a2, 5
       	la a0, SubZeroJab_1
       	j GOLPE_SubZero

ALPISTE_ORH_SubZero: 
       	li a2, 6
       	la a0, SubZeroAlpiste_1
       	jal ra, FRAME_GOLPE_VGA			# animação
       	
    	la s10, SubZeroParado_1
    	mv a0, s10
   	j RESET_SubZero
    	
BLOCK_SubZero:
	la t0, SubZeroBlock_2			# block ativo
	beq t0, s10, DESATIVAR_BLOCK_SubZero
	
	la t0, SubZeroBlockAgachado_2		# block ativo
	beq t0, s10, DESATIVAR_BLOCK_CHAO_SubZero
	
	la t0, SubZeroAgachando_2		# se estiver abaixado ativa block no chao
	beq t0, s10, BLOCK_CHAO_SubZero

ATIVAR_BLOCK_SubZero:
	la s10, SubZeroBlock_2			# significa que o personagem ficará com escudo ativo
	la a0, SubZeroBlock_1
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação de block
	j Fim_KDInterrupt_SubZero
	
BLOCK_CHAO_SubZero:
	la s10, SubZeroBlockAgachado_2		# significa que o personagem ficará com block no chão ativo
	la a0, SubZeroBlockAgachado_1
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# animação
	j Fim_KDInterrupt_SubZero
	
DESATIVAR_BLOCK_SubZero:
	la t0, SubZeroBlockAgachado_2
	beq t0, s10, DESATIVAR_BLOCK_CHAO_SubZero	#block chao ativo
	
	mv a0, s10				# se chegou até aqui é porque está em pé
	la s10, SubZeroParado_1			# significa que o personagem ficará em pé
	li a2, 2				# são 2 frames
	jal ra, FRAME_GOLPE_VGA			# a0 tem o estado anterior de s10, anima a0
	j RESET_SubZero
			
DESATIVAR_BLOCK_CHAO_SubZero:
	mv a0, s10
	la s10, SubZeroAgachando_2
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, SubZeroAgachando_2
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	j Fim_KDInterrupt_SubZero
	
CAMBALHOTA_PRA_FRENTE_SubZero:	
	la t0, SubZeroAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero

	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j CAMBALHOTA_SubZero
	
CAMBALHOTA_PRA_TRAS_SubZero: 
	la t0, SubZeroAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero

	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra trás
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra trás
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
CAMBALHOTA_SubZero:
	la s10, SubZeroParado_1			# garante que em s10 tenha ele parado
	la a0, SubZeroCambalhota_1		# carrega o sprite da cambalhota
	lw a3, 0(sp)
	
	li s4, 0				# contador
	li s3, 4				# limite do contador
	
LOOP_CAMBALHOTA_SUBINDO_SubZero:
	li a2, 1				# a cambalhota são 2 frames
	jal ra, CONTROLE_SUBINDO_SubZero	
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_SubZero
	
	lw a3, 4(sp)
	
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_SubZero:	
	li a2, 1				# a cambalhota são 2 frames
	jal ra, CONTROLE_DESCENDO_SubZero
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a animação da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_SubZero 
	
	addi sp, sp, 8
	j RESET_SubZero
	
CONTROLE_SUBINDO_SubZero:
	la t0, CONTADORH1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_SUBINDO_SubZero
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_SubZero
	
NAO_S_SubZero:	sw t1, 0(t0)	
	ret

CONTROLE_DESCENDO_SubZero:
	la t0, CONTADORH1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_DESCENDO_SubZero
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_SubZero
	
NAO_D_SubZero:	sw t1, 0(t0)	
	ret	
			
LIMITE_DIREITA_CAMBALHOTA_SUBINDO_SubZero:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_SubZero
	
LIMITE_DIREITA_CAMBALHOTA_DESCENDO_SubZero:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_SubZero
	
LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_SubZero:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_SubZero

LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_SubZero:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_SubZero
							
PODER_SubZero:
	la t0, SubZeroAgachando_2		# se estiver agachado não faz nada
	beq t0, s10, Fim_KDInterrupt_SubZero

	la a0, SubZeroPoder_1			# carrega o sprite do poder
	li a2, 3				# são 3 frames na ida
	jal ra, FRAME_GOLPE_VGA
	
	mv t0, a0				# backup de a0
   	li a0, 50				# DELAY DE 50 MICROSSEGUNDOS
   	li a7, 32
   	ecall					# SLEEP
    	mv a0, t0
	
	li a2, 2				# são 2 frames na volta (desfazer pose)
	jal ra, FRAME_GOLPE_VGA
	
	j RESET_SubZero				# reseta ele parado em pé
############################################################################################
#Esse loop é responsável por realizar a animação do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs_SubZero: Apagar é chamado aqui seguido de Personagem para que uma animção ocorra
#
#Ao término do loop o personagem se desloca 16 pixels
############################################################################################
CAMINHAR_SubZero:	
	li a2, 3				# quantidade de frames
	jal ra, FRAME_DESLOCAMENTO_VGA	
	li a2, 1
	la a0, SubZeroParado_1
	jal ra, FRAME_DESLOCAMENTO_VGA
	j Fim_KDInterrupt_SubZero
	
RESET_SubZero:	la a0, SubZeroParado_1		# posição padrão
	li a2, 1				# contagem de frames
	jal ra, FRAME_GOLPE_VGA			# a golpe não desloca o personagem 
	j Fim_KDInterrupt_SubZero
	
GOLPE_SubZero:
    	jal ra, FRAME_GOLPE_VGA			# animação do golpe
    	jal ra, TESTE_SOCO
    	la a0, SubZeroParado_1			# reseta ele parado
    	li a2, 1				# 1 frame
    	jal ra, FRAME_GOLPE_VGA		
    	j Fim_KDInterrupt_SubZero
	
Fim_KDInterrupt_SubZero:
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
	
	lw ra, 0(sp)				# recupera ra
	addi sp, sp, 4				# libera espaço na pilha
	csrrsi zero,0,0x10 			# seta o bit de habilitação de interrupção em ustatus 
	uret					# volta ao programa principal
	
	
