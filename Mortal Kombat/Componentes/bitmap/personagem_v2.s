#############################################################################################
# ENTRADAS:
# a0 = endereço do sprite
# a1 = 1 se o personagem está à esquerda e -1 se está a direita
# a4 = ponteiro da largura do personagem
# a5 = ponteiro da altura do personagem 
# a6 = valor da posição inicial do personagem
# LABEL PERSONAGEM_INICIO = endereço inicial do personagem
#############################################################################################
PERSONAGEM_V2:	
	#li a1, 1
	addi sp, sp, -4
	sw s0, 0(sp)
	li s0, 0xFFFFFFC7
	
	# Carrega e atualiza a largura e altura do personagem
	lw t0, 0(a0)				# t0 = largura do personagem
	sw t0, 0(a4)				# salva a nova largura do personagem
		
	lw t1, 4(a0)				# t1 = altura  do personagem	
	sw t1, 0(a5)				# salva a nova altura do personagem
	
	
	# Calcula a posição na memória vga do sprite a ser pintado
	li t2, -320
	mul t2, t2, t1				# altura * -320
	add t2, t2, a6				# t2 = posição do início do personagem na memória vga
	
	#ebreak
	# Define efetivamente onde estará o apontador do pixel
	mv t3, a0				# t3 = a0
	addi t3, t3, 8
	add t4, t3, t0				# t4 = end final da linha
	li t5, 0				# t5 = contador de linhas

	bge a1, zero, LOOP_PINTAR_PERSONAGEM_V2	# se a1 > 0 (a1 = 1) então começa a pintar o personagem
	add t3, a0, t0				# do contrário t3 = pixel mais à direita 
	addi t3, t3, 7
	addi t4, a0, 7
	sub t2, t2, t0
	#addi t2, t2, -1#####################################
	#sub t4, t3, t0		        	# t4 = end final da linha 
	#addi t4, t4, -2###########################################
	# Pinta efetivamente o sprite
		
LOOP_PINTAR_PERSONAGEM_V2:
	beq t4, t3, FIM_DE_LINHA_V2		# Se t4 = t0 (largura) chegamos ao fim da linha

	lb t6, 0(t3)				# Carrega o pixel correspondente
	beq t6, s0, TRANSPARENTE
	sb t6, 0(t2)				# Pinta o pixel correspondente
TRANSPARENTE:	
	add t3, t3, a1				# Desloca a0 no sentido correto
	addi t2, t2, 1				# Desloca t2 
	#add t4, t4, a1				# Incrementa contador
	
	j LOOP_PINTAR_PERSONAGEM_V2		# Do contrário continuamos a pintar
	
FIM_DE_LINHA_V2:
	addi t5, t5, 1				# Incrementa o contador de linhas
	beq  t5, t1, FIM_PERSONAGEM_V2		# Se t5 = altura, pintamos todo o personagem
	#addi t5, t5, 1	
	
	# t2 deve ser reposicionado
	addi t2, t2, 320			# t2 vai pra linha de baixo
	sub  t2, t2, t0				# t2 = t2 - largura
	#addi sp, sp, -4
	#sw t4, 0(sp)
	
	#li  t4, 320				
	#mul t6, a1, t0				# t6 = a1 * largura
	#sub t4, t4, t6				# t4 = 320 - (a1 * largura)
	#add t2, t2, t4				# Desloca a memória de vídeo
	
	# t4 deve ser reposicionado
	#lw t4, 0(sp)
	#addi sp, sp, 4
	add t4, t4, t0				# t4 = final da linha de baixo do personagem
	
	# t3 deve ser reposionado
	mul t6, a1, t0				# t6 = a1 * largura
	sub  t3, t4, t6				# t3 = t4 - (t6)
	#addi t3, t3, -1
	
	j LOOP_PINTAR_PERSONAGEM_V2
	
FIM_PERSONAGEM_V2:
	mv a0, t3
	bgt a1, zero, RETORNO_PERSONAGEM_V2
	add a0, t3, t0
	addi a0, a0, 1##############################
RETORNO_PERSONAGEM_V2:
	#ebreak
	#lw t1, 0(a0)
	#lw t1, -4(a0)
	#lw t1, -8(a0)
	#lw t1, -12(a0)
	
	csrr t1, 3073

SLEEP_PERSONAGEM:

 	csrr t0,3073 		# le o time atual
	sub t0,t0,t1 		# calcula o tempo
	li t2, 100
	bge t0, t2, FIM_SLEEP_PERSONAGEM
	j SLEEP_PERSONAGEM
	
FIM_SLEEP_PERSONAGEM:	
	
	lw s0, 0(sp)
	addi sp, sp, 4
	ret					# Retorna o fluxo de programa	 
	
	
				
