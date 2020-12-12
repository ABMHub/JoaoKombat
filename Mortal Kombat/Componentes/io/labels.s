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
	CONTADORH2:			.word 0x18
			
	MATRIZ_COMBATE:			.space 300
	
	#########################################
	FILA_PERSONAGEM_1:		.space 120
	
	# Labels 
    AGACHADO_IO:            .word 0x0    # ELE LITERALMENTE AGACHADO, N�O � O PRIMEIRO SPRITE DO AGACHAMENTO
    AGACHANDO_IO:            .word 0x0    # PRIMEIRO SPRITE DELE AGACHANDO
    PULAR_1_IO:            .word 0x0    # Subindo
    PULAR_2_IO:            .word 0x0    # Descendo
    LEVANTAR_IO:            .word 0x0 
    CAMINHAR_DIREITA_IO:        .word 0x0
    CAMINHAR_ESQUERDA_IO:        .word 0x0
    CAMBALHOTA_IO:            .word 0x0

    CHUTE_1_EM_PE_IO:        .word 0x0
    CHUTE_1_AGACHADO_IO:        .word 0x0

    SOCO_1_EM_PE_IO:        .word 0x0
    SOCO_1_AGACHADO_IO:        .word 0x0

    CHUTE_2_EM_PE_IO:        .word 0x0
    CHUTE_2_AGACHADO_IO:        .word 0x0

    SOCO_2_EM_PE_IO:        .word 0x0
    SOCO_2_AGACHADO_IO:        .word 0x0

    PODER_IO:            .word 0x0
    DANCINHA_1_IO:            .word 0x0
    DANCINHA_2_IO:            .word 0x0
    BLOCK_EM_PE_IO:            .word 0x0
    BLOCK_AGACHADO_IO:        .word 0x0
    DESATIVAR_BLOCK_EM_PE_IO:    .word 0x0
    DESATIVAR_BLOCK_AGACHADO_IO:    .word 0x0