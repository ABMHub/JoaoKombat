############################################################################################
#Procedimento responsável por pintar um personagem na tela
#ENTRADA: a0 = endereço da imagem
#SAIDA:   a0 = sprite subsequente
#
#			$$$$$ Nenhum registrador salvo é alterado $$$$$
############################################################################################

PERSONAGEM:
	la t0, PERSONAGEM1_INICIO
	lw t0, 0(t0)			#t0 = posição inicial do personagem
	
	lw t4, 0(a0)			#t1 = largura do personagem
	add t1, t0, t4			#t1 = posição final do personagem
	
ALT:	lw t6, 4(a0)			#t6 = altura do personagem
	addi a0, a0, 8			#addi mágico
	
	li t3, 1			#contador de linhas
	
LOOP_PERSONAGEM:
	beq t0, t1, SALTAR_LINHA
	
	lw t2, 0(a0)			# carrega os pixels da imagem
	sw t2, 0(t0)			# escreve os pixels de a0 na memória vga
	
	addi t0, t0, 4			# incrementa as colunas da memória vga
	addi a0, a0, 4			# incrementa a imagem em 4 pixels
	j LOOP_PERSONAGEM
	
SALTAR_LINHA:	
	beq t3, t6, FIM_PERSONAGEM	# verifica se todas as linhas já foram escritas
	
	addi t3, t3, 1			# incrementa o contador de linhas
	addi t1, t1, 320		# desloca a posição final do personagem para a linha de baixo
	addi t0, t0, 320		# desloca a posição inicial do personagem para a linha de baixo
	sub  t0, t0, t4			# subtrai a largura do personagem da posição inicial (que no momento é igual a final)
	
	j LOOP_PERSONAGEM
	
FIM_PERSONAGEM:

	ret
	
	
