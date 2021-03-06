############################################################################################
#Esse procedimento apaga um personagem na tela
#a0 = Personagem a ser apagado
#a1 = background
#s8 = largura do personagem
#s7 = altura do personagem
#			$$$$$ Nenhum registrador salvo � alterado $$$$$
############################################################################################

APAGAR:
	la t0, PERSONAGEM1_INICIO	
	lw t0, 0(t0)			# t0 = posi��o inicial do personagem
	
	li t2, -320
	la t4, ALTURA1
	lw t4, 0(t4)			
	mul t2, t2, t4			# -320 * altura do personagem
	add t0, t0, t2			# t0 = canto superior esquerdo do personagem
	
	la t6, LARGURA1
	lw t6, 0(t6)
	add t1, t0, t6			# t1 = PERSONAGEM1_FINAL

	lw t2, VGA1INICIO		# t2 = inicio da mem�ria VGA
	sub t0, t0, t2			# t0 = diferen�a entre mem�ria vga e inicio do personagem

	addi a1, a1, 8			# addi m�gico no background
	add  a1, a1, t0			# a1 = background na posi��o inicial do personagem
	
	add t2, t2, t0			# t2 = mem�ria vga na posi��o inicial do personagem
	
PRE_LOOP_APAGAR:	
	li t3, 0			# t3 = contador de linhas
	
LOOP_APAGAR:
	lw t5, 0(a1)			# carrega os pixels da imagem
	sw t5, 0(t2)			# pinta a imagem
	
	addi t2, t2, 4 			# incrementa posi��o da vga
	addi a1, a1, 4			# incrementa a imagem

	beq t2, t1, APAGAR_NOVA_LINHA 	# se chegar no final da linha
	j LOOP_APAGAR
	
APAGAR_NOVA_LINHA:
	addi t3, t3, 1 			# incrementa o contador de linhas

	beq t3, t4, FORA_APAGAR		# verifica se atingiu o limite de linhas
	
	addi a1, a1, 320		# leva o background para a linha de baixo
	sub a1, a1, t6			# recua a largura da imagem no background
	addi t2, t2, 320		# leva a mem�ria vga para a linha de baixo
	sub t2, t2, t6			# recua a largura da iagem na mem�ria vga 
	addi t1, t1, 320		# leva a posi��o final do personagem para linha de baixo
	
	j LOOP_APAGAR

FORA_APAGAR:
	ret
