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
	beq s1, t0, LK
	beq s1, t1, SZ
	beq s1, t2, Mi
	
COLUNA_UM:
	beq s1, t0, KL
	beq s1, t1, ST
	beq s1, t2, Ba

COLUNA_DOIS:
	beq s1, t0, JC
	beq s1, t1, Ki
	beq s1, t2, SC
	
COLUNA_TRES:
	beq s1, t0, Re
	beq s1, t1, Ja
	beq s1, t2, Ra
	

LK:	#la s10, LiuKangParado_1
	#la a0, LiuKangParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_LiuKang    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
SZ:	 
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
    	
    	la s10, DANCINHA_1_IO

	j FIM
    #la a4, ALTURA1            # a4 = endereço da altura
    #la a5, LARGURA1        # a5 = endereço da largura

Mi:	#la s10, MileenaParada_1
	#la a0, MileenaParada_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_Mileena    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM

KL:	#la s10, KungLaoParado_1
	#la a0, KungLaoParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_KungLao    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM

ST:	#la s10, ShangTsungParado_1
	#la a0, ShangTsungParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_ShangTsung    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
Ba:	#la s10, BarakaParado_1
	#la a0, BarakaParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_Baraka    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
JC:	#la s10, JohnnyCageParado_1
	#la a0, JohnnyCageParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_JohnnyCage    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
Ki:	#la s10, KitanaParada_1
	#la a0, KitanaParada_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_Kitana    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM
	
SC:	#la s10, ScorpionParado_1
#	la a0, ScorpionParado_1
#	
#	addi sp, sp, -4
#	sw ra, 0(sp)
#	
#	jal ra, PERSONAGEM
#	
#	lw ra, 0(sp)
#	addi sp, sp, 4
#	
#	la tp,KDInterrupt_Scorpion    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
#	csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
#	csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
#	li tp,0x100
#	csrrw zero,4,tp     	# habilita a interrupção do usuário
#	
#	j FIM
	
Re:	#la s10, ReptileParado_1
	#la a0, ReptileParado_1
	
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	#jal ra, PERSONAGEM
	
	#lw ra, 0(sp)
	#addi sp, sp, 4
	
	#la tp,KDInterrupt_Reptile    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	#csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	#csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	#li tp,0x100
	#csrrw zero,4,tp     	# habilita a interrupção do usuário
	
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
	
Ra:	#la s10, RaidenParado_1
	#la a0, RaidenParado_1
	
#	addi sp, sp, -4
#	sw ra, 0(sp)
#	
#	jal ra, PERSONAGEM
#	
#	lw ra, 0(sp)
#	addi sp, sp, 4
#	
#	la tp,KDInterrupt_Raiden   	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
#	csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
#	csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
#	li tp,0x100
#	csrrw zero,4,tp     	# habilita a interrupção do usuário
	#csrrci zero,0,1     		# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	
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
