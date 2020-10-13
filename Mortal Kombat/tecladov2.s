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
	sw ra, 0(sp)			# salva ra na pilha
	
	csrrci zero,0,1     		# clear o bit de habilitação de interrupção global em ustatus (reg 0)

        lw t2,4(t1)             	# le a tecla
        sw t2,12(t1)            	# escreve no display
        
SWITCH_CASE_TECLA: 		
		
	li t3, 'd'
	beq t3, t2, DIREITA		# verifica se a tecla pressionada é 'd'
	
DIREITA:
	
SWITCH_CASE_PERSONAGEM_FRAME1:
	li s0, 0			# contador de frames
	li s1, 4			# total de frames
	
	# checagem de personagens	
	li t0, 0	
	beq t0, s10, SUBZERO		#PERSONAGEM 1 É O SUBZERO
	
	
SUBZERO:
	la a0, mario1
	j FRAME
SCORPION:
	#la a0, SCORPION1	
	#Frame 1
	
############################################################################################
#Esse loop é responsável por realizar a animação do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs: Apagar é chamado aqui seguido de Personagem para que uma animção ocorra
#
#Ao término do loop o personagem se desloca 16 pixels
############################################################################################
FRAME:	
	mv a1, s9			# a1 = background
	
	jal ra, APAGAR			# APAGA O PERSONAGEM
	
	la t0, PERSONAGEM1_INICIO	
	lw t1, 0(t0)			# t1 = posição inicial do personagem
	
	addi t1, t1, 4			# soma 4 pixels na posição inicial
	sw t1, 0(t0)			# salva a nova posição inicial
	
	la t2, PERSONAGEM1_FINAL	
	lw t3, 0(t2)			# t3 = posição final do personagem

	addi t3, t3, 4			# soma 4 pixels na posição final
	sw t3, 0(t2)			# salva a nova posição final (ISSO NÃO ESTÁ SENDO UTILIZADO EM LUGAR ALGUM NO MOMENTO E SE POSSÍVEL EVITE USAR)

	jal ra, PERSONAGEM		# PINTA O PERSONAGEM
	
	addi s0, s0, 1			# incrementa o contador de frames
	blt  s0, s1, FRAME		# repete enquanto não atingir o máximo de frames
	

Fim_KDInterrupt:
	lw ra, 0(sp)			# recupera ra
	addi sp, sp, 4			# libera espaço na pilha
	uret				# volta ao programa principal
	
	
