############################################################################################
# a1 = 1 se o personagem está a à esquerda e -1 se está a direita
# a4 = endereço da largura do personagem
# a5 = endereço da altura  do personagem
# a7 = inicio da memória vga
# a6 = inicio do personagem
############################################################################################
LIMPAR:
	#li a1, 1


	#Primeiro encontramos o canto superior esquerdo do personagem
	#ebreak
	mv t0, a6				# t0 = inicio do personagem na memória vga
	
	li t1, -320
	lw t2, 0(a5)				# t2 = altura do personagem
	mul t1, t1, t2		
	
	add t0, t0, t1				# t0 = canto superior do personagem	
		
	bgt a1, zero, PRE_LOOP_APAGAR_V3	# nesse caso t0 já está canto superior esquerdo
	# se chegar até aqui, t0 está no canto superior direito
	lw t1, 0(a4)				# t1 = largura do personagem
	sub t0, t0, t1				# t0 = canto superior esquerdo do personagem
	
PRE_LOOP_APAGAR_V3:
	# t0 = canto superior esquerdo do personagem na memória VGA
	#ebreak
	sub t2, t0, a7				# t2 = diferença entre memória vga e inicio do personagem
	addi t1, s9, 8
	add t1, t1, t2
	
	# t0 = endereço da memória VGA no canto superior esquerdo do personagem
	# t1 = endereço da imagem que deve sobrescrever a partir do endereço em t0
	
	li t2, 0				# contador de colunas
	lw t3, 0(a4)				# limite de colunas
	
	li t4, 0				# contador de linhas
	lw t5, 0(a5)				# limite de linhas
	
	# apagamos efetivamente
LIMPAR_V3:
	beq t2, t3, LIMPAR_NOVA_LINHA_V3
	#li t6, 0xFFFFFFFF
	lb t6, 0(t1)				# carrega a imagem que será sobrescrita
	sb t6, 0(t0)				# pinta o que foi carregado
	
	addi t0, t0, 1				# desloca o endereço em uma word
	addi t1, t1, 1				# desloca a imagem em uma word
	
	addi t2, t2, 1				# desloca a largura em 4 pixels
	
	j LIMPAR_V3
					
LIMPAR_NOVA_LINHA_V3:
	beq t4, t5, FIM_LIMPAR_V3
	
	mv t2, zero				# reinicia o contador de colunas
	addi t4, t4, 1				# incrementa o contador de linhas
	
	addi t0, t0, 320			# leva o endereço da VGA pra linha de baixo
	sub t0, t0, t3				# recua a largura do personagem
				
	addi t1, t1, 320			# leva o endereço da imagem pra linha de baixo
	sub t1, t1, t3				# recua a largura do personagem
	
	j LIMPAR_V3
	
FIM_LIMPAR_V3:

	ret
