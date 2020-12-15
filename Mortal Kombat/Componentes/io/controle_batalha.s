#########################################################################################################################
#
#
#########################################################################################################################
NOVO_ROUND:
	la t0, ROUND_ATUAL
	lw t1, 0(t0)
	addi t1, t1, 1
	li t2, 3
	bgt t1, t2, ROUND_0
	sw t1, 0(t0)
	j OK_MS
ROUND_0:
	sw zero, 0(t0)
	j NOVO_ROUND
OK_MS:	
	
	li sp, 0x7fffeffc	# reseta a pilha
	
	addi sp, sp, -4
	sw ra, 0(sp)		# guarda ra
	
	#mv x3, zero
	#mv x4, zero
	mv x5, zero
	mv x6, zero
	mv x7, zero
	mv x8, zero
	mv x9, zero
	mv x10, zero
	mv x11, zero
	mv x12, zero
	mv x13, zero
	mv x14, zero
	mv x15, zero
	mv x16, zero
	mv x17, zero
	mv x18, zero
	mv x19, zero
	mv x20, zero
	mv x21, zero
	mv x22, zero
	mv x23, zero
	mv x24, zero
	#mv x25, zero
	mv x26, zero
	mv x27, zero
	mv x28, zero
	mv x29, zero
	mv x30, zero
	mv x31, zero
		

	la t0, VGA1INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA1FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	mv a0, s9
	jal ra, BACKGROUND			# argumento em a0 = fundo
	
	mv a0, s9
	la t0, VGA2INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA2FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	jal ra, BACKGROUND			# argumento em a0 = fundo




	# reinicia a posição inicial dos personagens
	
	la t0, PERSONAGEM1_INICIO
	li t1, 0xFF010410
	sw t0, 0(t1)
	
	la t0, PERSONAGEM1
	li t1, 0xFF010410
	sw t0, 0(t1)
	
	
	la t0, PERSONAGEM2
	li t1, 0xFF010530
	sw t0, 0(t1)
	
	# reinicia os contadores horizontais
	
	la t0, CONTADORH1
	li t1, 0x001
	sw t1, 0(t0)
	
	la t0, CONTADORH2
	li t1, 0x011
	sw t1, 0(t0)

	# reinicia os HPs
	li t0, 100
	la t1, HP_IO
	sw t0, 0(t1)
	
	la t1, HP_IA
	sw t0, 0(t1)

	# reinicia a IA
	la t0, TEMPO50_IA
	sw zero, 0(t0)
	
	# reinicia o estado dos personagens
	la s10, DANCINHA_1_IO
	la s11, DANCINHA_1_IA

	# identifica o round atual
	la t0, ROUND_ATUAL
	lw t1, 0(t0)			# t1 = round atual


	li t0, 0xFF200604
	sw zero, 0(t0)			# Muda para a outra frame
###########################################################################################
    	li a1, 1             # da esquerda para direita
    	la a6, PERSONAGEM1
    	lw a6, 0(a6)

    	la a4, LARGURA_FRAME_1            # a4 = endereço da largura
    	la a5, ALTURA_FRAME_1            # a5 = endereço da altura
    	la t0, DANCINHA_1_IO
    	lw a0, 0(t0)
    	jal ra, PERSONAGEM_V2#############################

    	la a0, DANCINHA_2_IO
    	lw a0, 0(a0)
    	la a7, PERSONAGEM1
    	jal ra, FRAME_DANCINHA
###########################################################################################
    	li a1, -1             # da esquerda para direita
    	la a6, PERSONAGEM2
    	lw a6, 0(a6)

    	la a4, LARGURA_FRAME_1_IA            # a4 = endereço da largura
    	la a5, ALTURA_FRAME_1_IA            # a5 = endereço da altura
    	la t0, DANCINHA_1_IA
    	lw a0, 0(t0)
    	jal ra, PERSONAGEM_V2#############################

	li a1, -1
    	la a0, DANCINHA_2_IA
    	lw a0, 0(a0)
    	jal ra, FRAME_DANCINHA_IA
###########################################################################################

	jal ra, INICIALIZA_VIDA

######################################################################################################################	
	#ebreak
	la t0, ROUND_ATUAL
	lw t1, 0(t0)				# Descobre qual o round atual
	
	li t2, 3				
	bgt t1, t2, REINICIAR_ROUND			# Se o round for maior que 3 devemos zerar
	
	sw t1, 0(t0)				# Do contrário salvamos o novo round
	j L_SWITCH_CASE_ROUND
	
REINICIAR_ROUND:
	li t1, 1	
	sw t1, 0(t0)
				
L_SWITCH_CASE_ROUND:	
	li t2, 1
	beq t1, t2, L_ROUND_1
	
	li t2, 2
	beq t1, t2, L_ROUND_2
	
	li t3, 3
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
	
	li t0, 0xFF200604
	lw t1, 0(t0)
	xori t1, t1, 0x001
	sw t1, 0(t0)			# Muda para a outra frame

	# Preparação mensagem de round
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	
    	li t3, 0xFF200604		
    	
L_LOOP_MENSAGEM_ROUND:
  	beq t0, t4, L_FIM_MENSAGEM_ROUND
    	addi t0, t0, 1
    	
    	lw t1, 0(t3)
	xori t1, t1, 0x001
	sw t1, 0(t3)			# Muda para a outra frame
    	
    	ecall				# SLEEP
	j L_LOOP_MENSAGEM_ROUND		
	
L_FIM_MENSAGEM_ROUND:
	# apagar mensagem de round
	lw t1, 0(t3)
	bne t1, zero, L_ROUND_F1		# Muda para a outra frame

L_ROUND_F0:
	#Apaga na 1
	li a1, 1
	la a4, M_LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_1			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	
	li t1, 0x00100000
	or a6, a6, t1
	sw a6, 0(t0)
	
	li a7, 0xFF100000
	jal ra, LIMPAR
	#Muda pra 1
	li t0, 0xFF200604
	li t1, 1
	sw t1, 0(t0)
	#Apaga na 0
	li a1, 1
	la a4, M_LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_0			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	
	li t1, 0xFF0FFFFF
	and a6, a6, t1
	sw a6, 0(t0)
	
	li a7, 0xFF000000
	jal ra, LIMPAR
	j L_M_FIGHT
L_ROUND_F1:
	#Apaga na 0
	li a1, 1
	la a4, M_LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_0			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	li a7, 0xFF000000
	
	li t1, 0xFF0FFFFF
	and a6, a6, t1
	sw a6, 0(t0)
	
	jal ra, LIMPAR

	#Muda pra 0
	li t0, 0xFF200604
	sw zero, 0(t0)
	
	#Apaga na 1
	li a1, 1
	la a4, M_LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_1			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	li a7, 0xFF100000
	
	li t1, 0x00100000
	or a6, a6, t1
	sw a6, 0(t0)
	
	jal ra, LIMPAR

L_M_FIGHT:
	# MENSAGEM DE FIGHT
	la a0, Fight_1
	jal ra, M_FRAME_DANCINHA
	
	li t0, 0xFF200604
	lw t1, 0(t0)
	xori t1, t1, 0x001
	sw t1, 0(t0)			# Muda para a outra frame
	
	la a0, Fight_2
	jal ra, M_FRAME_DANCINHA
	
	li t0, 0xFF200604
	lw t1, 0(t0)
	xori t1, t1, 0x001
	sw t1, 0(t0)			# Muda para a outra frame
	
	# Preparação mensagem de fight
	li t0, 1	
	li t4, 5			

    	li a7, 32
    	li a0, 50
    	
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

	# Finalização
	#ebreak
	# apagar mensagem de round
	lw t1, 0(t3)
	bne t1, zero, L_ROUND_F1		# Muda para a outra frame

L_FIGHT_F0:
	#Apaga na 1
	li a1, 1
	la a4, M_LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_1			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	
	li t1, 0x00100000
	or a6, a6, t1
	sw a6, 0(t0)
	
	li a7, 0xFF100000
	jal ra, LIMPAR
	#Muda pra 1
	li t0, 0xFF200604
	li t1, 1
	sw t1, 0(t0)
	#Apaga na 0
	li a1, 1
	la a4, M_LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_0			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	
	li t1, 0xFF0FFFFF
	and a6, a6, t1
	sw a6, 0(t0)
	
	li a7, 0xFF000000
	jal ra, LIMPAR
	j L_FIM_ACABOU
	
L_FIGHT_F1:
	#Apaga na 0
	li a1, 1
	la a4, M_LARGURA_FRAME_0		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_0			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	li a7, 0xFF000000
	
	li t1, 0xFF0FFFFF
	and a6, a6, t1
	sw a6, 0(t0)
	
	jal ra, LIMPAR

	#Muda pra 0
	li t0, 0xFF200604
	sw zero, 0(t0)
	
	#Apaga na 1
	li a1, 1
	la a4, M_LARGURA_FRAME_1		# a4 = endereço da largura
	la a5, M_ALTURA_FRAME_1			# a5 = endereço da altura
	la t0, MENSAGEM_POS
	lw a6, 0(t0)
	li a7, 0xFF100000
	
	li t1, 0x00100000
	or a6, a6, t1
	sw a6, 0(t0)
	
	jal ra, LIMPAR

	la t0, ROUND_ATUAL
	lw t1, 0(t0)				# Descobre qual o round atual
	addi t1, t1, 1
	sw t1, 0(t0)

L_FIM_ACABOU:	

	#lw ra, 0(sp)
	#addi sp, sp, 4
	#ebreak
	li sp, 0x7fffeffc	# reseta a pilha
	# ret
	j FIM_RESTART
