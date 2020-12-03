############################################################################################
# a4 = altura do personagem
# a5 = largura do personagem
# a6 = inicio da memória vga
# a7 = inicio do personagem
############################################################################################

LIMPAR:	
	mv t0, a7			# t0 = personagem 1 inicio
	#sub t0, t0, a5
	#ebreak
	li t2, -320
	
	mv t4, a4			# t4 = altura do personagem
						
	mul t2, t2, t4			# -320 * altura do personagem
	add t0, t0, t2			# t0 = canto superior esquerdo do personagem
	
	mv t6, a5			# t6 = largura do personagem
	
	#ebreak
	add t1, t0, t6			# t1 = PERSONAGEM1_FINAL
		
	mv t2, a6			# t2 = inicio da memória VGA
	sub t0, t0, t2			# t0 = diferença entre memória vga e inicio do personagem

	addi a1, a1, 8			# addi mágico no background
	add  a1, a1, t0			# a1 = background na posição inicial do personagem
	
	add t2, t2, t0			# t2 = memória vga na posição inicial do personagem
	
PRE_LOOP_LIMPAR:	
	li t3, 0			# t3 = contador de linhas
	
LOOP_LIMPAR:
	#lw t5, 0(a1)			# carrega os pixels da imagem
	li t5, 0xFFFFFFFF
	sw t5, 0(t2)			# pinta a imagem
	
	addi t2, t2, 4 			# incrementa posição da vga
	addi a1, a1, 4			# incrementa a imagem

	bge t2, t1, LIMPAR_NOVA_LINHA 	# se chegar no final da linha
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
