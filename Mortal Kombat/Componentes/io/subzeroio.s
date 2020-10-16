############################################################################################
#Procedimento respons�vel pelo controle do teclado, quando uma tecla � pressionada uma
#interrup��o se inicia. De acordo com a tecla que � pressionada algo pode ou n�o acontecer.
#N�o h� entradas nem sa�das aqui
#
#Obs: Esse procedimento chama dois outros: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0 e s1 s�o alterados	$$$$$$$$
############################################################################################ 

KDInterrupt:  
	addi sp, sp, -4			# aloca espa�o na pilha
AQUI:	sw ra, 0(sp)			# salva ra na pilha
	
	csrrci zero,0,1     		# clear o bit de habilita��o de interrup��o global em ustatus (reg 0)
	li t1,0xFF200000    		# Endere�o de controle do KDMMIO
        lw t2,4(t1)             	# le a tecla
        sw t2,12(t1)            	# escreve no display
        
SWITCH_CASE_TECLA: 				
	li t3, 'd'
	beq t3, t2, DIREITA		# verifica se a tecla pressionada � 'd'
	
	li t3, 'a'
	beq t3, t2, ESQUERDA
	
	li t3, 'w'
AQUI2:	beq t3, t2, PULAR_CIMA
	
AQUI3:	li t3, 's'
	beq t3, t2, ABAIXAR 
	
	li t3, 'x'
    	beq t3, t2, CHUTE        	#verifica se a tecla pressionada � 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO
    	
    	li t3, 'z'
        beq t3, t2, CHUTE_ALTO
        
        li t3, 'v'
        beq t3, t2, JAB
        
        li t3, 'f'
        beq t3, t2, BLOCK
        
        li t3, 'e'
        beq t3, t2, CAMBALHOTA_PRA_FRENTE
        
        li t3, 'q'
        beq t3, t2, CAMBALHOTA_PRA_TRAS
        
        li t3, ' '
        beq t3, t2, PODER
        li t1,0xFF200000    	# Endere�o de controle do KDMMIO
	li t0,0x01       	# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           	# Habilita interrup��o do teclado

	j Fim_KDInterrupt		# Se n�o for nenhuma dessas n�o faz nada
###########################################################################################		
DIREITA:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li a3, 0
	li t2, 19
	addi t1, t1, 1
	bge t1, t2, LIMITE_DIREITA
	
	sw t1, 0(t0)
	
SUBZERO_PRA_FRENTE:
	li a3, 4
	addi t1, t1, -1
	
LIMITE_DIREITA:
	la t0, SubZeroAgachando2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt
	la a0, SubZeroMov1F			# move pra frente
	
	j CAMINHAR
###########################################################################################
ESQUERDA:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li a3, 0
	addi t1, t1, -1
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA
	sw t1, 0(t0)
	
SUBZERO_PRA_TRAS: 
	addi t1, t1, 1
	li a3, -4
LIMITE_ESQUERDA:
	la t0, SubZeroAgachando2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt

	la a0, SubZeroMov3FT			# move pra tr�s
	j CAMINHAR 
	
##########################################################################################	
PULAR_CIMA:	
	la t0, SubZeroParado1			# se estiver parado tem que pular
	beq t0, s10, SUBZERO_PARA_CIMA
	
	la t0, SubZeroAgachando2		# se estiver agachado tem que levantar
	beq t0, s10, LEVANTAR

SUBZERO_PARA_CIMA:
	la s10, SubZeroParado1			# garante que em s10 tenha ele parado
	la a0, SubZeroPulando1			# carrega o sprite do pulo
	li a3, -9600				# desloca 30 pixels para cima
	li a2, 2				# o pulo s�o 2 frames
	jal ra, FRAME_DESLOCAMENTO			# mostra a anima��o do pulo
	
	la a0, SubZeroPulando2			# prepara o reset
	li a3, 9600				# desloca 30 pixels pra baixo
	#  a2 = 2				# a2 j� � 2 (2 frames")
	jal ra, FRAME_DESLOCAMENTO			# mostra a anima��o dele descendo
	j RESET
###########################################################################################	
LEVANTAR: 
	la s10, SubZeroParado1			# faz com que s10 tenha ele parado
	la a0, SubZeroAgachando1SUBINDO		# carrega o sprite dele agaixado
	li a2, 1				# 1 frame
	jal ra, FRAME_GOLPE			# anima��o
	j RESET
###########################################################################################
ABAIXAR:
	la t0, SubZeroAgachando2		# se j� estiver abaixado n�o faz nada
	beq t0, s10, Fim_KDInterrupt		
	
	la t0, SubZeroParado1			# se estiver em p� tem que abaixar
	beq t0, s10, AGACHAR

AGACHAR:
	#li a3, 4800				# desloca 15 pixels para baixo
	la a0, SubZeroAgachando1		# carrega o sprite abaixando
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE			# anima��o
	la s10, SubZeroAgachando2		# seta ele a
	j Fim_KDInterrupt

###########################################################################################
CHUTE:
SWITCH_CASE_PERSONAGEM_CHUTE:

    	la t0, SubZeroParado1
   	beq t0, s10, SUBZERO_CHUTE        	# se estiver em p� chuta
   	
   	la t0, SubZeroAgachando2		# se estiver abaixado d� outro chute
	beq t0, s10, CHUTE_ABAIXADO
	
SUBZERO_CHUTE:
	li a2, 3				# s�o 3 frames
    	la a0, SubZeroChute1			
    	j GOLPE					# anima��o
    	
CHUTE_ABAIXADO:   
	li a2, 3				# s�o 3 frames
    	la a0, SubZeroChuteAgachado1			
    	jal ra, FRAME_GOLPE			# anima��o
    	
   	mv a0, s10
   	li a2, 1
   	jal ra, FRAME_GOLPE			# anima��o
    	j Fim_KDInterrupt
SOCO:
SWITCH_CASE_PERSONAGEM_SOCO:
    	la t0, SubZeroParado1
    	beq t0, s10, SUBZERO_SOCO        	# Se estiver em p� d� um soco
    	
    	la t0, SubZeroAgachando2		# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, SOCO_ABAIXADO

SUBZERO_SOCO:
	li a2, 2				# s�o 2 frames
   	la a0, SubZeroSocoFraco1
   	j GOLPE					# anima��o
 
SOCO_ABAIXADO:
	li a2, 3				# s�o 3 frames
   	la a0, SubZeroSocoAgachado1
   	jal ra, FRAME_GOLPE			# anima��o
   	
   	mv a0, s10				# reseta pra ele
   	li a2, 1
   	jal ra, FRAME_GOLPE			# anima��o
    	j Fim_KDInterrupt
    	
CHUTE_ALTO:
SWITCH_CASE_PERSONAGEM_CHUTE_ALTO:
        la t0, SubZeroParado1
        beq t0, s10, SUBZERO_CHUTE_ALTO         # PERSONAGEM 1 � O SUBZERO
        
        la t0, SubZeroAgachando2		# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, RASTEIRA

SUBZERO_CHUTE_ALTO:
	li a2, 3
       	la a0, SubZeroChuteAlto1
       	j GOLPE

RASTEIRA:
	li a2, 5
       	la a0, SubZeroRasteira2
       	jal ra, FRAME_GOLPE			# anima��o
    	
    	la a0, SubZeroAgachando2
   	li a2, 1
   	jal ra, FRAME_GOLPE			# anima��o
    	j Fim_KDInterrupt

JAB:
SWITCH_CASE_PERSONAGEM_JAB:
        la t0, SubZeroParado1
        beq t0, s10, SUBZERO_JAB        #PERSONAGEM 1 � O SUBZERO
        
        la t0, SubZeroAgachando2
        beq t0, s10, ALPISTE_ORH        # PERSONAGEM 1 � O SUBZERO

SUBZERO_JAB:
	li a2, 4
       	la a0, SubZeroJab1
       	j GOLPE

ALPISTE_ORH: 
       	li a2, 6
       	la a0, SubZeroAlpiste1
       	jal ra, FRAME_GOLPE			# anima��o
       	
    	la s10, SubZeroParado1
    	mv a0, s10
   	j RESET
    	
BLOCK:
	la t0, SubZeroBlock2			# block ativo
	beq t0, s10, DESATIVAR_BLOCK
	
	la t0, SubZeroBlockAgachado_2		# block ativo
	beq t0, s10, DESATIVAR_BLOCK_CHAO
	
	la t0, SubZeroAgachando2		# se estiver abaixado ativa block no chao
	beq t0, s10, BLOCK_CHAO

ATIVAR_BLOCK:
	la s10, SubZeroBlock2			# significa que o personagem ficar� com escudo ativo
	la a0, SubZeroBlock1
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE			# anima��o de block
	j Fim_KDInterrupt
	
BLOCK_CHAO:
	la s10, SubZeroBlockAgachado_2		# significa que o personagem ficar� com block no ch�o ativo
	la a0, SubZeroBlockAgachado_1
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE			# anima��o
	j Fim_KDInterrupt
	
DESATIVAR_BLOCK:
	la t0, SubZeroBlockAgachado_2
	beq t0, s10, DESATIVAR_BLOCK_CHAO	#block chao ativo
	
	mv a0, s10				# se chegou at� aqui � porque est� em p�
	la s10, SubZeroParado1			# significa que o personagem ficar� em p�
	li a2, 2				# s�o 2 frames
	jal ra, FRAME_GOLPE			# a0 tem o estado anterior de s10, anima a0
	j RESET
			
DESATIVAR_BLOCK_CHAO:
	mv a0, s10
	la s10, SubZeroAgachando2
	li a2, 2
	jal ra, FRAME_GOLPE
	
	la a0, SubZeroAgachando2
	li a2, 1
	jal ra, FRAME_GOLPE
	j Fim_KDInterrupt
	
CAMBALHOTA_PRA_FRENTE:	

	addi sp, sp, -8
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)
	li t0, 7696
	sw t0, 4(sp)
	li s5, 1
	j CAMBALHOTA
	
CAMBALHOTA_PRA_TRAS: 
	addi sp, sp, -8
	li t0, -7696				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)
	li t0, 7664
	sw t0, 4(sp)
	li s5, -1
	
CAMBALHOTA:
	la s10, SubZeroParado1			# garante que em s10 tenha ele parado
	la a0, SubZeroCambalhota_1		# carrega o sprite da cambalhota
	lw a3, 0(sp)
	
	li s2, 0
	li s3, 4
	
LOOP_CAMBALHOTA_SUBINDO:
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, CONTROLE_SUBINDO
	jal ra, FRAME_DESLOCAMENTO		# mostra a anima��o da cambalhota
	addi s2, s2, 1
	blt s2, s3, LOOP_CAMBALHOTA_SUBINDO
	
	lw a3, 4(sp)
	
	li s2, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO:	
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, CONTROLE_DESCENDO
	jal ra, FRAME_DESLOCAMENTO		# mostra a anima��o da cambalhota
	addi s2, s2, 1
	blt s2, s3, LOOP_CAMBALHOTA_DESCENDO 
	
	addi sp, sp, 8
	j RESET
	
CONTROLE_SUBINDO:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_SUBINDO
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO
	
NAO_S:	sw t1, 0(t0)	
	ret

CONTROLE_DESCENDO:
	la t0, CONTADOR1
	lw t1, 0(t0)
	li t2, 19
	add t1, t1, s5
	bge t1, t2, LIMITE_DIREITA_CAMBALHOTA_DESCENDO
	li t2, -1
	beq t1, t2, LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO
	
NAO_D:	sw t1, 0(t0)	
	ret	
			
LIMITE_DIREITA_CAMBALHOTA_SUBINDO:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S
	
LIMITE_DIREITA_CAMBALHOTA_DESCENDO:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D
	
LIMITE_ESQUERDA_CAMBALHOTA_SUBINDO:
	li a3, -7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_S

LIMITE_ESQUERDA_CAMBALHOTA_DESCENDO:
	li a3, 7680
	sub s5, zero, s5
	add t1, t1, s5
	sub s5, zero, s5
	j NAO_D
		
						
PODER:
	la a0, SubZeroPoder1
	li a2, 5
	jal ra, FRAME_GOLPE
	
	j RESET
############################################################################################
#Esse loop � respons�vel por realizar a anima��o do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs: Apagar � chamado aqui seguido de Personagem para que uma anim��o ocorra
#
#Ao t�rmino do loop o personagem se desloca 16 pixels
############################################################################################
CAMINHAR:	
	li a2, 3			# quantidade de frames
	jal ra, FRAME_DESLOCAMENTO	
	li a2, 1
	la a0, SubZeroParado1	
	jal ra, FRAME_DESLOCAMENTO
	j Fim_KDInterrupt
	
RESET:	la a0, SubZeroParado1		# posi��o padr�o
	li a2, 1			# contagem de frames
	jal ra, FRAME_GOLPE		# a golpe n�o desloca o personagem 
	j Fim_KDInterrupt
	
GOLPE:
    	jal ra, FRAME_GOLPE		# anima��o do golpe
    	la a0, SubZeroParado1		# reseta ele parado
    	li a2, 1			# 1 frame
    	jal ra, FRAME_GOLPE		
    	j Fim_KDInterrupt
	
Fim_KDInterrupt:
	li t1,0xFF200000    		# Endere�o de controle do KDMMIO
	li t0,0x02       		# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           		# Habilita interrup��o do teclado

	lw ra, 0(sp)			# recupera ra
	addi sp, sp, 4			# libera espa�o na pilha
	csrrsi zero,0,0x10 		# seta o bit de habilita��o de interrup��o em ustatus 
	uret				# volta ao programa principal
	
	
