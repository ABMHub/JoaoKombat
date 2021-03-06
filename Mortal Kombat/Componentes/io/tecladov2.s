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
    	beq t3, t2, CHUTE        #verifica se a tecla pressionada � 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO

###########################################################################################		
DIREITA:
SUBZERO_PRA_FRENTE:
	la t0, SubZeroAgachando2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt
	
	la a0, SubZeroMov1F			# move pra frente
	li a3, 4
	j CAMINHAR
###########################################################################################
ESQUERDA:

SUBZERO_PRA_TRAS:
	la t0, SubZeroAgachando2		# se estiver agachado n�o faz nada
	beq t0, s10, Fim_KDInterrupt

	la a0, SubZeroMov3FT			# move pra tr�s
	li a3, -4
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
	jal ra, CAMINHAR_FRAME			# mostra a anima��o do pulo
	
	la a0, SubZeroPulando2			# prepara o reset
	li a3, 9600				# desloca 30 pixels pra baixo
	#  a2 = 2				# a2 j� � 2 (2 frames")
	jal ra, CAMINHAR_FRAME			# mostra a anima��o dele descendo
	j RESET
###########################################################################################	
LEVANTAR: 
	la s10, SubZeroParado1			# faz com que s10 tenha ele parado
	la a0, SubZeroAgachando1SUBINDO		# carrega o sprite dele agaixado
	li a3, -9600
	li a2, 1
	jal ra, CAMINHAR_FRAME
	j RESET
###########################################################################################
ABAIXAR:
	la t0, SubZeroParado1
	beq t0, s10, AGACHAR
	
	la t0, SubZeroAgachando2
	beq t0, s10, Fim_KDInterrupt
	
AGACHAR:
	li a3, 4800
	la a0, SubZeroAgachando1
	li a2, 2
	jal ra, CAMINHAR_FRAME
	la s10, SubZeroAgachando2
	j Fim_KDInterrupt

###########################################################################################
CHUTE:
SWITCH_CASE_PERSONAGEM_CHUTE:
    # checagem de personagens
    	la t0, SubZeroAgachando2
	beq t0, s10, LEVANTAR
    
    	la t0, SubZeroParado1
   	li a2, 3
   	beq t0, s10, SUBZERO_CHUTE        #PERSONAGEM 1 � O SUBZERO
   	
   	la t0, SubZeroAgachando2
	beq t0, s10, CHUTE_ABAIXADO
	
SUBZERO_CHUTE:
    	la a0, SubZeroChute1
    	j GOLPE
    	
CHUTE_ABAIXADO:   
    
SOCO:
SWITCH_CASE_PERSONAGEM_SOCO:
    # checagem de personagens
    	la t0, SubZeroParado1
    	li a2, 2
    	beq t0, s10, SUBZERO_SOCO        #PERSONAGEM 1 � O SUBZERO
    	
    	la t0, SubZeroAgachando2
	beq t0, s10, SOCO_ABAIXADO

SUBZERO_SOCO:
   	la a0, SubZeroSocoFraco1
   	j GOLPE
 
SOCO_ABAIXADO:

	


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
	jal ra, CAMINHAR_FRAME		
	
RESET:	la a0, SubZeroParado1		# posi��o padr�o
	li a2, 1			# contagem de frames
	jal ra, FRAME_GOLPE		# a golpe n�o desloca o personagem 
	j Fim_KDInterrupt
	
GOLPE:
    	jal ra, FRAME_GOLPE

    	la a0, SubZeroParado1
    	li a2, 1
    	jal ra, FRAME_GOLPE
    	j Fim_KDInterrupt
	
Fim_KDInterrupt:
	lw ra, 0(sp)			# recupera ra
	addi sp, sp, 4			# libera espa�o na pilha
	#csrrsi zero,0,0x10 	# seta o bit de habilita��o de interrup��o em ustatus 
	uret				# volta ao programa principal
	
	
