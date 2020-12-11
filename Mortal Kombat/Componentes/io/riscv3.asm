DIREITA:
	la t0, AGACHADO_IO			# Coloca em t0 o endereço geral 
	beq t0, s10, Fim_KDInterrupt
	
	la t0, CAMBALHOTA_DIREITA_IO
	lw a1, 0(t0)				# a1 sprite inicial
	
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA
	
	bne a0, zero, COLISAO_IO		# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, -7664
	j NAO_COLISAO
	
###########################################################################################
CAMBALHOTA_ESQUERDA:
	la t0, AGACHADO_IO			# Coloca em t0 o endereço geral 
	beq t0, s10, Fim_KDInterrupt
	
	#Define o sprite
	la t0, CAMBALHOTA_ESQUERDA_IO
	lw a1, 0(t0)				# a1 sprite inicial
	
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_ESQUERDA
	
	bne a0, zero, COLISAO_IO	# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, -7696
	j NAO_COLISAO
	
COLISAO_IO:
	mv t1, zero

NAO_COLISAO:
	#Define o deslocamento	
	la t0, FILA_PERSONAGEM_1
	sw t1, 0(t0)				# Salva o deslocamento na pilha
	
	#Define a quantida de frames
	li t1, 3
	sw t1, 4(t0)
	
	j ANIMAR
	
###########################################################################################
