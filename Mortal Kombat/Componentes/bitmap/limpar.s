LIMPAR:
	#mv a1, s9
	la t0, PERSONAGEM1_INICIO_ANTIGO
	lw t0, 0(t0)
	
	li t2, -320
	la t4, ALTURA1ANTIGA
	lw t4, 0(t4)			
	mul t2, t2, t4			# -320 * altura do personagem
	add t0, t0, t2			# t0 = canto superior esquerdo do personagem
	
	la t6, LARGURA1ANTIGA
	lw t6, 0(t6)
	add t1, t0, t6			# t1 = PERSONAGEM1_FINAL
	
	
	lw t2, VGA1INICIO		# t2 = inicio da memória VGA
	sub t0, t0, t2			# t0 = diferença entre memória vga e inicio do personagem

	addi a1, a1, 8			# addi mágico no background
	add  a1, a1, t0			# a1 = background na posição inicial do personagem
	
	add t2, t2, t0			# t2 = memória vga na posição inicial do personagem
	
PRE_LOOP_LIMPAR:	
	li t3, 0			# t3 = contador de linhas
	
LOOP_LIMPAR:
	lw t5, 0(a1)			# carrega os pixels da imagem
	sw t5, 0(t2)			# pinta a imagem
	
	addi t2, t2, 4 			# incrementa posição da vga
	addi a1, a1, 4			# incrementa a imagem

	beq t2, t1, LIMPAR_NOVA_LINHA 	# se chegar no final da linha
	j LOOP_LIMPAR
	
LIMPAR_NOVA_LINHA:
	addi t3, t3, 1 			# incrementa o contador de linhas

	beq t3, t4, FORA_LIMPAR		# verifica se atingiu o limite de linhas
	
	addi a1, a1, 320		# leva o background para a linha de baixo
	sub a1, a1, t6			# recua a largura da imagem no background
	addi t2, t2, 320		# leva a memória vga para a linha de baixo
	sub t2, t2, t6			# recua a largura da iagem na memória vga 
	addi t1, t1, 320		# leva a posição final do personagem para linha de baixo
	
	j LOOP_LIMPAR

FORA_LIMPAR:
	ret
