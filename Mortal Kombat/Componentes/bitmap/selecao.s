SELECAO:
	addi sp, sp, -4
	sw ra, 0(sp)
	li s0, 0		#contador linha
	li s1, 0		#contador coluna
	li s2, 3		#limite linha
	li s3, 2		#limite coluna
	
	li s4, 36		#andar na linha
	li s5, 15360		#andar na coluna
	
	la a0, MenuDeEscolha		#background da seleÃ§Ã£o
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	la a0, MenuDeEscolha
	
	la t0, VGA2INICIO
	lw a1, 0(t0)			# ta1 = inicio da memória vga
	la t0, VGA2FINAL
	lw a2, 0(t0)			# ta2 = final da memória vga
	
	jal ra, BACKGROUND		# argumento em a0 = fundo
	
	la t0, CENARIO_ATUAL
	la t1, MenuDeEscolha
	sw t1, 0(t0)

	#Pinta seletor em uma frame na posição inicial
	la a0, Seletor
	li a2, 1
	jal ra, S_FRAME_GOLPE_VGA	#printa o seletor
	
	#Pinta seletor na outra frame na posição inicial
	la a0, Seletor
	jal ra, S_FRAME_DANCINHA
	
	jal ra, QUEM_EH
	
KEY: 	li t1, 0xFF200000		# carrega o endereÃ§o de controle do KDMMIO
	sw zero, 0(t1)	
POOL: 	lw t0, 0(t1)			# Le bit de Controle Teclado
   	andi t0, t0, 0x0001		# mascara o bit menos significativo
   	
   	li t4, 0xFF200604
	lw t3, 0(t4)
	xori t3, t3, 1
	sw t3, 0(t4)
	
	csrr t3, 3073
	
DORME_PERSONAGEM:

 	csrr t5,3073 		# le o time atual
	sub t5,t5,t3 		# calcula o tempo
	li t2, 500
	bge t5, t2, LOOP_FIM_OU_NAO
	j DORME_PERSONAGEM
	
LOOP_FIM_OU_NAO:
   	beq t0, zero, POOL		# nÃ£o tem tecla pressionada entÃ£o volta ao loop
   	
   	lw t2, 4(t1)			# le o valor da tecla
   	
SWITCH_MENU:
	li t3, 'a'
	beq t3, t2, Persona_Es
	
	li t3, 'd'
	beq t3, t2, Persona_Di
	
	li t3, 'w'
	beq t3, t2, Persona_Ci
	
	li t3, 's'
	beq t3, t2, Persona_Ba
	
	li t3, ' '
	beq t3, t2, FIM_ESCOLHA
	
DEFAULT:
	j KEY
	
#######################################################################
Persona_Es:
	beq s0, zero, DEFAULT		#fora do limite
	
	#Apaga o seletor
	la a0, ApagarSeletor_1
	li a2, 2
	li a3, 0
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	#Pinta nova posição do seletor
	la a0, Seletor
	li a2, 1
	sub a3, zero, s4
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	la a0, Seletor
	jal ra, S_FRAME_DANCINHA
	
	addi s0, s0, -1
	jal ra, QUEM_EH
	j DEFAULT
	
	
Persona_Di:
	beq s0, s2, DEFAULT		#fora do limite
	
	#Apaga o seletor
	la a0, ApagarSeletor_1
	li a2, 2
	li a3, 0
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	#Pinta nova posição do seletor
	la a0, Seletor
	li a2, 1
	mv a3, s4
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	la a0, Seletor
	jal ra, S_FRAME_DANCINHA
	
	addi s0, s0, 1
	jal ra, QUEM_EH
	j DEFAULT
	
Persona_Ci:
	beq s1, zero, DEFAULT		#fora do limite
	
	#Apaga o seletor
	la a0, ApagarSeletor_1
	li a2, 2
	li a3, 0
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	#Pinta nova posição do seletor
	la a0, Seletor
	li a2, 1
	sub a3, zero, s5
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	la a0, Seletor
	jal ra, S_FRAME_DANCINHA
	
	addi s1, s1, -1
	jal ra, QUEM_EH
	j DEFAULT
	
Persona_Ba:
	beq s1, s3, DEFAULT		#fora do limite
	
	#Apaga o seletor
	la a0, ApagarSeletor_1
	li a2, 2
	li a3, 0
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	#Pinta nova posição do seletor
	la a0, Seletor
	li a2, 1
	mv a3, s5
	jal ra, S_FRAME_DESLOCAMENTO_VGA
	
	la a0, Seletor
	jal ra, S_FRAME_DANCINHA
	
	addi s1, s1, 1
	jal ra, QUEM_EH
	j DEFAULT
	
			
FIM_ESCOLHA:
	lw ra, 0(sp)
	addi sp, sp, 4
	
	li t2, 0xFF200000
	sw zero, 0(t1)
	sw zero, 4(t1)
	
	la t0, PERSONAGEM1_INICIO
	li t1, 0xFF010410
	sw t1, 0(t0)
	
	ret
	
	
################################################ DESCOBRE PERSONAGEM ################################################################
QUEM_EH:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t0, 0
	li t1, 1
	li t2, 2
	li t3, 3
	
	beq s0, t0, C_ZERO	#Está na coluna Zero
	beq s0, t1, C_UM	#Está na coluna Um
	beq s0, t2, C_DOIS	#Está na coluna Dois
	beq s0, t3, C_TRES	#Está na coluna Três
	
C_ZERO:
	beq s1, t0, LK_DANCA	#Liu Kang dança
	beq s1, t1, SZ_DANCA	#SubZero dança
	beq s1, t2, Mi_DANCA	#Mileena dança
C_UM:
	beq s1, t0, KL_DANCA	#Kung Lao dança
	beq s1, t1, ST_DANCA	#Shang Tsung dança
	beq s1, t2, Ba_DANCA	#Baraka dança
C_DOIS:
	beq s1, t0, JC_DANCA	#Johnny Cage dança
	beq s1, t1, Ki_DANCA	#Kitana dança
	beq s1, t2, SC_DANCA	#Scorpion dança
C_TRES:
	beq s1, t0, Re_DANCA	#Reptile dança
	beq s1, t1, Ja_DANCA	#Jax dança
	beq s1, t2, Ra_DANCA	#Raiden dança
	
LK_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, LiuKangDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, LiuKangDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
SZ_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, SubZeroDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, SubZeroDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Mi_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, MileenaDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, MileenaDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
KL_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, KungLaoDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0 KungLaoDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
ST_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ShangTsungDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ShangTsungDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Ba_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, LiuKangDancando_1
	#la a0, BarakaDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, LiuKangDancando_2
	#la a0, BarakaDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
JC_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, JohnnyCageDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, JohnnyCageDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Ki_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, KitanaDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, KitanaDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
SC_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ScorpionDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ScorpionDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Re_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ReptileDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, ReptileDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Ja_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	la a0, JaxDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	la a0, JaxDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
Ra_DANCA:
	la a0, ApagarDancinha_1
	li a1, 1
	li a2, 2
	jal ra, FRAME_GOLPE_VGA
	
	#la a0, LiuKangDancando_1
	la a0, RaidenDancando_1
	li a1, 1
	li a2, 1
	jal ra, FRAME_GOLPE_VGA
	
	#la a0, LiuKangDancando_2
	la a0, RaidenDancando_2
	jal ra, FRAME_DANCINHA
	
	j FIM_QUEM_EH
	
FIM_QUEM_EH:
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
