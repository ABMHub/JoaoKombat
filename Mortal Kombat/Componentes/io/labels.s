.data
	DIFICULDADE_TEMPO: 	.word 1500
	
	# Sele��o
	PERSONAGEM1_INICIO:        .word 0xFF010430
	SELETOR_INICIO:            .word 0xFF009158
  	 S_LARGURA_FRAME_0:        .word 0x0
    	S_LARGURA_FRAME_1:        .word 0x0
    	S_ALTURA_FRAME_0:        .word 0x0
    	S_ALTURA_FRAME_1:        .word 0x0


	# TORRE
	FOTINHA_INIM_ALT:        	.word 0x0
        FOTINHA_INIM_LARG:        	.word 0x0
	FOTINHA_IO:            		.word 0x0
	PARTIDA:			.word 0x0
	VETOR_INIMIGOS:			.space 48
	
	# BATALHA
	CENARIO_ATUAL:			.word 0x0
	ROUND_ATUAL:			.word 0x1
	HP_IA:				.word 100
	HP_IO:				.word 100
	MENSAGEM_POS:			.word 0xFF00784A
	
	VITORIAS_1:			.word 0x0	# VIT�RIAS DA IO
	VITORIAS_2:			.word 0x0	# VIT�RIAS DA IA
	PLAYER_1_WINS:			.word 0x0
	PLAYER_2_WINS:			.word 0x0
	
	M_LARGURA_FRAME_0:		.word 0x0AC			
	M_ALTURA_FRAME_0:		.word 0x01C
	M_LARGURA_FRAME_1:		.word 0x0AC			
	M_ALTURA_FRAME_1:		.word 0x01C
	
	
	# Labels b�sicas
	P_PODER_INICIO:			.word 0x0
	VGA1INICIO: 			.word 0xFF000000
	VGA1FINAL: 			.word 0xFF012C00
	VGA2INICIO:			.word 0xFF100000
	VGA2FINAL:			.word 0xFF112C00
	PERSONAGEM1: 			.word 0xFF010410
	PERSONAGEM1_INICIO_ANTIGO: 	.word 0x0
	PERSONAGEM1_FINAL: 		.word 0xFF00E4D0	#evite usar
	PERSONAGEM2: 			.word 0xFF010530
	ALTURA_FRAME_0:			.word 0x0
	ALTURA_FRAME_1:			.word 0x0
	LARGURA_FRAME_0:		.word 0x0
	LARGURA_FRAME_1:		.word 0x0
	ALTURA_FRAME_0_IA:			.word 0x0
	ALTURA_FRAME_1_IA:			.word 0x0
	LARGURA_FRAME_0_IA:		.word 0x0
	LARGURA_FRAME_1_IA:		.word 0x0
	# lembrar de apagar essas aqui dps que forem obsoletas
	ALTURA1:			.word 0x0
	LARGURA1:			.word 0x0
	ALTURA1ATUAL:			.word 0x0
	ALTURA1ANTIGA:			.word 0x0
	LARGURA1ATUAL:			.word 0x0
	LARGURA1ANTIGA:			.word 0x0
	######################################################
	ALTURA_DANCA_0:			.word 0x0
	LARGURA_DANCA_0:		.word 0x0
	ALTURA_DANCA_1:			.word 0x0
	LARGURA_DANCA_1:		.word 0x0
	SPRITE_DANCA:			.word 0x0
	CONTADORV1:			.word 0xC
	CONTADORH1:			.word 0x1
	CONTADORV2:			.word 0xC
	CONTADORH2:			.word 0x11

	MATRIZ_COMBATE:			.space 300
	#########################################
	FILA_PERSONAGEM_1:		.space 120
	# Labels 
    	AGACHADO_IO:            	.word 0x0    # ELE LITERALMENTE AGACHADO, N�O � O PRIMEIRO SPRITE DO AGACHAMENTO
    	AGACHANDO_IO:            	.word 0x0    # PRIMEIRO SPRITE DELE AGACHANDO
    	PULAR_1_IO:            		.word 0x0    # Subindo
    	PULAR_2_IO:            		.word 0x0    # Descendo
    	LEVANTAR_IO:            	.word 0x0 
    	CAMINHAR_DIREITA_IO:        	.word 0x0
    	CAMINHAR_ESQUERDA_IO:        	.word 0x0
    	CAMBALHOTA_IO:            	.word 0x0
    	CHUTE_1_EM_PE_IO:        	.word 0x0
    	CHUTE_1_AGACHADO_IO:        	.word 0x0
    	SOCO_1_EM_PE_IO:        	.word 0x0
    	SOCO_1_AGACHADO_IO:        	.word 0x0
    	CHUTE_2_EM_PE_IO:        	.word 0x0
    	CHUTE_2_AGACHADO_IO:        	.word 0x0
	AGACHADO_1_IO: 			.word 0x0
    	SOCO_2_EM_PE_IO:        	.word 0x0
    	SOCO_2_AGACHADO_IO:        	.word 0x0
    	PODER_IO:            		.word 0x0
    	DANCINHA_1_IO:            	.word 0x0
    	DANCINHA_2_IO:            	.word 0x0
    	BLOCK_EM_PE_IO:            	.word 0x0
    	BLOQUEANDO_EM_PE_IO:		.word 0x0
    	BLOCK_AGACHADO_IO:        	.word 0x0
    	BLOQUEANDO_AGACHADO_IO:		.word 0x0
    	DESATIVAR_BLOCK_EM_PE_IO:    	.word 0x0
    	DESATIVAR_BLOCK_AGACHADO_IO:    .word 0x0
    	TONTO_1_IO:			.word 0x0
    	TONTO_2_IO:			.word 0x0
    	PROJETIL_IO:			.word 0x0
    	# Labels da IA 
    	AGACHADO_IA:            	.word 0x0    # ELE LITERALMENTE AGACHADO, N�O � O PRIMEIRO SPRITE DO AGACHAMENTO
    	AGACHANDO_IA:            	.word 0x0    # PRIMEIRO SPRITE DELE AGACHANDO
    	PULAR_1_IA:            		.word 0x0    # Subindo
    	PULAR_2_IA:            		.word 0x0    # Descendo
    	LEVANTAR_IA:            	.word 0x0 
    	CAMINHAR_DIREITA_IA:        	.word 0x0
    	CAMINHAR_ESQUERDA_IA:        	.word 0x0
    	CAMBALHOTA_IA:            	.word 0x0
    	CHUTE_1_EM_PE_IA:        	.word 0x0
    	CHUTE_1_AGACHADO_IA:        	.word 0x0
    	SOCO_1_EM_PE_IA:        	.word 0x0
    	SOCO_1_AGACHADO_IA:        	.word 0x0
    	CHUTE_2_EM_PE_IA:        	.word 0x0
    	CHUTE_2_AGACHADO_IA:        	.word 0x0
	AGACHADO_1_IA: 			.word 0x0
    	SOCO_2_EM_PE_IA:        	.word 0x0
    	SOCO_2_AGACHADO_IA:        	.word 0x0
    	PODER_IA:            		.word 0x0
    	DANCINHA_1_IA:            	.word 0x0
    	DANCINHA_2_IA:            	.word 0x0
    	BLOCK_EM_PE_IA:            	.word 0x0
    	BLOQUEANDO_EM_PE_IA:		.word 0x0
    	BLOCK_AGACHADO_IA:        	.word 0x0
    	BLOQUEANDO_AGACHADO_IA:		.word 0x0
    	DESATIVAR_BLOCK_EM_PE_IA:    	.word 0x0
    	DESATIVAR_BLOCK_AGACHADO_IA:    .word 0x0
    	TONTO_1_IA:			.word 0x0
    	TONTO_2_IA:			.word 0x0
    	PROJETIL_IA:			.word 0x0
    	# APANHAR
    	# IO
    	RECUADA_LEVE_IO:		.word 0x0
    	RECUADA_PESADA_IO:		.word 0x0
    	RECUADA_LEVE_AGACHADO_IO:	.word 0x0
    	TOMOU_ALPISTE_IO:		.word 0x0
    	LEVOU_RASTEIRA_IO:		.word 0x0
	# IA
	RECUADA_LEVE_IA:		.word 0x0
    	RECUADA_PESADA_IA:		.word 0x0
    	RECUADA_LEVE_AGACHADO_IA:	.word 0x0
    	TOMOU_ALPISTE_IA:		.word 0x0
    	LEVOU_RASTEIRA_IA:		.word 0x0
    	# IA DIFICULDADE
    	DIFICULDADE_IA:			.word 2000
    	TEMPO50_IA:			.word 0x0
    	HITS_IA:			.word 0x0
    	
    	########### lEMBRAR DE INICIALIZAR COM OS VALORES ADEQUADOS JUNTO COM A INICIALIZA��O DAS LABELS DO PERSONAGEM
    	P_END_PODER: 			.word 0x0
    	P_LARGURA_FRAME_0:		.word 0x20	
	P_ALTURA_FRAME_0:		.word 0x6
	P_LARGURA_FRAME_1:		.word 0x20
	P_ALTURA_FRAME_1:		.word 0x6
	
	MORREU_IA: 			.word 0x0				# primeiro sprite da morte normal
	FATALITY_IA: 			.word 0x0				# primeiro sprite do fatality 
	ULTIMO_FATALITY_IA:		.word 0x0				# �ltimo sprite do fatality
	VITORIA_1_IA: 			.word 0X0				# primeiro sprite da vit�ria
	VITORIA_2_IA: 			.word 0X0				# primeiro sprite da vit�ria
	ULTIMO_MORREU_IA:		.word 0x0
	CABECA_IA:			.word 0x0
	
	MORREU_IO: 			.word 0x0				# primeiro sprite da morte norma	l
	FATALITY_IO: 			.word 0x0				# primeiro sprite do fatality 
	ULTIMO_FATALITY_IO:		.word 0x0				# �ltimo sprite do fatality
	VITORIA_1_IO: 			.word 0X0				# primeiro sprite da vit�ria
	VITORIA_2_IO: 			.word 0X0				# primeiro sprite da vit�ria
	ULTIMO_MORREU_IO:		.word 0x0
	CABECA_IO:			.word 0x0
