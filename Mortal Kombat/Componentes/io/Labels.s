.data
	#Labels b�sicas
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
	
	ALTURA1:			.word 0x0
	LARGURA1:			.word 0x0
	ALTURA1ATUAL:			.word 0x0
	ALTURA1ANTIGA:			.word 0x0
	LARGURA1ATUAL:			.word 0x0
	LARGURA1ANTIGA:			.word 0x0
	
	ALTURA_DANCA_0:			.word 0x0
	LARGURA_DANCA_0:		.word 0x0
	ALTURA_DANCA_1:			.word 0x0
	LARGURA_DANCA_1:		.word 0x0
	
	SPRITE_DANCA:			.word 0x0
	
	CONTADORV1:			.word 0xC
	CONTADORH1:			.word 0x1
	CONTADORV2:			.word 0xC
	CONTADORH2:			.word 0x12
			
	MATRIZ_COMBATE:			.space 300
	
	#########################################
	FILA_PERSONAGEM_1:		.space 120
	
	# Labels 
	AGACHADO_IO:			.word 0x0
	PULAR_IO:			.word 0x0
	LEVANTAR_IO:			.word 0x0 
	CAMINHAR_DIREITA_IO:		.word 0x0
	CAMINHAR_ESQUERDA_IO:		.word 0x0
	CAMBALHOTA_DIREITA_IO:		.word 0x0
	CAMBALHOTA_ESQUERDA_IO:		.word 0x0
	
	CHUTE_NORMAL_IO:		.word 0x0
	CHUTE_AGACHADO_IO:		.word 0x0
	SOCO_NORMAL_IO:			.word 0x0
	SOCO_AGACHADO_IO:		.word 0x0
	CHUTE_ALTO_IO:			.word 0x0
	RASTEIRA_IO:			.word 0x0
	ALPISTE_ORH_IO:			.word 0x0
	#PODER_IO			.word 0x0
	JAB_IO:				.word 0x0
	PARADO_IO:			.word 0x0
	DANCINHA1_IO:			.word 0x0
	DANCINHA2_IO:			.word 0x0
	BLOCK_EM_PE_IO:			.word 0x0
	BLOCK_AGACHADO_IO:		.word 0x0
	DESATIVAR_BLOCK_EM_PE_IO:	.word 0x0
	DESATIVAR_BLOCK_AGACHADO_IO:	.word 0x0
	CAMBALHOTA_FRENTE_IO:		.word 0x0
	CAMBALHOTA_TRAS_IO:		.word 0x0
	
	AGACHADO_IA:			.word 0x0
	PULAR_IA:			.word 0x0
	LEVANTAR_IA:			.word 0x0 
	CAMINHAR_DIREITA_IA:		.word 0x0
	CAMINHAR_ESQUERDA_IA:		.word 0x0
	CAMBALHOTA_DIREITA_IA:		.word 0x0
	CAMBALHOTA_ESQUERDA_IA:		.word 0x0
	
	CHUTE_NORMAL_IA:		.word 0x0
	CHUTE_AGACHADO_IA:		.word 0x0
	SOCO_NORMAL_IA:			.word 0x0
	SOCO_AGACHADO_IA:		.word 0x0
	CHUTE_ALTO_IA:			.word 0x0
	RASTEIRA_IA:			.word 0x0
	ALPISTE_ORH_IA:			.word 0x0
	#PODER_IA			.word 0x0
	JAB_IA:				.word 0x0
	PARADO_IA:			.word 0x0
	DANCINHA1_IA:			.word 0x0
	DANCINHA2_IA:			.word 0x0
	BLOCK_EM_PE_IA:			.word 0x0
	BLOCK_AGACHADO_IA:		.word 0x0
	DESATIVAR_BLOCK_EM_PE_IA:	.word 0x0
	DESATIVAR_BLOCK_AGACHADO_IA:	.word 0x0
	CAMBALHOTA_FRENTE_IA:		.word 0x0
	CAMBALHOTA_TRAS_IA:		.word 0x0
