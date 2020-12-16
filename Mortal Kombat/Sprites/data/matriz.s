MATRIZ_ESCOLHA:
	addi sp, sp, -4
	sw ra, 0(sp)

	li t0, 0
	li t1, 1
	li t2, 2
	li t3, 3
	
	beq s0, t0, COLUNA_ZERO
	beq s0, t1, COLUNA_UM
	beq s0, t2, COLUNA_DOIS
	beq s0, t3, COLUNA_TRES
	
COLUNA_ZERO:
	beq s1, t0, LK2
	beq s1, t1, SZ2
	beq s1, t2, Mi2
	
COLUNA_UM:
	beq s1, t0, KL2
	beq s1, t1, ST2
	beq s1, t2, Ba2

COLUNA_DOIS:
	beq s1, t0, JC2
	beq s1, t1, Ki2
	beq s1, t2, SC2
	
COLUNA_TRES:
	beq s1, t0, Re2
	beq s1, t1, Ja2
	beq s1, t2, Ra2
	
LK2:	j LK
	
SZ2:	j SZ

Mi2:	j Mi

KL2:	j KL

ST2:	j ST

Ba2:	j Ba

JC2:	j JC

Ki2:	j Ki

SC2:	j SC

Re2:	j Re

Ja2:	j Ja

Ra2:	j Ra


LK:	la t0, Fotinha_LK
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM
	
SZ:	la t0, Fotinha_SZ
    	la t1, FOTINHA_IO
    	sw t0, 0(t1) 
	
	la t0, SubZeroAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, SubZeroAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, SubZeroPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, SubZeroChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, SubZeroChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, SubZeroPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, SubZeroDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, SubZeroDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, SubZeroBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, SubZeroBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, SubZeroBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, SubZeroCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, SubZeroVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, SubZeroVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)
    	
    	la s10, DANCINHA_1_IO
    	
    	j FIM

############################################ IA	
	
    #la a4, ALTURA1            # a4 = endereço da altura
    #la a5, LARGURA1        # a5 = endereço da largura

Mi:	la t0, Fotinha_LK
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
    	
	j FIM

KL:	la t0, Fotinha_KL
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, KungLaoAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, KungLaoAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, KungLaoPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, KungLaoChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, KungLaoChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, KungLaoPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, KungLaoDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, KungLaoDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, KungLaoBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, KungLaoBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, KungLaoBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, KungLaoCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, KungLaoVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, KungLaoVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM

ST:	la t0, Fotinha_ST
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, ShangTsungAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, ShangTsungAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, ShangTsungPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, ShangTsungChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, ShangTsungChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, ShangTsungPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, ShangTsungDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, ShangTsungDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, ShangTsungBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, ShangTsungBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, ShangTsungBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ShangTsungCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, ShangTsungVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, ShangTsungVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM
	
Ba:	la t0, Fotinha_LK
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM
	
JC:	la t0, Fotinha_JC
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, JohnnyCageAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, JohnnyCageAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, JohnnyCagePulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCagePulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, JohnnyCageChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, JohnnyCageChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, JohnnyCagePoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, JohnnyCageDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, JohnnyCageDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, JohnnyCageBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, JohnnyCageBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, JohnnyCageBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, JohnnyCageCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, JohnnyCageVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, JohnnyCageVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
    	
    	j FIM
	
Ki:	la t0, Fotinha_LK
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM
	
SC:	la t0, Fotinha_SC
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, ScorpionAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, ScorpionAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, ScorpionPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, ScorpionChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, ScorpionChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, ScorpionPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, ScorpionDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, ScorpionDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, ScorpionBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, ScorpionBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, ScorpionBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ScorpionCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, ScorpionVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, ScorpionVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
    	
    	j FIM
	
Re:	la t0, Fotinha_RE
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, ReptileAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, ReptileAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, ReptilePulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptilePulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, ReptileChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, ReptileChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, ReptilePoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, ReptileDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, ReptileDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, ReptileBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, ReptileBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, ReptileBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, ReptileCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, ReptileVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, ReptileVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM

Ja:	#la s10, JaxParado_1
	#la a0, JaxParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_Jax    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
Ra:	la t0, Fotinha_LK
    	la t1, FOTINHA_IO
    	sw t0, 0(t1)

	la t0, LiuKangAgachando_2
    	la t1, AGACHADO_IO
    	sw t0, 0(t1)
    	
	la t0, LiuKangAgachando_1
    	la t1, AGACHANDO_IO
    	sw t0, 0(t1)
    	
  	la t0, LiuKangPulando_1
    	la t1, PULAR_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangPulando_3V
    	la t1, PULAR_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAgachando_3V
    	la t1, LEVANTAR_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_1
    	la t1, CAMINHAR_DIREITA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAndando_3V
    	la t1, CAMINHAR_ESQUERDA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCambalhota_1
    	la t1, CAMBALHOTA_IO
    	sw t0, 0(t1)

	la t0, LiuKangChuteBaixo_1
   	la t1, CHUTE_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangChuteAgachado_1
   	la t1, CHUTE_1_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSoco_1
   	la t1, SOCO_1_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSocoAgachado_1
   	la t1, SOCO_1_AGACHADO_IO
    	sw t0, 0(t1)

  	la t0, LiuKangChuteAlto_1
   	la t1, CHUTE_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRasteira_1
   	la t1, CHUTE_2_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangJab_1
   	la t1, SOCO_2_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangAlpiste_1
   	la t1, SOCO_2_AGACHADO_IO
    	sw t0, 0(t1)  
  
  	la t0, LiuKangPoder_1
    	la t1, PODER_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangProjetil_1
    	la t1, PROJETIL_IO
    	sw t0, 0(t1)
  
  	la t0, LiuKangDancando_1
    	la t1, DANCINHA_1_IO
    	sw t0, 0(t1)

    	la t0, LiuKangDancando_2
    	la t1, DANCINHA_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlock_1
    	la t1, BLOCK_EM_PE_IO
    	sw t0, 0(t1)

    	la t0, LiuKangBlock_3V
    	la t1, DESATIVAR_BLOCK_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_1
    	la t1, BLOCK_AGACHADO_IO
    	sw t0, 0(t1)

 	la t0, LiuKangBlockAgachado_3V
    	la t1, DESATIVAR_BLOCK_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangBlockAgachado_2
    	la t1, BLOQUEANDO_AGACHADO_IO
    	sw t0, 0(t1)    
    	
    	la t0, LiuKangBlock_2
    	la t1, BLOQUEANDO_EM_PE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomou_1
    	la t1, RECUADA_LEVE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangHelicoptero_1
    	la t1, RECUADA_PESADA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCaiu_1
    	la t1, LEVOU_RASTEIRA_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangVoando_1
    	la t1, TOMOU_ALPISTE_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangTomouAgachado_1
    	la t1, RECUADA_LEVE_AGACHADO_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_1
    	la t1, TONTO_1_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangFinish_3
    	la t1, TONTO_2_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_1
    	la t1, FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangSemCabeca_6
    	la t1, ULTIMO_FATALITY_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_1
    	la t1, MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangRound_6
    	la t1, ULTIMO_MORREU_IO
    	sw t0, 0(t1)
    	
    	la t0, LiuKangCabeca_1
    	la t1, CABECA_IO
    	sw t0, 0(t1)
 
    	la t0, LiuKangVitoria_1
    	la t1, VITORIA_1_IO 
    	sw t0, 0(t1)   	
    	
    	la t0, LiuKangVitoria_2
    	la t1, VITORIA_2_IO 
    	sw t0, 0(t1)  
    	
    	la s10, DANCINHA_1_IO
	
	j FIM
	
	j FIM
FIM:
	lw ra, 0(sp)
	addi sp, sp, 4
	
	la tp,KDInterrupt    # carrega em tp o endereço base das rotinas de Tratamento da Interrupção
    	csrrw zero,5,tp     # seta utvec (reg 5) para o endereço tp
     	csrrsi zero,0,1     # seta o bit de habilitação de interrupção global em ustatus (reg 0)
    	li tp,0x100
     	csrrw zero,4,tp        # habilita a interrupção do usuário

     	li t1,0xFF200000    # Endereço de controle do KDMMIO
    	li t0,0x02        # bit 1 habilita/desabilita a interrupção
    	sw t0,0(t1)           # Habilita interrupção do teclado
	
	ret
