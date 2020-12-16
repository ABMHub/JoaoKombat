TORRE_MK:
	addi sp, sp, -12		#Salva na pilha
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	
	la s1, VETOR_INIMIGOS		#Carrega para a0 o endereço do vetor de inimigos

	la t0, PARTIDA			#Carrega em qual partida o jogo se enconstra 
	lw s0, 0(t0)			#Qual partida está
	
	li t1, 3
	bge t1, s0, FIRST_STAGE		#Vai para a primeira img da montanha
	
	li t1, 7
	bge t1, s0, SECOND_STAGE	#Vai para a segunda img da montanha
	
	li t1, 11
	bge t1, s0, THIRD_STAGE		#Vai para a terceira img da montanha
	
	j LAST_STAGE			#Vai para a última img da montanha
	
	
FIRST_STAGE:
	la a0, Montanha_4
	
	li t0,0xFF200604        	# Escolhe a frame 0
    	sw zero, 0(t0)        		
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	lw a0, 0(s1)			#Primeiro personagem
	li a6, 0xFF011F10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 4(s1)			#Segundo personagem
	li a6, 0xFF00D690
	jal ra, CASE_PERSONAGEM
	
	lw a0, 8(s1)			#Terceiro personagem
	li a6, 0xFF008E10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 12(s1)			#Quarto personagem
	li a6, 0xFF004590
	jal ra, CASE_PERSONAGEM
	
	li a6, 0xFF011EBC
	li t1, -18560			#Distância entre as imgs
	li t2, 4			#Modulo 4
	remu t0, s0, t2
	mul t1, t1, t0			#Multiplica pela partida
	add a6, a6, t1			#Endereço onde será pintado o icone
	
	la a0, FOTINHA_IO		#Fotinha do Player
	lw a0, 0(a0)
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_TORRE
	
SECOND_STAGE:
	la a0, Montanha_3
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	lw a0, 16(s1)			#Primeiro personagem
	li a6, 0xFF011F10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 20(s1)			#Segundo personagem
	li a6, 0xFF00D690
	jal ra, CASE_PERSONAGEM
	
	lw a0, 24(s1)			#Terceiro personagem
	li a6, 0xFF008E10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 28(s1)			#Quarto personagem
	li a6, 0xFF004590
	jal ra, CASE_PERSONAGEM
	
	li a6, 0xFF011EBC
	li t1, -18560			#Distância entre as imgs
	li t2, 4			#Modulo 4
	remu t0, s0, t2
	mul t1, t1, t0			#Multiplica pela partida
	add a6, a6, t1			#Endereço onde será pintado o icone
	
	la a0, FOTINHA_IO		#Fotinha do Player
	lw a0, 0(a0)
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_TORRE
	
THIRD_STAGE:
	la a0, Montanha_2
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	lw a0, 32(s1)			#Primeiro personagem
	li a6, 0xFF011F10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 36(s1)			#Segundo personagem
	li a6, 0xFF00D690
	jal ra, CASE_PERSONAGEM
	
	lw a0, 40(s1)			#Terceiro personagem
	li a6, 0xFF008E10
	jal ra, CASE_PERSONAGEM
	
	lw a0, 44(s1)			#Quarto personagem
	li a6, 0xFF004590
	jal ra, CASE_PERSONAGEM
	
	li a6, 0xFF011EBC
	li t1, -18560			#Distância entre as imgs
	li t2, 4			#Modulo 4
	remu t0, s0, t2
	mul t1, t1, t0			#Multiplica pela partida
	add a6, a6, t1			#Endereço onde será pintado o icone
	
	la a0, FOTINHA_IO		#Fotinha do Player
	lw a0, 0(a0)
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_TORRE
	
LAST_STAGE:
	la a0, Montanha_1
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	la a0, Fotinha_KT		#Mostrar a fotinha do Kintaro
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	li a6, 0xFF011B50
	jal ra, PERSONAGEM_V2
	
	li a6, 0xFF011AFC
	la a0, FOTINHA_IO		#Fotinha do Player
	lw a0, 0(a0)
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
FIM_TORRE:
	li a7, 32
	li a0, 1500
	ecall 

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12		#Carrega da pilha
	
	ret
	
##########################################################################################################################################	
CASE_PERSONAGEM:
	addi sp, sp, -4		#Salva o ra na pilha
	sw ra, 0(sp)

	li t1, 0
	beq t1, a0, LK_1	#Liu Kang
	
	li t1, 1
	beq t1, a0, SZ_1	#SubZero
	
	li t1, 2
	beq t1, a0, Mi_1	#Mileena
	
	li t1, 3
	beq t1, a0, KL_1	#Kung Lao
	
	li t1, 4
	beq t1, a0, ST_1	#Shang Tsung
	
	li t1, 5
	beq t1, a0, Ba_1	#Baraka
	
	li t1, 6
	beq t1, a0, JC_1	#Jonnhy Cage
	
	li t1, 7
	beq t1, a0, Ki_1	#Kitana
	
	li t1, 8
	beq t1, a0, SC_1	#Scorpion
	
	li t1, 9
	beq t1, a0, Re_1	#Reptile
	
	li t1, 10
	beq t1, a0, Ja_1	#Jax
	
	li t1, 11
	beq t1, a0, Ra_1	#Raiden
	
	
LK_1:	
	la a0, Fotinha_LK		#Icone do Liu Kang
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
SZ_1:	
	la a0, Fotinha_SZ		#Icone do Sub Zero
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Mi_1:	
	la a0, Fotinha_MI		#Icone do Mileena
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
KL_1:	
	la a0, Fotinha_KL		#Icone do Kung Lao
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
ST_1:	
	la a0, Fotinha_ST		#Icone do Shang Tsung
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Ba_1:	
	la a0, Fotinha_BA		#Icone do Baraka
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
JC_1:	
	la a0, Fotinha_JC		#Icone do Johnny Cage
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Ki_1:	
	la a0, Fotinha_KI		#Icone do Kitana
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
SC_1:	
	la a0, Fotinha_SC		#Icone do Scorpion
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Re_1:	
	la a0, Fotinha_RE		#Icone do Reptile
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Ja_1:	
	la a0, Fotinha_JA		#Icone do Jax
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
Ra_1:	
	la a0, Fotinha_RA		#Icone do Raiden
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	j FIM_CASE_FOTINHA
	
FIM_CASE_FOTINHA:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#################################################################################################################################
MOSTRA_TUDO:
	li t1,0xFF200000    		# Endereço de controle do KDMMIO
	li t0,0x01       		# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           		# Habilita interrupção do teclado

	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	
	la s2, VETOR_INIMIGOS		#Carrega para a0 o endereço do vetor de inimigos
	
	li t0, 0xFF200604 
	sw zero, 0(t0)
	
	la a0, Montanha_1
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	la a0, Fotinha_KT		#Mostrar a fotinha do Kintaro
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	li a6, 0xFF011B50
	jal ra, PERSONAGEM_V2
	
	li a7, 32
	li a0, 1500
	ecall
	
	#ebreak
	
	la a0, Montanha_2
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	li a6, 0xFF004590		#Valor do icone final
	li s0, 44			#Posição do ultimo elemento
	add s1, s0, s2			#Ultimo elemento do vetor		
	
TORRE1:	
	lw a0, 0(s1)			#Quarto personagem
	jal ra, CASE_PERSONAGEM
	addi s1, s1, -4
	addi s0, s0, -4
	li t1, 18560
	add a6, a6, t1
	li t1, 28
	bne t1, s0, TORRE1
	
	li a7, 32
	li a0, 1500
	ecall
	
	#ebreak
	
	la a0, Montanha_3
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	li a6, 0xFF004590		#Valor do icone final
	
TORRE2:	
	lw a0, 0(s1)			#Quarto personagem
	jal ra, CASE_PERSONAGEM
	addi s1, s1, -4
	addi s0, s0, -4
	li t1, 18560
	add a6, a6, t1
	li t1, 12
	bne t1, s0, TORRE2
	
	li a7, 32
	li a0, 1500
	ecall
	
	#ebreak
	
	la a0, Montanha_4
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	li a6, 0xFF004590		#Valor do icone final
	
TORRE3:	
	lw a0, 0(s1)			#Quarto personagem
	jal ra, CASE_PERSONAGEM
	addi s1, s1, -4
	addi s0, s0, -4
	li t1, 18560
	add a6, a6, t1
	li t1, -4
	bne t1, s0, TORRE3
	
	li a6, 0xFF011EBC
	li t1, -18560			#Distância entre as imgs
	li t2, 4			#Modulo 4
	remu t0, s0, t2
	mul t1, t1, t0			#Multiplica pela partida
	add a6, a6, t1			#Endereço onde será pintado o icone
	
	la a0, FOTINHA_IO		#Fotinha do Player
	lw a0, 0(a0)
	li a1, 1
	la a4, FOTINHA_INIM_LARG
	la a5, FOTINHA_INIM_ALT
	jal ra, PERSONAGEM_V2
	
	li a7, 32
	li a0, 1500
	ecall
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 4
	
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x02       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado
	
	ret
	
	
