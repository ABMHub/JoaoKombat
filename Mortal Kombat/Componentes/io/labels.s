.data
	#Labels básicas
	VGA1INICIO: 			.word 0xFF000000
	VGA1FINAL: 			.word 0xFF012C00
	VGA2INICIO:			.word 0xFF100000
	VGA2FINAL:			.word 0xFF112C00
	PERSONAGEM1: 			.word 0xFF010410
	PERSONAGEM1_INICIO:		.word 0xFF009158
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
	HP_IA:				.word 100
	HP_IO:				.word 100		
	MATRIZ_COMBATE:			.space 300
	#########################################
	FILA_PERSONAGEM_1:		.space 120
	# Labels 
    	AGACHADO_IO:            	.word 0x0    # ELE LITERALMENTE AGACHADO, NÃO É O PRIMEIRO SPRITE DO AGACHAMENTO
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
    	# Labels da IA 
    	AGACHADO_IA:            	.word 0x0    # ELE LITERALMENTE AGACHADO, NÃO É O PRIMEIRO SPRITE DO AGACHAMENTO
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
    	DIFICULDADE_IA:			.word 1000
    	TEMPO50_IA:			.word 0x1
    	HITS_IA:			.word 0x0
