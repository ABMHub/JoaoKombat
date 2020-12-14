ESCOLHENDO_BOT:
	addi sp, sp, -12
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a7, 8(sp)

	li a7, 41		#Gera número aleatório
	ecall
	
	li t1, 12		#Faz mod 12, para poder selecionar um personagem
	remu a0, a0, t1		
	
	li a0, 1
	
	li t1, 0
	beq t1, a0, BOT_LK	#Liu Kang
	
	li t1, 1
	beq t1, a0, BOT_SZ	#SubZero
	
	li t1, 2
	beq t1, a0, BOT_Mi	#Mileena
	
	li t1, 3
	beq t1, a0, BOT_KL	#Kung Lao
	
	li t1, 4
	beq t1, a0, BOT_ST	#Shang Tsung
	
	li t1, 5
	beq t1, a0, BOT_Ba	#Baraka
	
	li t1, 6
	beq t1, a0, BOT_JC	#Jonnhy Cage
	
	li t1, 7
	beq t1, a0, BOT_Ki	#Kitana
	
	li t1, 8
	beq t1, a0, BOT_SC	#Scorpion
	
	li t1, 9
	beq t1, a0, BOT_Re	#Reptile
	
	li t1, 10
	beq t1, a0, BOT_Ja	#Jax
	
	li t1, 11
	beq t1, a0, BOT_Ra	#Raiden
	
BOT_LK:	
	j FIM_ESCOLHENDO_BOT

BOT_SZ:
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
    	
    	la t0, SubZeroCabeca_1
    	la t1, CABECA_IA
    	sw t0, 0(t1)
 
    	#la t0, SubZeroVitoria_1
    	#la t1, VITORIA_1_IA 
    	#sw t0, 0(t1)   	
    	
    	#la t0, SubZeroVitoria_2
    	#la t1, VITORIA_2_IA 
    	#sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT

BOT_Mi:
	j FIM_ESCOLHENDO_BOT
	
BOT_KL:
	j FIM_ESCOLHENDO_BOT
	
BOT_ST:
	j FIM_ESCOLHENDO_BOT
	
BOT_Ba:
	j FIM_ESCOLHENDO_BOT
	
BOT_JC:
	j FIM_ESCOLHENDO_BOT
	
BOT_Ki:
	j FIM_ESCOLHENDO_BOT
	
BOT_SC:
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
    	
    	la t0, ScorpionCabeca_1
    	la t1, CABECA_IA
    	sw t0, 0(t1)
 
    	#la t0, ScorpionVitoria_1
    	#la t1, VITORIA_1_IA 
    	#sw t0, 0(t1)   	
    	
    	#la t0, ScorpionVitoria_2
    	#la t1, VITORIA_2_IA 
    	#sw t0, 0(t1)  
    	
    	la s11, DANCINHA_1_IA
    	
    	j FIM_ESCOLHENDO_BOT
    	
BOT_Re:
	j FIM_ESCOLHENDO_BOT
	
BOT_Ja:
	j FIM_ESCOLHENDO_BOT
	
BOT_Ra:
	j FIM_ESCOLHENDO_BOT


FIM_ESCOLHENDO_BOT:
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a7, 8(sp)
	addi sp, sp, 12
	
	ret
