############################################################################################
#Procedimento respons�vel pelo controle do teclado, quando uma tecla � pressionada uma
#interrup��o se inicia. De acordo com a tecla que � pressionada algo pode ou n�o acontecer.
#N�o h� entradas nem sa�das aqui
#
#Obs_Scorpion: Esse procedimento chama dois outros_Scorpion: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0, s1, s4, s3 e s5 s�o alterados$$$$$$$$
############################################################################################ 

KDInterrupt_Scorpion:  
	addi sp, sp, -4				# aloca espa�o na pilha
	sw ra, 0(sp)				# salva ra na pilha
	
	csrrci zero,0,1     			# clear o bit de habilita��o de interrup��o global em ustatus (reg 0)
	li t1,0xFF200000    			# Endere�o de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
        
SWITCH_CASE_TECLA_Scorpion: 				
	li t3, 'd'
	beq t3, t2, DIREITA_Scorpion		# verifica se a tecla pressionada � 'd'
	
	li t3, 'a'
	beq t3, t2, ESQUERDA_Scorpion
	
	li t3, 'w'
AQUI2_Scorpion:	beq t3, t2, PULAR_CIMA_Scorpion
	
AQUI3_Scorpion:	li t3, 's'
	beq t3, t2, ABAIXAR_Scorpion
	
	li t3, 'x'
    	beq t3, t2, CHUTE_Scorpion        	#verifica se a tecla pressionada � 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO_Scorpion
    	
    	li t3, 'z'
        beq t3, t2, CHUTE_ALTO_Scorpion
        
        li t3, 'v'
        beq t3, t2, JAB_Scorpion
        
        li t3, 'f'
        beq t3, t2, BLOCK_Scorpion
        
        li t3, 'e'
        beq t3, t2, CAMBALHOTA_PRA_FRENTE_Scorpion
        
        li t3, 'q'
        beq t3, t2, CAMBALHOTA_PRA_TRAS_Scorpion
        
        li t3, ' '
        beq t3, t2, PODER_Scorpion
        li t1,0xFF200000    			# Endere�o de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           			# Habilita interrup��o do teclado

	j Fim_KDInterrupt_Scorpion		# Se n�o for nenhuma dessas n�o faz nada
###########################################################################################		
DIREITA_Scorpion:
	la t0, ScorpionAgachando_2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion

	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	li a3, 0				# inicializa o deslocamento em 0
	li t2, 19				# m�ximo do contador
	addi t1, t1, 1				# incrementa o contador
	bge t1, t2, LIMITE_DIREITA_Scorpion	# verifica se o contador atingiu o limite
	
	sw t1, 0(t0)				# guarda o novo valor do contador somente se n�o estiver no limite
	
SCORPION_PRA_FRENTE_Scorpion:
	li a3, 4
	
LIMITE_DIREITA_Scorpion:
	#addi t1, t1, -1
	la a0, ScorpionAndando_1			# move pra frente
	
	j CAMINHAR_Scorpion
###########################################################################################
ESQUERDA_Scorpion:
	la t0, ScorpionAgachando_2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion

	la t0, CONTADORH1
	lw t1, 0(t0)
	li a3, 0
	addi t1, t1, -1
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_Scorpion
	sw t1, 0(t0)
	
SCORPION_PRA_TRAS_Scorpion: 
	li a3, -4
LIMITE_ESQUERDA_Scorpion:
	#addi t1, t1, 1
	
	la a0, ScorpionAndando_3V		# move pra tr�s
	j CAMINHAR_Scorpion
	
##########################################################################################	
PULAR_CIMA_Scorpion:	
	la t0, ScorpionParado_1			# se estiver parado tem que pular
	beq t0, s10, SCORPION_PARA_CIMA_Scorpion
	
	la t0, ScorpionAgachando_2		# se estiver agachado tem que levantar
	beq t0, s10, LEVANTAR_Scorpion

SCORPION_PARA_CIMA_Scorpion:
	la s10, ScorpionParado_1			# garante que em s10 tenha ele parado
	la a0, ScorpionPulando_1			# carrega o sprite do pulo
	li a3, -9600				# desloca 30 pixels para cima
	li a2, 2				# o pulo s�o 2 frames
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a anima��o do pulo
	
	la a0, ScorpionPulando_2			# prepara o reset
	li a3, 9600				# desloca 30 pixels pra baixo
	
	li a2, 2				# a2 j� � 2 (2 frames")
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a anima��o dele descendo
	j RESET_Scorpion
###########################################################################################	
LEVANTAR_Scorpion: 
	la s10, ScorpionParado_1			# faz com que s10 tenha ele parado
	la a0, ScorpionAgachando_3V		# carrega o sprite dele agaixado
	li a2, 1				# 1 frame
	jal ra, FRAME_GOLPE_VGA			# anima��o
	j RESET_Scorpion
###########################################################################################
ABAIXAR_Scorpion:
	la t0, ScorpionAgachando_2		# se j� estiver abaixado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion		
	
	la t0, ScorpionParado_1			# se estiver em p� tem que abaixar
	beq t0, s10, AGACHAR_Scorpion

AGACHAR_Scorpion:
	#li a3, 4800				# desloca 15 pixels para baixo
	la a0, ScorpionAgachando_1		# carrega o sprite abaixando
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE_VGA			# anima��o
	la s10, ScorpionAgachando_2		# seta ele a
	j Fim_KDInterrupt_Scorpion

###########################################################################################
CHUTE_Scorpion:
SWITCH_CASE_PERSONAGEM_CHUTE_Scorpion:

    	la t0, ScorpionParado_1
   	beq t0, s10, SCORPION_CHUTE_Scorpion      # se estiver em p� chuta
   	
   	la t0, ScorpionAgachando_2		# se estiver abaixado d� outro chute
	beq t0, s10, CHUTE_ABAIXADO_Scorpion
	
SCORPION_CHUTE_Scorpion:
	li a2, 5				# s�o 3 frames
    	la a0, ScorpionChuteBaixo_1			
    	j GOLPE_Scorpion				# anima��o
    	
CHUTE_ABAIXADO_Scorpion:   
	li a2, 5				# s�o 3 frames
    	la a0, ScorpionChuteAgachado_1			
    	jal ra, FRAME_GOLPE_VGA			# anima��o
    	
   	mv a0, s10				# reseta ele agachado
   	li a2, 1				# 1 frame
   	jal ra, FRAME_GOLPE_VGA			# anima��o
    	j Fim_KDInterrupt_Scorpion
SOCO_Scorpion:
SWITCH_CASE_PERSONAGEM_SOCO_Scorpion:
    	la t0, ScorpionParado_1
    	beq t0, s10, SCORPION_SOCO_Scorpion       # Se estiver em p� d� um soco
    	
    	la t0, ScorpionAgachando_2		# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, SOCO_ABAIXADO_Scorpion

SCORPION_SOCO_Scorpion:
	li a2, 5				# s�o 2 frames
   	la a0, ScorpionSoco_1
   	j GOLPE_Scorpion				# anima��o
 
SOCO_ABAIXADO_Scorpion:
	li a2, 3				# s�o 3 frames
   	la a0, ScorpionSocoAgachado_1
   	jal ra, FRAME_GOLPE_VGA			# anima��o
   	
   	mv a0, s10				# reseta pra ele
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# anima��o
    	j Fim_KDInterrupt_Scorpion
    	
CHUTE_ALTO_Scorpion:
SWITCH_CASE_PERSONAGEM_CHUTE_ALTO_Scorpion:
        la t0, ScorpionParado_1
        beq t0, s10, SCORPION_CHUTE_ALTO_Scorpion         # PERSONAGEM 1 � O SCORPION
        
        la t0, ScorpionAgachando_2		# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, RASTEIRA_Scorpion

SCORPION_CHUTE_ALTO_Scorpion:
	li a2, 6
       	la a0, ScorpionChuteAlto_1
       	j GOLPE_Scorpion

RASTEIRA_Scorpion:
	li a2, 5
       	la a0, ScorpionRasteira_1
       	jal ra, FRAME_GOLPE_VGA			# anima��o
    	
    	la a0, ScorpionAgachando_2
   	li a2, 1
   	jal ra, FRAME_GOLPE_VGA			# anima��o
    	j Fim_KDInterrupt_Scorpion

JAB_Scorpion:
SWITCH_CASE_PERSONAGEM_JAB_Scorpion:
        la t0, ScorpionParado_1
        beq t0, s10, SCORPION_JAB_Scorpion        # PERSONAGEM 1 � O SCORPION
        
        la t0, ScorpionAgachando_2
        beq t0, s10, ALPISTE_ORH_Scorpion        # PERSONAGEM 1 � O SCORPION

SCORPION_JAB_Scorpion:
	li a2, 5
       	la a0, ScorpionJab_1
       	j GOLPE_Scorpion

ALPISTE_ORH_Scorpion: 
       	li a2, 6
       	la a0, ScorpionAlpiste_1
       	jal ra, FRAME_GOLPE_VGA			# anima��o
       	
    	la s10, ScorpionParado_1
    	mv a0, s10
   	j RESET_Scorpion
    	
BLOCK_Scorpion:
	la t0, ScorpionBlock_2			# block ativo
	beq t0, s10, DESATIVAR_BLOCK_Scorpion
	
	la t0, ScorpionBlockAgachado_2		# block ativo
	beq t0, s10, DESATIVAR_BLOCK_CHAO_Scorpion
	
	la t0, ScorpionAgachando_2		# se estiver abaixado ativa block no chao
	beq t0, s10, BLOCK_CHAO_Scorpion

ATIVAR_BLOCK_Scorpion:
	la s10, ScorpionBlock_2			# significa que o personagem ficar� com escudo ativo
	la a0, ScorpionBlock_1
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE_VGA			# anima��o de block
	j Fim_KDInterrupt_Scorpion
	
BLOCK_CHAO_Scorpion:
	la s10, ScorpionBlockAgachado_2		# significa que o personagem ficar� com block no ch�o ativo
	la a0, ScorpionBlockAgachado_1
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE_VGA			# anima��o
	j Fim_KDInterrupt_Scorpion
	
DESATIVAR_BLOCK_Scorpion:
	la t0, ScorpionBlockAgachado_2
	beq t0, s10, DESATIVAR_BLOCK_CHAO_Scorpion	#block chao ativo
	
	mv a0, s10				# se chegou at� aqui � porque est� em p�
	la s10, ScorpionParado_1			# significa que o personagem ficar� em p�
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE_VGA			# a0 tem o estado anterior de s10, anima a0
	j RESET_Scorpion
			
DESATIVAR_BLOCK_CHAO_Scorpion:
	mv a0, s10
	la s10, ScorpionAgachando_2
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ScorpionAgachando_2
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	j Fim_KDInterrupt_Scorpion
	
CAMBALHOTA_PRA_FRENTE_Scorpion:	
	la t0, ScorpionAgachando_2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion

	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j CAMBALHOTA_Scorpion
	
CAMBALHOTA_PRA_TRAS_Scorpion: 
	la t0, ScorpionAgachando_2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion

	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra tr�s
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra tr�s
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
CAMBALHOTA_Scorpion:
	la s10, ScorpionParado_1			# garante que em s10 tenha ele parado
	la a0, ScorpionCambalhota_1		# carrega o sprite da cambalhota
	lw a3, 0(sp)
	
	li s4, 0				# contador
	li s3, 4				# limite do contador
	
LOOP_CAMBALHOTA_SUBINDO_Scorpion:
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, CONTROLE_SUBINDO_Scorpion	
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a anima��o da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_Scorpion
	
	lw a3, 4(sp)
	
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_Scorpion:	
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, CONTROLE_DESCENDO_Scorpion
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a anima��o da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_Scorpion 
	
	addi sp, sp, 8
	j RESET_Scorpion
	
CONTROLE_SUBINDO_Scorpion:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_SUBINDO_Scorpion
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_Scorpion
	
NAO_S_Scorpion:	sw t1, 0(t0)	
	ret

CONTROLE_DESCENDO_Scorpion:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_DESCENDO_Scorpion
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_Scorpion
	
NAO_D_Scorpion:	sw t1, 0(t0)	
	ret	
			
LIMITE_DIREITA_CAMBALHOTA_SUBINDO_Scorpion:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_Scorpion
	
LIMITE_DIREITA_CAMBALHOTA_DESCENDO_Scorpion:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_Scorpion
	
LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO_Scorpion:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S_Scorpion

LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO_Scorpion:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D_Scorpion
							
PODER_Scorpion:
	la t0, ScorpionAgachando_2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt_Scorpion

	la a0, ScorpionPoder_1			# carrega o sprite do poder
	li a2, 6				# s�o 3 frames na ida
	jal ra, FRAME_GOLPE_VGA
	
	j RESET_Scorpion				# reseta ele parado em p�
############################################################################################
#Esse loop � respons�vel por realizar a anima��o do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs_Scorpion: Apagar � chamado aqui seguido de Personagem para que uma anim��o ocorra
#
#Ao t�rmino do loop o personagem se desloca 16 pixels
############################################################################################
CAMINHAR_Scorpion:	
	li a2, 3				# quantidade de frames
	jal ra, FRAME_DESLOCAMENTO_VGA	
	li a2, 1
	la a0, ScorpionParado_1
	jal ra, FRAME_DESLOCAMENTO_VGA
	j Fim_KDInterrupt_Scorpion
	
RESET_Scorpion:	la a0, ScorpionParado_1		# posi��o padr�o
	li a2, 1				# contagem de frames
	jal ra, FRAME_GOLPE_VGA			# a golpe n�o desloca o personagem 
	j Fim_KDInterrupt_Scorpion
	
GOLPE_Scorpion:
    	jal ra, FRAME_GOLPE_VGA			# anima��o do golpe
    	la a0, ScorpionParado_1			# reseta ele parado
    	li a2, 1				# 1 frame
    	jal ra, FRAME_GOLPE_VGA		
    	j Fim_KDInterrupt_Scorpion
	
Fim_KDInterrupt_Scorpion:
	li t1,0xFF200000    			# Endere�o de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           			# Habilita interrup��o do teclado
	
	lw ra, 0(sp)				# recupera ra
	addi sp, sp, 4				# libera espa�o na pilha
	csrrsi zero,0,0x10 			# seta o bit de habilita��o de interrup��o em ustatus 
	uret					# volta ao programa principal
	
	
