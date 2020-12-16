NOVO_ROUND:
	# Desativa a interrupção

        li t1,0xFF200000    		# Endereço de controle do KDMMIO
	li t0,0x01       		# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           		# Habilita interrupção do teclado
	#

	la t0, VITORIAS_1
	lw t1, 0(t0)
	
	la t2, VITORIAS_2
	lw t3, 0(t2)
	
	li t4, 2
	beq t1, t4, L_PLAYER_1_WINS
	beq t3, t4, L_PLAYER_2_WINS

	j L_AINDA_NAO_ACABOU

L_PLAYER_1_WINS:
	la t0, PARTIDA
	lw t1, 0(t0)
	addi t1, t1, 1
	sw t1, 0(t0)
	
	la t0, PLAYER_1_WINS	
	lw a0, 0(t0)
	jal ra, M_FRAME_GOLPE_VGA
	
	la t0, PLAYER_1_WINS	
	lw a0, 0(t0)
	jal ra, M_FRAME_DANCINHA
	
	# Preparação mensagem de vitória
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	
    	li t3, 0xFF200604	
	
L_LOOP_MENSAGEM_FIGHT_1_WINS:
  	beq t0, t4, L_FIM_MENSAGEM_WINS
    	addi t0, t0, 1
    	
    	lw t1, 0(t3)
	xori t1, t1, 0x001
	sw t1, 0(t3)			# Muda para a outra frame
    	
    	ecall				# SLEEP
	j L_LOOP_MENSAGEM_FIGHT_1_WINS		


L_PLAYER_2_WINS:
	la t0, PARTIDA
	lw t1, 0(t0)
	addi t1, t1, 1
	sw t1, 0(t0)

	la t0, PLAYER_2_WINS	
	lw a0, 0(t0)
	jal ra, M_FRAME_GOLPE_VGA
	
	la t0, PLAYER_2_WINS	
	lw a0, 0(t0)
	jal ra, M_FRAME_DANCINHA

	# Preparação mensagem de fight
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	
    	li t3, 0xFF200604	
	
L_LOOP_MENSAGEM_FIGHT_2_WINS:
  	beq t0, t4, L_FIM_MENSAGEM_WINS
    	addi t0, t0, 1
    	
    	lw t1, 0(t3)
	xori t1, t1, 0x001
	sw t1, 0(t3)				# Muda para a outra frame
    		
    	ecall					# SLEEP
	j L_LOOP_MENSAGEM_FIGHT_2_WINS	

L_FIM_MENSAGEM_WINS:
	ebreak
	jal ra, ESCOLHENDO_BOT			# Escolhe o novo personagem
	jal ra, TORRE_MK			# Mostra a animação da torre
	
	li t1, 1
	la t0, ROUND_ATUAL
	sw t1, 0(t0)				# Define o novo número do round
	
	la t0, VITORIAS_1
	sw zero, 0(t0)				# Reinicia as vitórias da IO
	
	la t1, VITORIAS_2
	sw zero, 0(t1)				# Reinicia as vitórias da IA
	
L_AINDA_NAO_ACABOU:
	# reinicia o cenário
	la t0, CENARIO_ATUAL
	lw s9, 0(t0)

	# reinicia a posição inicial dos personagens
	
	la t0, PERSONAGEM1_INICIO
	li t1, 0xFF010410
	sw t1, 0(t0)
	
	la t0, PERSONAGEM1
	li t1, 0xFF010410
	sw t1, 0(t0)
	
	la t0, PERSONAGEM2
	li t1, 0xFF010530
	sw t1, 0(t0)
	
	# reinicia os contadores horizontais
	
	la t0, CONTADORH1
	li t1, 0x001
	sw t1, 0(t0)
	
	la t0, CONTADORH2
	li t1, 0x011
	sw t1, 0(t0)
	
	UPDATE_MATRIZ

	# reinicia os HPs
	li t0, 100
	la t1, HP_IO
	sw t0, 0(t1)
	
	la t1, HP_IA
	sw t0, 0(t1)

	# reinicia a IA
	la t0, TEMPO50_IA
	sw zero, 0(t0)
	
	la t0, HITS_IA
	sw zero, 0(t0)
	
	# reinicia o estado dos personagens
	la s10, DANCINHA_1_IO
	la s11, DANCINHA_1_IA 
	
	# Pinta o background
	mv a0, s9
	la t0, VGA2INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA2FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	jal ra, BACKGROUND			# argumento em a0 = fundo
	
	li t0,0xFF200604        		# Escolhe a frame 1
    	li t1, 1
    	sw t1, 0(t0)        		
	
	la t0, VGA1INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA1FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	mv a0, s9
	jal ra, BACKGROUND			# argumento em a0 = fundo

	# Mostra a frame 0
	li t0, 0xFF200604
	sw zero, 0(t0)				# Muda para a outra frame

	# pinta o personagem 1
	li a1, 1             			# da esquerda para direita
    	la t0, PERSONAGEM1
    	lw a6, 0(t0)
    	la a4, LARGURA_FRAME_1            	# a4 = endereço da largura
    	la a5, ALTURA_FRAME_1            	# a5 = endereço da altura
    	la t0, DANCINHA_1_IO
    	lw a0, 0(t0)
    	jal ra, PERSONAGEM_V2#############################

    	la t0, DANCINHA_2_IO
    	lw a0, 0(t0)
    	jal ra, FRAME_DANCINHA
	
	# pinta o personagem 2
	li a1, -1             # da esquerda para direita
    	la t0, PERSONAGEM2
    	lw a6, 0(t0)

    	la a4, LARGURA_FRAME_1_IA            # a4 = endereço da largura
    	la a5, ALTURA_FRAME_1_IA            # a5 = endereço da altura
    	la t0, DANCINHA_1_IA
    	lw a0, 0(t0)
    	jal ra, PERSONAGEM_V2#############################

	li a1, -1
    	la t0, DANCINHA_2_IA
    	lw a0, 0(t0)
    	jal ra, FRAME_DANCINHA_IA
    	
    	# barra de vida
    	jal ra, INICIALIZA_VIDA
    	#ebreak
    	# identifica o rund atual
    	la t0, ROUND_ATUAL
	lw t1, 0(t0)				# Descobre qual o round atual
	
L_SWITCH_CASE_ROUND:	
	li t2, 1
	beq t1, t2, L_ROUND_1
	
	li t2, 2
	beq t1, t2, L_ROUND_2
	
	li t2, 3
	beq t1, t2, L_ROUND_3 

L_ROUND_1:
	la a0, Round_1
	
	jal ra, M_FRAME_GOLPE_VGA
	
	la a0, Round_1
	
	j L_ROUND_FIM
L_ROUND_2:
	la a0, Round_2
	
	jal ra, M_FRAME_GOLPE_VGA
	
	la a0, Round_2
	
	j L_ROUND_FIM
L_ROUND_3:	 	
	la a0, Round_3
	
	jal ra, M_FRAME_GOLPE_VGA
	
	la a0, Round_3
	
L_ROUND_FIM:


	jal ra, M_FRAME_DANCINHA

	# Preparação mensagem de round
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	#ebreak
    	li t3, 0xFF200604		
    	
L_LOOP_MENSAGEM_ROUND:
  	beq t0, t4, L_FIM_MENSAGEM_ROUND
    	addi t0, t0, 1
    	
    	lw t1, 0(t3)
	xori t1, t1, 0x001
	sw t1, 0(t3)			# Muda para a outra frame
    	
    	ecall				# SLEEP
	j L_LOOP_MENSAGEM_ROUND		
	
######################################################################################################################
L_FIM_MENSAGEM_ROUND:
	la a0, MsgTransparente_1
	li a2, 2
	li a3, 0
	li a1, 1
	jal ra, M_FRAME_DESLOCAMENTO_VGA

L_M_FIGHT:
	# MENSAGEM DE FIGHT
	la a0, Fight_1
	jal ra, M_FRAME_GOLPE_VGA
	
	la a0, Fight_2
	jal ra, M_FRAME_DANCINHA

	# Preparação mensagem de fight
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	#ebreak
    	li t3, 0xFF200604	
	
L_LOOP_MENSAGEM_FIGHT:
  	beq t0, t4, L_FIM_MENSAGEM_FIGHT
    	addi t0, t0, 1
    	
    	lw t1, 0(t3)
	xori t1, t1, 0x001
	sw t1, 0(t3)			# Muda para a outra frame
    	
    	ecall				# SLEEP
	j L_LOOP_MENSAGEM_FIGHT		
	
L_FIM_MENSAGEM_FIGHT:	

	la a0, MsgTransparente_1
	li a2, 2
	li a3, 0
	li a1, 1
	jal ra, M_FRAME_DESLOCAMENTO_VGA


L_FIM_ACABOU:	
	li sp, 0x7fffeffc	# reseta a pilha
	# ret
	
	# Reativa a interrupçãos

        li t1,0xFF200000    	# Endereço de controle do KDMMIO
        li t0,0x02        	# bit 1 habilita/desabilita a interrupção
        sw t0,0(t1)          	# Habilita interrupção do
	
	
	j FIM_RESTART

    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
