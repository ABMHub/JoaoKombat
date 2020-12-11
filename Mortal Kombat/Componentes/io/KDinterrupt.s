
KDInterrupt:

	addi    sp, sp, -124              # Salva todos os registradores na pilha
  	sw     x1,    0(sp)
   	sw     x2,    4(sp)
    	sw     x3,    8(sp)
    	sw     x4,   12(sp)
    	sw     x5,   16(sp)
    	sw     x6,   20(sp)
    	sw     x7,   24(sp)
   	sw     x8,   28(sp)
    	sw     x9,   32(sp)
    	sw     x10,  36(sp)
    	sw     x11,  40(sp)
    	sw     x12,  44(sp)
    	sw     x13,  48(sp)
    	sw     x14,  52(sp)
    	sw     x15,  56(sp)
    	sw     x16,  60(sp)
    	sw     x17,  64(sp)
    	sw     x18,  68(sp)
    	sw     x19,  72(sp)
    	sw     x20,  76(sp)
    	sw     x21,  80(sp)
    	sw     x22,  84(sp)
    	sw     x23,  88(sp)
    	sw     x24,  92(sp)
    	sw     x25,  96(sp)
    	sw     x26, 100(sp)
    	sw     x27, 104(sp)
    	sw     x28, 108(sp)
    	sw     x29, 112(sp)
    	sw     x30, 116(sp)
    	sw     x31, 120(sp)
	
	csrrci zero,0,1     			# clear o bit de habilitação de interrupção global em ustatus (reg 0)
	li t1,0xFF200000    			# Endereço de controle do KDMMIO
        lw t2,4(t1)             		# le a tecla
        sw t2,12(t1)            		# escreve no display
###########################################################################################	
SWITCH_CASE_TECLA: 

	
	li a2, 9				# código de movimento				
	li t3, 'd'
	beq t3, t2, DIREITA			# verifica se a tecla pressionada é 'd'
	
	li a2, 8				# código de movimento
	li t3, 'a'
	beq t3, t2, ESQUERDA
	
	li a2, 12				# código de movimento
	li t3, 'w'
	beq t3, t2, CIMA
	
	li a2, 13				# código de movimento
	li t3, 's'
	beq t3, t2, AGACHAR
	
	li a2, 2				# código de movimento
	li t3, 'x'
    	beq t3, t2, CHUTE	        	#verifica se a tecla pressionada é 'x'
    	
    	li a2, 0				# código de movimento
    	li t3, 'c'
    	beq t3, t2, SOCO
    	
    	li a2, 3				# código de movimento
    	li t3, 'z'
        beq t3, t2, OUTRO_CHUTE
        
        li a2, 1				# código de movimento
        li t3, 'v'
        beq t3, t2, OUTRO_SOCO
        
        li a2, 14				# código de movimento
        li t3, 'f'
        beq t3, t2, BLOCK
        
        li a2, 11				# código de movimento
        li t3, 'e'
        beq t3, t2, CAMBALHOTA_DIREITA
        
        li a2, 10				# código de movimento
        li t3, 'q'
        beq t3, t2, CAMBALHOTA_ESQUERDA
        
        li a2, 15				# código de movimento
        li t3, ' '
        beq t3, t2, PODER
        
        li t1,0xFF200000    			# Endereço de controle do KDMMIO
	li t0,0x01       			# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           			# Habilita interrupção do teclado

	j Fim_KDInterrupt			# Se não for nenhuma dessas não faz nada
###########################################################################################

DIREITA:
	la t0, AGACHADO_IO			# Coloca em t0 o endereço geral 
	beq t0, s10, Fim_KDInterrupt
	
	la t0, CAMINHAR_DIREITA_IO
	lw a1, 0(t0)				# a1 sprite inicial
	
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA
	
	bne a0, zero, COLISAO_IO		# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, 4
	j NAO_COLISAO
	
###########################################################################################
ESQUERDA:
	la t0, AGACHADO_IO			# Coloca em t0 o endereço geral 
	beq t0, s10, Fim_KDInterrupt
	
	#Define o sprite
	la t0, CAMINHAR_ESQUERDA_IO
	lw a1, 0(t0)				# a1 sprite inicial
	
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_ESQUERDA
	
	bne a0, zero, COLISAO_IO	# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, -4
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
CIMA:	
	la t0, PARADO_IO					# se estiver parado tem que pular
	beq t0, s10, PULAR
	
	la t0, AGACHADO_IO				# se estiver agachado tem que levantar
	beq t0, s10, LEVANTAR

PULAR:
	la s10, PARADO_IO					# garante que em s10 tenha ele parado
	
	#Define o sprite
	la t0, PULAR_IO
	lw a1, 0(t0)					# a1 sprite inicial
	
	#Define o deslocamento	
	li t1, -9600
	la t0, FILA_PERSONAGEM_1
	sw t1, 0(t0)					# Salva o deslocamento na pilha
	
	#Define a quantida de frames
	li t1, 4
	sw t1, 4(t0)

	j ANIMAR
		
LEVANTAR: 
	la s10, PARADO_IO					# garante que em s10 tenha ele parado

	#Define o sprite
	la t0, LEVANTAR_IO
	lw a1, 0(t0)					# a1 sprite inicial
	
	#Define o deslocamento	
	li t1, 0
	la t0, FILA_PERSONAGEM_1
	sw t1, 0(t0)					# Salva o deslocamento na fila
	
	#Define a quantidade de frames
	li t1, 1
	sw t1, 4(t0)
	
	j ANIMAR
###########################################################################################

AGACHAR: 
	la s10, AGACHADO_IO					# garante que em s10 tenha ele parado
	
	#Define o sprite
	la t0, AGACHADO_IO
	lw a1, 0(t0)					# a1 sprite inicial
	
	#Define o deslocamento	
	li t1, 0
	la t0, FILA_PERSONAGEM_1
	sw t1, 0(t0)					# Salva o deslocamento na fila
	
	#Define a quantidade de frames
	li t1, 1
	sw t1, 4(t0)
	
	j ANIMAR
###########################################################################################

CHUTE:
	la t0, PARADO_IO
   	beq t0, s10, CHUTE_NORMAL		      # se estiver em pé chuta
   	
   	la t0, AGACHADO_IO
	beq t0, s10, CHUTE_AGACHADO
	
CHUTE_NORMAL:
	#Define o sprite
	la t0, CHUTE_NORMAL_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE
	
CHUTE_AGACHADO:
	#Define o sprite
	la t0, CHUTE_AGACHADO_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE
	
##########################################################################################
SOCO:
	la t0, PARADO_IO
   	beq t0, s10, SOCO_NORMAL		      # se estiver em pé chuta
   	
   	la t0, AGACHADO_IO
	beq t0, s10, SOCO_AGACHADO
	
SOCO_NORMAL:
	#Define o sprite
	la t0, SOCO_NORMAL_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE
	
SOCO_AGACHADO:
	#Define o sprite
	la t0, SOCO_AGACHADO_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 3
	sw t1, 4(t0)
	j GOLPE	
##########################################################################################

OUTRO_CHUTE:
	la t0, PARADO_IO
   	beq t0, s10, CHUTE_ALTO		      # se estiver em pé chuta
   	
   	la t0, AGACHADO_IO
	beq t0, s10, RASTEIRA
	
CHUTE_ALTO:
	#Define o sprite
	la t0, CHUTE_ALTO_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 6
	sw t1, 4(t0)
	j GOLPE
	
RASTEIRA:
	#Define o sprite
	la t0, RASTEIRA_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE	
##########################################################################################

BLOCK:
	la t0, PARADO_IO
   	beq t0, s10, BLOCK_EM_PE		      
   	
   	la t0, AGACHADO_IO
	beq t0, s10, BLOCK_AGACHADO
	
	la t0, BLOCK_EM_PE_IO
	beq t0, s10, DESATIVAR_BLOCK_EM_PE
	
	la t0, BLOCK_AGACHADO_IO
	beq t0, s10, DESATIVAR_BLOCK_AGACHADO
	
BLOCK_EM_PE:
	#Define o estado
	la s10, BLOCK_EM_PE_IO
	
	#Define o sprite
	la t0, BLOCK_EM_PE_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 6
	sw t1, 4(t0)
	j GOLPE
	
BLOCK_AGACHADO:
	#Define o estado
	la s10, BLOCK_AGACHADO_IO
	
	#Define o sprite
	la t0, BLOCK_AGACHADO_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE	
	
DESATIVAR_BLOCK_EM_PE:
	#Define o estado
	la s10, PARADO_IO
	
	#Define o sprite
	la t0, DESATIVAR_BLOCK_EM_PE_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 2
	sw t1, 4(t0)
	j GOLPE	
	
DESATIVAR_BLOCK_AGACHADO:
	#Define o estado
	la s10, AGACHADO_IO
	
	#Define o sprite
	la t0, DESATIVAR_BLOCK_AGACHADO_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 2
	sw t1, 4(t0)
	j GOLPE	
##########################################################################################

		
				
						
##########################################################################################
CAMBALHOTA_DIREITA:
	la t0, AGACHADO_IO			# Coloca em t0 o endereço geral 
	beq t0, s10, Fim_KDInterrupt
	
	la t0, CAMBALHOTA_DIREITA_IO
	lw a1, 0(t0)				# a1 sprite inicial
	
	la t0, CONTADORH1			# carrega o contador
	lw t1, 0(t0)				
	addi t1, t1, 1				# incrementa o contador
	jal ra, VERIFICA_CONTADOR_DIREITA
	
	bne a0, zero, CAMBALHOTA_COLISAO_IO		# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, -7664
	j CAMBALHOTA_NAO_COLISAO
	
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
	
	bne a0, zero, CAMBALHOTA_COLISAO_IO	# se a0 não for 0 houve colisão
# 	NÃO HOUVE COLISÃO
	sw t1, 0(t0)				# guarda o novo valor do contador somente se não estiver no limite
	li t1, -7696
	j CAMBALHOTA_NAO_COLISAO
	
CAMBALHOTA_COLISAO_IO:
	mv t1, zero

CAMBALHOTA_NAO_COLISAO:
	#Define o deslocamento	
	la t0, FILA_PERSONAGEM_1
	sw t1, 0(t0)				# Salva o deslocamento na pilha
	
	#Define a quantida de frames
	li t1, 3
	sw t1, 4(t0)
	
	j ANIMAR
	
###########################################################################################

OUTRO_SOCO:
	la t0, PARADO_IO
   	beq t0, s10, JAB	      # se estiver em pé chuta
   	
   	la t0, AGACHADO_IO
	beq t0, s10, ALPISTE_ORH
	
JAB:
	#Define o sprite
	la t0, JAB_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 5
	sw t1, 4(t0)
	j GOLPE
	
ALPISTE_ORH:
	#Define o sprite
	la t0, ALPISTE_ORH_IO
	lw a1, 0(t0)

	#Define a quantidade de frames
	li t1, 6
	sw t1, 4(t0)
	j GOLPE	
##########################################################################################								
									
###########################################################################################
PODER:
	j Fim_KDInterrupt	
###########################################################################################
																
##########################################################################################	
GOLPE:
	#Define o deslocamento
	la t0, FILA_PERSONAGEM_1
	sw zero, 0(t0)
	
ANIMAR:	
	la t0, FILA_PERSONAGEM_1
	
	#Define a direção
	la t2, CONTADORH1
	lw t2, 0(t2)
	la t3, CONTADORH2
	lw t3, 0(t3)

	slt t1, t2, t3				# personagem 1 está olhando para direita
	bne t1, zero, FIM_DIRECAO	# se t1==0 => t1 deve virar -1
	li t1, -1
	
FIM_DIRECAO:
	sw t1, 8(t0)				# salva a direção na posição 1 da fila
	
	#Define a posição inicial
	la t1, PERSONAGEM1
	lw t1, 0(t1)
	sw t1, 12(t0)				# salva a posição inicial na posição 2 da fila
		
###########################################################################################

	la a0, FILA_PERSONAGEM_1
	li a3, 1				# player 1
	jal ra, PREENCHE_FILA
	
Fim_KDInterrupt:
	
	lw    x1,   0(sp)  
        lw    x2,   4(sp)
        lw    x3,   8(sp)
        lw    x4,  12(sp)
        lw    x5,  16(sp)
        lw    x6,  20(sp)
        lw    x7,  24(sp)
        lw    x8,  28(sp)
        lw    x9,  32(sp)
        lw     x10, 36(sp)    
        lw     x11, 40(sp)    
        lw     x12, 44(sp)
        lw     x13, 48(sp)
        lw     x14, 52(sp)
        lw     x15, 56(sp)
        lw     x16, 60(sp)
        lw     x17, 64(sp)
        lw     x18, 68(sp)
        lw     x19, 72(sp)
        lw     x20, 76(sp)
        lw     x21, 80(sp)
        lw     x22, 84(sp)
        lw     x23, 88(sp)
        lw     x24, 92(sp)
        lw     x25, 96(sp)
        lw     x26, 100(sp)
        lw     x27, 104(sp)
        lw     x28, 108(sp)
        lw     x29, 112(sp)
        lw     x30, 116(sp)
        lw     x31, 120(sp)
	addi sp, sp, 124
	ret
	
	
	
