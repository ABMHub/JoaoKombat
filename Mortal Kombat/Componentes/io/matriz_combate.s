.text

####################################################################
# Função para uso interno. Retorna em a0 o endereço do canto       #
# inferior esquerdo na matriz de combate                           #
####### Input ########                                             #
# a0 = jogador (1 ou 2)         
####### Output #######
# a0 = endereço do index inferior direto da matriz
# a1 = CONTADORH                 #
####################################################################

CALCULA_CONTADOR:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t0, 2
	beq t0, a0, CONTADOR_J2	# beq para carregar pos do jogador 1 ou 2
	
CONTADOR_J1: # Carrega posição do jogador 1
	lw t0, CONTADORV1
	lw t1, CONTADORH1
	j POS_BEQ_CONTADOR
	
CONTADOR_J2: # Carrega posição do jogador 2
	lw t0, CONTADORV2
	lw t1, CONTADORH2
	
POS_BEQ_CONTADOR:
	mv a1, t1
	li t2, 20		# 20 == largura
	mul t0, t0, t2		# medição vertical * 20 para percorrer verticalmente a matriz
	add t0, t0, t1		# t0 é o index inferior esquerdo da hitbox
	
	mv t1, a0		# carrega numero do jogador para escrever na matriz
	la t2, MATRIZ_COMBATE	# carrega endereço da matriz de combate
	add a0, t2, t0		# t0 é agora o canto inferior esquerdo da hitbox
	
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# volta

####################################################################
# Função de escrever na matriz de combate a posição do personagem  #
####### Input ########                                             #
# a0 = jogador (1 ou 2)                                            #
# a1 = altura (em blocos da matriz)                                #
# a2 = largura (em blocos da matriz)                               #
####################################################################
	
ESCREVE_POSICAO_MATRIZ:
	addi sp, sp, -4
	sw ra, 0(sp)

	mv t1, a0
	mv t3, a1
	jal ra, CALCULA_CONTADOR
	mv a1, t3
	mv t0, a0

	li t2, 0		# contador de loop interno
	li t3, 0		# contador de loop externo
		
LOOP_CONTADOR:
	sb t1, 0(t0)		# salva n do jogador na posição da matriz
	addi t2, t2, 1		# aumenta contador
	addi t0, t0, 1		# itera horizontalmente
	bne t2, a2, LOOP_		# continua o loop caso precise
	
	sub t0, t0, t2
	li t2, 0		# reseta contador interno
	addi t3, t3, 1		# aumenta contador externo
	addi t0, t0, -20	# sobe uma posição verticalmente
	bne t3, a1, LOOP_CONTADOR 	# continua loop caso precise
	
	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# tchauzinho
	
####################################################################
# Função de testar soco
####### Input ########
# a0 = jogador (1 ou 2)              ?
# a1 = tipo de golpe
# 	0 - soco		4 - soco agachado
#	1 - jab			5 - alpiste
#	2 - chute baixo		6 - chute agachado
#	3 - chute alto		7 - rasteira
####################################################################

TESTE_GOLPE:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	
	mv t3, a1
	jal ra, CALCULA_CONTADOR
	mv t0, a0
	mv a1, t3
	
	lw t1, CONTADORH1
	lw t2, CONTADORH2
	
	li t3, 2
	beq t3, a0, TESTE_PER2
	
	sub t1, t1, t2
	bgtz t1, TESTE_INVERTIDO
	j TESTE_NORMAL
	
TESTE_PER2:
	sub t1, t2, t1
	bgtz t1, TESTE_INVERTIDO
	
TESTE_NORMAL:
	addi t0, t0, 1
	li t2, 1
	j TESTE_CASE
	
TESTE_INVERTIDO:
	li t2, -1
	
TESTE_CASE:
	li t1, 0
	beq t1, a1, TESTE_SOCO
	
	li t1, 1
	beq t1, a1, TESTE_JAB
	
	li t1, 2
	beq t1, a1, TESTE_CHUTE_BAIXO
	
	li t1, 3
	beq t1, a1, TESTE_CHUTE_ALTO
	
TESTE_SOCO:
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	j FIM_TESTE
	
TESTE_JAB:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	addi t0, t0, -20
	lb t3, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t3, HIT
	j FIM_TESTE
	
TESTE_CHUTE_BAIXO:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
TESTE_CHUTE_ALTO:	
	addi t0, t0, -60
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -80
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
TESTE_SOCO_AGACHADO:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	bnez t1, HIT
	j FIM_TESTE
	
TESTE_ALPISTE:
	addi t0, t0, -40
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	addi t0, t0, -20
	lb t3, 0(t0)
	
	addi t0, t0, 20
	add t0, t0, t2
	lb t4, 0(t4)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t3, HIT
	bnez t4, HIT
	j FIM_TESTE
	
TESTE_CHUTE_AGACHADO:
	add t0, t0, t2
	lb t1, 0(t0)
	
	addi t0, t0, -20
	lb t2, 0(t0)
	
	add t0, t0, t2
	lb t3, 0(t0)
	
	addi t0, t0, 20
	lb t4, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	bnez t3, HIT
	bnez t4, HIT
	j FIM_TESTE
	
TESTE_RASTEIRA:
	add t0, t0, t2
	lb t1, 0(t0)
	
	add t0, t0, t2
	lb t2, 0(t0)
	
	bnez t1, HIT
	bnez t2, HIT
	j FIM_TESTE
	
HIT:	
	li a0, 60
	li a1, 500
	li a2, 0
	li a3, 50
	li a7, 31
	ecall
	
FIM_TESTE:
	lw ra, 0(sp)		# restora ra
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	addi sp, sp, 16		# restora sp
	
	ret			# tchauzinho
	
####################################################################
# Funções de colisão de movimento
# Altera a1
####### Input  ########
# a0 = 1 (player 1), 2 (player 2)
####### Output ########
# a0 = 1 (caso tenha colisão), 0 (caso não tenha)
####################################################################

VERIFICA_CONTADOR_ESQUERDA:
	mv t3, t0
	mv t4, t1

	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t1, a0
	jal ra, CALCULA_CONTADOR
	mv t0, a0
	mv t1, a1
	
	li t2, 0
	ble t1, t2, COLISAO
	
	lb t1, -1(t0)
	bnez t1, COLISAO
	
	li a0, 0
	j FIM_VERIFICA_CONTADOR
	
VERIFICA_CONTADOR_DIREITA:
	mv t3, t0
	mv t4, t1

	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t1, a0
	jal ra, CALCULA_CONTADOR
	mv t0, a0
	mv t1, a1
	
	li t2, 18
	bge t1, t2, COLISAO
	
	lb t1, 2(t0)
	bnez t1, COLISAO
	
	li a0, 0
	j FIM_VERIFICA_CONTADOR
		
COLISAO:
	li a0, 1
	
FIM_VERIFICA_CONTADOR:
	mv t0, t3
	mv t1, t4

	lw ra, 0(sp)		# restora ra
	addi sp, sp, 4		# restora sp
	
	ret			# tchauzinh
