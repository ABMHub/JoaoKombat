############################################################################################
#Procedimento respons�vel por pintar um personagem na tela
#ENTRADA: a0 = endere�o da imagem
#SAIDA:   a0 = sprite subsequente
#
#			$$$$$ Nenhum registrador salvo � alterado $$$$$
############################################################################################

PERSONAGEM:
	la t0, PERSONAGEM1_INICIO
	lw t0, 0(t0)			#t0 = posi��o inicial do personagem
	
	lw t4, 0(a0)			#t1 = largura do personagem
	add t1, t0, t4			#t1 = posi��o final do personagem
	
ALT:	lw t6, 4(a0)			#t6 = altura do personagem
	addi a0, a0, 8			#addi m�gico
	
	li t3, 1			#contador de linhas
	
LOOP_PERSONAGEM:
	beq t0, t1, SALTAR_LINHA
	
	lw t2, 0(a0)			# carrega os pixels da imagem
	sw t2, 0(t0)			# escreve os pixels de a0 na mem�ria vga
	
	addi t0, t0, 4			# incrementa as colunas da mem�ria vga
	addi a0, a0, 4			# incrementa a imagem em 4 pixels
	j LOOP_PERSONAGEM
	
SALTAR_LINHA:	
	beq t3, t6, FIM_PERSONAGEM	# verifica se todas as linhas j� foram escritas
	
	addi t3, t3, 1			# incrementa o contador de linhas
	addi t1, t1, 320		# desloca a posi��o final do personagem para a linha de baixo
	addi t0, t0, 320		# desloca a posi��o inicial do personagem para a linha de baixo
	sub  t0, t0, t4			# subtrai a largura do personagem da posi��o inicial (que no momento � igual a final)
	
	j LOOP_PERSONAGEM
	
FIM_PERSONAGEM:

	ret
	
	
