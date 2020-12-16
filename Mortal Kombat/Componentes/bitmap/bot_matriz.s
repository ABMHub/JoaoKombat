ESCOLHENDO_BOT:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t1, PARTIDA		#Qual é a partida
	lw t1, 0(t1)
	slli t1, t1, 2		#Multiplica com 4
	
	la t0, VETOR_INIMIGOS	#Pega o vetor de inimigos
	add t0, t0, t1		#Gera o endereço
	lw a0, 0(t0)
	
	#li a0, 1
	
	li t1, 0
	beq t1, a0, BOT_LK1	#Liu Kang
	
	li t1, 1
	beq t1, a0, BOT_SZ1	#SubZero
	
	li t1, 2
	beq t1, a0, BOT_Mi1	#Mileena
	
	li t1, 3
	beq t1, a0, BOT_KL1	#Kung Lao
	
	li t1, 4
	beq t1, a0, BOT_ST1	#Shang Tsung
	
	li t1, 5
	beq t1, a0, BOT_Ba1	#Baraka
	
	li t1, 6
	beq t1, a0, BOT_JC1	#Jonnhy Cage
	
	li t1, 7
	beq t1, a0, BOT_Ki1	#Kitana
	
	li t1, 8
	beq t1, a0, BOT_SC1	#Scorpion
	
	li t1, 9
	beq t1, a0, BOT_Re1	#Reptile
	
	li t1, 10
	beq t1, a0, BOT_Ja1	#Jax
	
	li t1, 11
	beq t1, a0, BOT_Ra1	#Raiden
	
BOT_LK1: 	j BOT_LK

BOT_SZ1: 	j BOT_SZ

BOT_Mi1: 	j BOT_Mi

BOT_KL1: 	j BOT_KL

BOT_ST1: 	j BOT_ST

BOT_Ba1: 	j BOT_Ba

BOT_JC1: 	j BOT_JC

BOT_Ki1: 	j BOT_Ki

BOT_SC1: 	j BOT_SC

BOT_Re1: 	j BOT_Re

BOT_Ja1: 	j BOT_Ja

BOT_Ra1: 	j BOT_Ra
	
BOT_LK:	
	la t0, Wins_LiuKang
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, LiuKangCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT

BOT_SZ:
	la t0, Wins_SubZero
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, SubZeroAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, SubZeroAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, SubZeroPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, SubZeroChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, SubZeroChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, SubZeroPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, SubZeroDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, SubZeroDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, SubZeroBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, SubZeroBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, SubZeroBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, SubZeroCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, SubZeroVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, SubZeroVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT

BOT_Mi:
	la t0, Wins_Mileena
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, MileenaAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, MileenaAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, MileenaPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, MileenaChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, MileenaChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, MileenaPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, MileenaDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, MileenaDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, MileenaBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, MileenaBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, MileenaBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, MileenaSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, MileenaCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, MileenaVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, MileenaVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
	
BOT_KL:
		la t0, Wins_KungLao
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, KungLaoAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, KungLaoAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, KungLaoPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, KungLaoChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, KungLaoChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, KungLaoPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, KungLaoDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, KungLaoDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, KungLaoBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, KungLaoBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, KungLaoBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, KungLaoCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, KungLaoVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, KungLaoVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    		
BOT_ST:
	la t0, Wins_ShangTsung
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, ShangTsungAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, ShangTsungAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, ShangTsungPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, ShangTsungChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, ShangTsungChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, ShangTsungPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, ShangTsungDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, ShangTsungDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, ShangTsungBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, ShangTsungBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, ShangTsungBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, ShangTsungCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, ShangTsungVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, ShangTsungVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    		
BOT_Ba:

	la t0, Wins_Baraka
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, BarakaAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, BarakaAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, BarakaPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, BarakaChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, BarakaChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, BarakaPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, BarakaDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, BarakaDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, BarakaBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, BarakaBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, BarakaBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, BarakaSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, BarakaCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, BarakaVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, BarakaVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
	
BOT_JC:
		la t0, Wins_JohnnyCage
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, JohnnyCageAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, JohnnyCageAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, JohnnyCagePulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCagePulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, JohnnyCageChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, JohnnyCageChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, JohnnyCagePoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, JohnnyCageDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, JohnnyCageDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, JohnnyCageBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, JohnnyCageBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, JohnnyCageBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, JohnnyCageCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, JohnnyCageVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, JohnnyCageVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT	
    	
BOT_Ki:
	la t0, Wins_Kitana
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, KitanaAgachado_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, KitanaAgachado_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, KitanaPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaAgachado_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, KitanaChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, KitanaChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, KitanaPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, KitanaDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, KitanaDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, KitanaBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, KitanaBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, KitanaBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, KitanaSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, KitanaCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, KitanaVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, KitanaVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
	
BOT_SC:
	la t0, Wins_Scorpion
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, ScorpionAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, ScorpionAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, ScorpionPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, ScorpionChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, ScorpionChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, ScorpionPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, ScorpionDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, ScorpionDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, ScorpionBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, ScorpionBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, ScorpionBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, ScorpionCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, ScorpionVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, ScorpionVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    	
BOT_Re:
		la t0, Wins_Reptile
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, ReptileAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, ReptileAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, ReptilePulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptilePulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, ReptileChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, ReptileChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, ReptilePoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, ReptileDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, ReptileDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, ReptileBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, ReptileBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, ReptileBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, ReptileSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, ReptileCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, ReptileVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, ReptileVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    	
BOT_Ja:
	la t0, Wins_Jax
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, JaxAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, JaxAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, JaxPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxPulando_3V
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, JaxChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, JaxChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, JaxPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, JaxDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, JaxDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, JaxBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, JaxBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, JaxBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, JaxSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, JaxCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, JaxVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, JaxVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
	
BOT_Ra:
	la t0, Wins_Rayden
	la t1, PLAYER_2_WINS
	sw t0, 0(t1)

	la t0, RaidenAgachando_2
    	la t1, AGACHADO_IA
    	sw t0, 0(t1)
    	
	la t0, RaidenAgachando_1
    	la t1, AGACHANDO_IA
    	sw t0, 0(t1)
    	
  	la t0, RaidenPulando_1
    	la t1, PULAR_1_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenPulando_3
    	la t1, PULAR_2_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenAgachando_3V
    	la t1, LEVANTAR_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenAndando_1
    	la t1, CAMINHAR_DIREITA_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenCambalhota_1
    	la t1, CAMBALHOTA_IA
    	sw t0, 0(t1)

	la t0, RaidenChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenSoco_1
   	la t1, SOCO_1_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IA
    	sw t0, 0(t1)

  	la t0, RaidenChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenRasteira_1
   	la t1, CHUTE_2_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenJab_1
   	la t1, SOCO_2_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenAlpiste_1
   	la t1, SOCO_2_AGACHADO_IA
    	sw t0, 0(t1)  
  
  	la t0, RaidenPoder_1
    	la t1, PODER_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenProjetil_1
    	la t1, PROJETIL_IA
    	sw t0, 0(t1)
  
  	la t0, RaidenDancando_1
    	la t1, DANCINHA_1_IA
    	sw t0, 0(t1)

    	la t0, RaidenDancando_2
    	la t1, DANCINHA_2_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenBlock_1
    	la t1, BLOCK_EM_PE_IA
    	sw t0, 0(t1)

    	la t0, RaidenBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IA
    	sw t0, 0(t1)

 	la t0, RaidenBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IA
    	sw t0, 0(t1)    
    	
    	la t0, RaidenBlock_2
    	la t1, BLOQUEANDO_EM_PE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenTomou_1
    	la t1, RECUADA_LEVE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenHelicoptero_1
    	la t1, RECUADA_PESADA_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenCaiu_1
    	la t1, LEVOU_RASTEIRA_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenVoando_1
    	la t1, TOMOU_ALPISTE_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenFinish_1
    	la t1, TONTO_1_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenFinish_3
    	la t1, TONTO_2_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenSemCabeca_1
    	la t1, FATALITY_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenRound_1
    	la t1, MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenRound_6
    	la t1, ULTIMO_MORREU_IA
    	sw t0, 0(t1)
    	
    	la t0, RaidenSemCabeca_6
    	la t1, ULTIMO_FATALITY_IA
    	sw t0, 0(t1)
    	
    	#la t0, RaidenCabeca_1
    	#la t1, CABECA_IA
    	#sw t0, 0(t1)
 
    	la t0, RaidenVitoria_1
    	la t1, VITORIA_1_IA 
    	sw t0, 0(t1)   	
    	
    	la t0, RaidenVitoria_2
    	la t1, VITORIA_2_IA 
    	sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    	j FIM_ESCOLHENDO_BOT

FIM_ESCOLHENDO_BOT:
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
