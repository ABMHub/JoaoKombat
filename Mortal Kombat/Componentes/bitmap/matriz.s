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
	
SZ:	la s10, SubZeroDancando_1
	la a0, SubZeroDancando_1
	
	addi sp, sp, -4
	sw ra, 0(sp)
	

	
	#la a4, ALTURA1			# a4 = endereço da altura
	#la a5, LARGURA1			# a5 = endereço da largura
	li a1, -1 			# da esquerda para direita
	la a6, PERSONAGEM1
	lw a6, PERSONAGEM1
	
	la a4, LARGURA_FRAME_1			# a4 = endereço da largura
	la a5, ALTURA_FRAME_1			# a5 = endereço da altura
	jal ra, PERSONAGEM_V2#############################
	
	la a0, SubZeroDancando_2
	jal ra, FRAME_DANCINHA
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	la tp,KDInterrupt_SubZero    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	li tp,0x100
	csrrw zero,4,tp     	# habilita a interrupção do usuário
	
	j FIM

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
	
	li t1,0xFF200000    	# Endereço de controle do KDMMIO
	li t0,0x02       	# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           	# Habilita interrupção do teclado
	
	ret
