############################################################################################
#Procedimento responsável pelo controle do teclado, quando uma tecla é pressionada uma
#interrupção se inicia. De acordo com a tecla que é pressionada algo pode ou não acontecer.
#Não há entradas nem saídas aqui
#
#Obs: Esse procedimento chama dois outros: APAGAR e PERSONAGEM
#
#			$$$$$$$$ s0 e s1 são alterados	$$$$$$$$
############################################################################################ 

KDInterrupt:  
	addi sp, sp, -4			# aloca espaço na pilha
AQUI:	sw ra, 0(sp)			# salva ra na pilha
	
	csrrci zero,0,1     		# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	li t1,0xFF200000    		# Endereço de controle do KDMMIO
        lw t2,4(t1)             	# le a tecla
        sw t2,12(t1)            	# escreve no display
        
SWITCH_CASE_TECLA: 				
	li t3, 'd'
	beq t3, t2, DIREITA		# verifica se a tecla pressionada é 'd'
	
	li t3, 'a'
	beq t3, t2, ESQUERDA
	
	li t3, 'x'
    	beq t3, t2, CHUTE        #verifica se a tecla pressionada é 'x'
    	
    	li t3, 'c'
    	beq t3, t2, SOCO

		
DIREITA:
SWITCH_CASE_PERSONAGEM_CAMINHAR_FRENTE:
    	# checagem de personagens
    	li t0, 0
    	beq t0, s10, SUBZERO_PRA_FRENTE        #PERSONAGEM 1 É O SUBZERO

SUBZERO_PRA_FRENTE:
	la a0, SubZeroMov1F
	li a3, 4
	j CAMINHAR
SCORPION:
	#la a0, SCORPION1	
	#Frame 1


ESQUERDA:
SWITCH_CASE_PERSONAGEM_CAMINHAR_TRAS:
    	# checagem de personagens
    	li t0, 0
    	beq t0, s10, SUBZERO_PRA_TRAS        #PERSONAGEM 1 É O SUBZERO

SUBZERO_PRA_TRAS:
	la a0, SubZeroMov3FT
	li a3, -4
	j CAMINHAR 

CHUTE:
SWITCH_CASE_PERSONAGEM_CHUTE:
    # checagem de personagens
    li t0, 0
    li a2, 3
    beq t0, s10, SUBZERO_CHUTE        #PERSONAGEM 1 É O SUBZERO

SUBZERO_CHUTE:
    la a0, SubZeroChute1
    j GOLPE
    
SOCO:
SWITCH_CASE_PERSONAGEM_SOCO:
    # checagem de personagens
    li t0, 0
    li a2, 2
    beq t0, s10, SUBZERO_SOCO        #PERSONAGEM 1 É O SUBZERO

SUBZERO_SOCO:
    la a0, SubZeroSocoFraco1
    j GOLPE



############################################################################################
#Esse loop é responsável por realizar a animação do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs: Apagar é chamado aqui seguido de Personagem para que uma animção ocorra
#
#Ao término do loop o personagem se desloca 16 pixels
############################################################################################
CAMINHAR:	
	li a2, 3
	jal ra, CAMINHAR_FRAME
	
	la a0, SubZeroParado1
	li a2, 1
	jal ra, CAMINHAR_FRAME
	j Fim_KDInterrupt
	
GOLPE:
	#li a2, 3
    	jal ra, FRAME_GOLPE

    	la a0, SubZeroParado1
    	li a2, 1
    	jal ra, FRAME_GOLPE
    	j Fim_KDInterrupt
	
Fim_KDInterrupt:
	lw ra, 0(sp)			# recupera ra
	addi sp, sp, 4			# libera espaço na pilha
	#csrrsi zero,0,0x10 	# seta o bit de habilitação de interrupção em ustatus 
	uret				# volta ao programa principal
	
	
