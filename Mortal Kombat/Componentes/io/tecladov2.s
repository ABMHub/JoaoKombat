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
	sw ra, 0(sp)			# salva ra na pilha
	
	csrrci zero,0,1     		# clear o bit de habilita��o de interrup��o global em ustatus (reg 0)

        lw t2,4(t1)             	# le a tecla
        sw t2,12(t1)            	# escreve no display
        
SWITCH_CASE_TECLA: 		
		
	li t3, 'd'
	beq t3, t2, DIREITA		# verifica se a tecla pressionada � 'd'
	
	#li t3, 'a'
	
DIREITA:
	
SWITCH_CASE_PERSONAGEM_FRAME1:
	li s0, 0			# contador de frames
	li s1, 5			# total de frames
	
	# checagem de personagens	
	li t0, 0	
	beq t0, s10, SUBZERO		#PERSONAGEM 1 � O SUBZERO
	
	
SUBZERO:
	la a0, SubZeroMov1
	j NEXT
SCORPION:
	#la a0, SCORPION1	
	#Frame 1
	
############################################################################################
#Esse loop � respons�vel por realizar a anima��o do personagem se movimentando para frente
#caso ele esteja virado para a direita.
#
#obs: Apagar � chamado aqui seguido de Personagem para que uma anim��o ocorra
#
#Ao t�rmino do loop o personagem se desloca 16 pixels
############################################################################################
NEXT:	li a2, 3
	jal ra, FRAME
	
	la a0, SubZeroParado1
	li a2, 1
	jal ra, FRAME
	
Fim_KDInterrupt:
	lw ra, 0(sp)			# recupera ra
	addi sp, sp, 4			# libera espa�o na pilha
	uret				# volta ao programa principal
	
	
