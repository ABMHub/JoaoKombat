########################################################################################################################
#Procedimento respons�vel pelo controle do teclado, quando uma tecla � pressionada uma
#interrup��o se inicia. De acordo com a tecla que � pressionada algo pode ou n�o acontecer.
#N�o h� entradas nem sa�das aqui
#
#Obs_SubZero: Esse procedimento chama dois outros_SubZero: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0, s1, s4, s3 e s5 s�o alterados$$$$$$$$
######################################################################################################################## 

KDInterrupt:  
	addi sp, sp, -4				# aloca espa�o na pilha
	sw ra, 0(sp)				# salva ra na pilha
	
	csrrci zero,0,1     			# clear o bit de habilita��o de interrup��o global em ustatus (reg 0)
	li t1,0xFF200000    			# Endere�o de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
        
SWITCH_CASE_TECLA: 				
	li t3, 'd'
	beq t3, t2, L_DIREITA_IO		# verifica se a tecla pressionada � 'd'
	
	li t3, 'a'
	beq t3, t2, L_ESQUERDA_IO
	
	li t3, 'w'
	beq t3, t2, L_CIMA_IO
	
	li t3, 's'
	beq t3, t2, L_BAIXO_IO
	
	li t3, 'x'
    	beq t3, t2, L_CHUTE_1_IO	        	#verifica se a tecla pressionada � 'x'
    	
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
        li t1,0xFF200000    			# Endere�o de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           			# Habilita interrup��o do teclado

	j Fim_KDInterrupt			# Se n�o for nenhuma dessas n�o faz nada
########################################################################################################################
L_DIREITA_IO:
	la t0, AGACHADO_IO			# Carrega o endere�o do ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt		# Se estiver agachado n�o faz nada
	
	la s10, DANCINHA1_IO			# Coloca em s10 o estado atual
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				# t1 = contador
	li a3, 0				# inicializa o deslocamento em 0
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA	# verifica se houve colis�o
	
	beq a0, zero, L_LIMITE_DIREITA_IO	# a0 != 0 => houve colis�o
	sw t1, 0(t0)				# guarda o novo valor do contador somente se n�o houve colis�o
	
	# Se n�o houve colis�o
	li a3, 4				# deslocamento da caminhada
	
L_LIMITE_DIREITA_IO:
	la t0, CAMINHAR_DIREITA_IO 		# se houve colis�o
	lw a0, 0(t0)				# a0 = sprite da caminhada
	
	j CAMINHAR
########################################################################################################################
L_ESQUERDA_IO:

	la t0, AGACHADO					
	beq t0, s10, Fim_KDInterrupt		# se estiver agachado n�o faz nada

	la s10, DANCINHA1_IO			# Coloca em s10 o estado atual
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				# t1 = valor do contador
	li a3, 0				# deslocamento = 0
	addi t1, t1, -1				# subtrai um do contador
	jal ra, VERIFICA_CONTADOR_ESQUERDA	# verifica se houve colis�o
	beq a0, zero L_LIMITE_ESQUERDA_IO		# se a0 = 1 => houve colis�o
	sw t1, 0(t0)				# salva o novo contador somente se n�o houve colis�o
	
	#Se n�o houve colis�o
	li a3, -4					# deslocamento da caminhada

L_LIMITE_ESQUERDA_IO:					# Se houve colis�o
	la t0, ESQUERDA_IO				# move pra tr�s
	lw a0, 0(t0)					# a0 = sprite a ser pintado
	j L_CAMINHAR_IO	
#######################################################################################################################
L_CIMA_IO:	
	la t0, DANCINHA1_IO				# Se estiver em p� tem que pular
	beq t0, s10, L_PULAR_IO
	
	la t0, AGACHADO_IO				# se estiver agachado tem que levantar
	beq t0, s10, L_LEVANTAR_IO
	
L_PULAR_IO:
	# Subindo
	la t0, PULAR_1_IO				# ponteiro do sprite do pulo
	lw a0, 0(t0)					# carrega o sprite do pulo
	li a3, -9600					# desloca 30 pixels para cima
	li a2, 2					# o pulo s�o 2 frames
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a anima��o do pulo
	
	# Descendo
	la t0, PULAR_2_IO				# ponteiro do sprite da descida do pulo
	lw a0, 0(t0)					# pulo descendo
	li a3, 9600					# desloca 30 pixels pra baixo
	
	li a2, 2					# 2 frames para descida
	jal ra, FRAME_DESLOCAMENTO_VGA			# mostra a anima��o dele descendo
	
	j DANCINHA_IO					# vai para dancinha
	
	# Levantar
L_LEVANTAR_IO: 
	la s10, SubZeroParado_1				# faz com que s10 tenha ele em p�
	la t0, LEVANTAR_IO
	la a0, 0(t0)					# carrega o sprite dele agaixado
	li a2, 1					# 1 frame
	
	j L_GOLPE_IO
#######################################################################################################################
L_BAIXO_IO:
	la t0, AGACHADO					# Ponteiro para agachado
	beq t0, s10, Fim_KDInterrupt			# Se j� estiver agachado n�o faz nada			
	
	la t0, DANCINHA1_IO				# Ponteiro para dancinha
	beq t0, s10, L_AGACHAR_IO			# se estiver em p� tem que abaixar

L_AGACHAR_IO:
	la t0, AGACHANDO_IO				# carrega o sprite abaixando
	li a2, 2					# s�o 2 frames
	#li a3, 0					# deslocamento 0
	#jal ra, FRAME_DESLOCAMENTO_VGA			# anima��o
	#la s10, AGACHADO_IO				# coloca "agachado" no estado atual
	
	#lw a0, 0(s10)					# a0 = sprite dele agachado 
	#jal ra, FRAME_DANCINHA				# pinta esse sprite na outra frame
	
	j L_GOLPE_IO
	
	#j Fim_KDInterrupt_SubZero
#######################################################################################################################
L_CHUTE_1_IO:
    	la t0, DANCINHA1_IO
   	beq t0, s10, L_CHUTE_1_EM_PE	     	 	# se estiver em p� chuta
   	
   	la t0, AGACHADO_IO				# se estiver abaixado d� outro tipo de chute
	beq t0, s10, L_CHUTE_1_AGACHADO
	
L_CHUTE_1_EM_PE:
	li a2, 5					# s�o 5 frames
	
	# Faz algo obscuro LUCAS
	li a1, 2					#???????????????????????????????????????
    	jal ra, TESTE_GOLPE				#???????????????????????????????????????
    	
    	la t0, CHUTE_1_EM_PE_IO				# ponteiro do chute 1 normal 
    	lw a0, 0(t0)					# a0 = chute 1 normal
    	j L_GOLPE_IO						# anima��o
    	
L_CHUTE_1_AGACHADO:   
	li a2, 5					# s�o 5 frames
    	la t0, CHUTE_2_AGACHADO_IO			# ponteiro do chute 1 agachado
    	lw a0, 0(t0)					# a0 = chute 1 agachado	
    	
    	j L_GOLPE_IO
#######################################################################################################################
L_SOCO_1_IO:
    	la t0, DANCINHA1_IO				# ponteiro da dancinha
    	beq t0, s10, L_SOCO_1_EM_PE		       	# Se estiver em p� d� um soco
    	
    	la t0, AGACHADO_IO				# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, L_SOCO_1_AGACHADO

L_SOCO_1_EM_PE:
	li a2, 5					# s�o 2 frames
   	la t0, SOCO_1_EM_PE_IO				# ponteiro do soco 1 em p�
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	li a1, 0					#???????????????????????????????????????
    	jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IO						# anima��o
 
L_SOCO_1_AGACHADO:
	li a2, 3					# s�o 3 frames
   	la t0, SOCO_1_AGACHADO_IO			# ponteiro do soco 1 agachado
   	lw a0, 0(t0)					# sprite do soco 1 agachado
   	j L_GOLPE_IO			
    	
#######################################################################################################################
L_CHUTE_2_IO:
        la t0, DANCINHA1_IO				# Ponteiro da dancinha	
        beq t0, s10, L_CHUTE_2_EM_PE_IO		        # Se estiver em p� d� um tipo de soco
        
        la t0, AGACHADO_IO				# Ponteiro agachado				
	beq t0, s10, L_CHUTE_2_AGACHADO_IO		# Se estiver abaixado d� outro tipo de soco

L_CHUTE_2_EM_PE_IO:
	li a2, 6					# s�o 6 frames
       	la t0, CHUTE_2_EM_PE_IO				# ponteiro do sprite
       	lw a0, 0(t0)					# a0 = sprite 
       	
       	# Faz coisas obscuras LUCAS		
       	li a1, 3					#??????????????????????????????
    	jal ra, TESTE_GOLPE				#??????????????????????????????
    	
       	j L_GOLPE_IO

L_CHUTE_2_AGACHADO_IO:
	li a2, 5					# s�o 5 frames
       	la t0, CHUTE_2_AGACHADO_IO	
       	lw a0, 0(t0)

	j L_GOLPE_IO
#######################################################################################################################
L_SOCO_2_IO:
    	la t0, DANCINHA1_IO				# ponteiro da dancinha
    	beq t0, s10, L_SOCO_2_EM_PE		       	# Se estiver em p� d� um soco
    	
    	la t0, AGACHADO_IO				# Se estiver abaixado d� outro tipo de soco
	beq t0, s10, L_SOCO_2_AGACHADO

L_SOCO_2_EM_PE:
	li a2, 5					# s�o 2 frames
   	la t0, SOCO_2_EM_PE_IO				# ponteiro do soco 1 em p�
   	lw a0, 0(t0)
   	
   	#Faz coisas obscuras LUCAS
   	li a1, 0					#???????????????????????????????????????
    	jal ra, TESTE_GOLPE				#???????????????????????????????????????
   	
   	j L_GOLPE_IO						# anima��o
 
L_SOCO_2_AGACHADO:
	li a2, 6					# s�o 6 frames
   	la t0, SOCO_2_AGACHADO_IO			# ponteiro do soco 1 agachado
   	lw a0, 0(t0)					# sprite do soco 1 agachado
   	j L_GOLPE_IO			
#######################################################################################################################
L_BLOCK_IO:
	la t0, BLOCK_EM_PE_IO				# block ativo em p�
	beq t0, s10, L_DESATIVAR_BLOCK_EM_PE_IO		# Desativa o block
	
	la t0, BLOCK_AGACHADO_IO			# block ativo agachado
	beq t0, s10, L_DESATIVAR_BLOCK_AGACHADO_IO	# Desativa o block agachado
	
	la t0, AGACHADO_IO				# se estiver abaixado ativa block no chao
	beq t0, s10, L_BLOCK_AGACHADO_IO

	# Se chegou at� aqui ativa o block em p�
	
L_BLOCK_EM_PE_IO:
	la s10, BLOCK_EM_PE_IO				# significa que o personagem ficar� com escudo ativo
	
	la t0, BLOCK_EM_PE_IO
	lw a0, 0(t0)
	li a2, 2					# s�o 2 frames
	
	j L_GOLPE_IO
	
L_BLOCK_AGACHADO_IO:
	la s10, BLOCK_AGACHADO_IO		# significa que o personagem ficar� com block no ch�o ativo
	la t0, BLOCK_AGACHADO_IO		
	lw a0, 0(t0)				# a0 = sprite do bloco agachado
	li a2, 2				# s�o 2 frames
	
	j L_GOLPE_IO
	
L_DESATIVAR_BLOCK_EM_PE_IO:
	la s10, DANCINHA1_IO
	
	la t0, BLOCK_EM_PE_IO
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 2				# s�o 2 frames
	j L_GOLPE_IO
			
L_DESATIVAR_BLOCK_AGACHADO_IO:
	la s10, AGACHADO_IO
	
	la t0, BLOCK_AGACHADO_IO
	lw a0, 0(t0)				# a0 = sprite dele com block
	li a2, 2				# s�o 2 frames
	j L_GOLPE_IO

#######################################################################################################################
L_CAMBALHOTA_PRA_FRENTE_IO:	
	la t0, AGACHADO_IO			# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt

	# prepara��o
	addi sp, sp, -8				# aloca 2 words
	li t0, -7664				# desloca 28 pixels para cima e 32 pra frente
	sw t0, 0(sp)				# salva o deslocamento na pilha
	li t0, 7696				# desloca 28 pixels para baixo e 32 para frente
	sw t0, 4(sp)				# aloca na pilha
	li s5, 1				# constante referente ao limite da borda
	j L_CAMBALHOTA_IO
	
L_CAMBALHOTA_PRA_TRAS_IO: 
	la t0, AGACHADO_IO			# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt

	# Prepara��o
	addi sp, sp, -8				# aloca 2 words
	li t0, -7696				# desloca 28 pixels para cima e 32 pra tr�s
	sw t0, 0(sp)				# salva na pilha
	li t0, 7664				# desloca 28 pixels para baixo e 32 pra tr�s
	sw t0, 4(sp)				# salva o deslocamento na pilha
	li s5, -1				# constante referente ao limite da borda
		
L_CAMBALHOTA_IO:
	la t0, CAMBALHOTA1_IO			# carrega o sprite da cambalhota
	lw a0, 0(t0)
	lw a3, 0(sp)
	li s4, 0				# contador
	li s3, 3				# limite do contador
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, L_CONTROLE_SUBINDO_IO	
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a anima��o da cambalhota
	
LOOP_CAMBALHOTA_SUBINDO_IO:
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, L_CONTROLE_SUBINDO_IO	
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a anima��o da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_SUBINDO_IO
	
	lw a3, 4(sp)
	li s4, 0
	li s3, 4
		
LOOP_CAMBALHOTA_DESCENDO_IO:	
	li a2, 1				# a cambalhota s�o 2 frames
	jal ra, L_CONTROLE_DESCENDO_IO
	jal ra, FRAME_DESLOCAMENTO_VGA		# mostra a anima��o da cambalhota
	addi s4, s4, 1
	blt s4, s3, LOOP_CAMBALHOTA_DESCENDO_IO
	
	addi sp, sp, 8
	j L_TOTAL_RESET_IO
	
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

	la t0, AGACHADO_IO			# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt

	la a0, PODER_IO				# carrega o sprite do poder
	li a2, 5				# s�o 5 frames na ida
	jal ra, FRAME_GOLPE_VGA
	
	j L_GOLPE_IO
#######################################################################################################################
L_CAMINHAR_IO:

	li a2, 3				# quantidade de frames
	jal ra, FRAME_DESLOCAMENTO_VGA

L_TOTAL_RESET_EM_PE_IO:	
	li a2, 1
	la t0, DANCINHA1_IO
	lw a0, 0(t0)
	jal ra, FRAME_DESLOCAMENTO_VGA
	
	la t0, DANCINHA2_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt
	
L_GOLPE_IO:
	jal ra, FRAME_GOLPE_VGA			# anima��o do golpe
	la t0, DANCINHA1_IO
	beq t0, s10, L_TOTAL_RESET_EM_PE_IO
	
L_TOTAL_RESET_AGACHADO_IO:	
	li a2, 1
	la t0, AGACHADO_IO
	lw a0, 0(t0)
	jal ra, FRAME_DESLOCAMENTO_VGA
	
	la t0, AGACHADO_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	j Fim_KDInterrupt

Fim_KDInterrupt:
	li t1,0xFF200000    			# Endere�o de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           			# Habilita interrup��o do teclado
	
	lw ra, 0(sp)				# recupera ra
	addi sp, sp, 4				# libera espa�o na pilha
	csrrsi zero,0,0x10 			# seta o bit de habilita��o de interrup��o em ustatus 
	uret					# volta ao programa principal
	
	