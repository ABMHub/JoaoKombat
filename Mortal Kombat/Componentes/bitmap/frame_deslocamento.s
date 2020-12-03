###########################################################################################
#a2 = quantidade frames
#a3 = deslocamento
#			$$$s0, s1, s2 e s3 são alterados$$$
###########################################################################################
FRAME_GOLPE_VGA:
	mv a3, zero
	
FRAME_DESLOCAMENTO_VGA:
	addi sp, sp, -4
	sw ra, 0(sp)

	
DESLOCAMENTO:

	la s0, PERSONAGEM1_INICIO	# Resgata a posição inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	# Decisão: frame 0 ou frame 1?
	
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	#srli t2, t2, 20			# desloca o bit da frame 20 bits
	# se t2 = 0 estamos na frame 0, do contrário, estamos na frame 1 
	
	bne t2, zero, FRAME1		# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0


FRAME0:		

	la t4, ALTURA1			# lê a altura atual e salva em ALTURA1ANTIGA
	la t5, ALTURA1ANTIGA
	lw t4, 0(t4)
	sw t4, 0(t5)
	
	la t4, LARGURA1			# lê a largura atual e salva em LARGURA1ANTIGA
	la t5, LARGURA1ANTIGA
	lw t4, 0(t4)
	sw t4, 0(t5)

	li t2, 0x00100000
	or s2, s1, t2			# s2 = endereço do personagem na frame 1
	
	la t5, PERSONAGEM1_INICIO_ANTIGO
	sw s2, 0(t5)
	mv a1, s9
	#ebreak
	jal ra, LIMPAR			#limpa o personagem na frame 1
	
	la t4, PERSONAGEM1_INICIO
	lw t4, 0(t4)
	
	la t5, PERSONAGEM1_INICIO_ANTIGO
	sw t4, 0(t5)
	
	# Estamos na frame 0, devemos pintar na frame 1

	
	# Então s2 é igual a posição inicial do personagem na frame 1
	# E s1 é igual a posição inicial do personagem na frame 0
	
	# Primeiro devemos deslocar a posição inicial do personagem para frame que ele será 
	# pintado, isto é, na frame 1
	add s2, s2, a3			# s2 foi deslocado
	sw s2, 0(s0)			# PERSONAGEM1_INICIO = s2
	

	
	mv a1, s9
	#ebreak
	jal ra, PERSONAGEM		# PINTA PERSONAGEM NA FRAME 1
	
	# Agora devemos exibir a outra frame
	li t4, 0xFF200604
	li t5, 0x001
	sw t5, 0(t4)			# Muda para a frame 1
	
	mv a1, s9
	sw s1, 0(s0)			# Salva em personagem 1 inico a posição do personagem na frame 1
	
	la t4, VGA1INICIO		# atualiza o inicio da memória vga
	li t5, 0xFF000000
	sw t5, 0(t4)
	
	mv a1, s9
	#ebreak
apag:	jal ra, LIMPAR			# Apaga o personagem na frame 1
	
	sw s2, 0(s0)			# Salva em personagem 1 inicio a posição personagem na frame 1
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FRAME1:


FRAME1_LOOP:
	la t4, ALTURA1			# lê o valor de altura1 e salva em ALTURA1ANTIGA
	la t5, ALTURA1ANTIGA
	lw t4, 0(t4)
	sw t4, 0(t5)
	
	la t4, LARGURA1			# lê o valor de largura1 e salva em LARGURA1ANTIGA
	la t5, LARGURA1ANTIGA
	lw t4, 0(t4)
	sw t4, 0(t5)


	li t2, 0xFF0FFFFF
	and s2, s1, t2			# s2 = endereço do personagem na frame 0
	
	la t5, PERSONAGEM1_INICIO_ANTIGO
	sw s2, 0(t5)
	jal ra, LIMPAR			# limpa o personagem na frame 0
	
	# Estamos na frame 1, devemos pintar na frame 0
	la t4, PERSONAGEM1_INICIO
	lw t4, 0(t4)
	la t5, PERSONAGEM1_INICIO_ANTIGO
	sw t4, 0(t5)
	

	
	# Então s2 é igual a posição inicial do personagem na frame 0
	# E s1 é igual a posição inicial do personagem na frame 1
	
	# Primeiro devemos deslocar a posição inicial do personagem para frame que ele será 
	# pintado, isto é, na frame 0
	add s2, s2, a3			# s2 foi deslocado
	sw s2, 0(s0)			# PERSONAGEM1_INICIO = s2
	
		
	
	
	#ebreak			
	jal ra, PERSONAGEM		# PINTA PERSONAGEM NA FRAME 1

		# Agora devemos exibir a outra frame
	li t4, 0xFF200604
	sw zero, 0(t4)			# Muda para a frame 0
	
	mv a1, s9
	sw s1, 0(s0)			# Salva em personagem 1 inico a posição do personagem na frame 1
	
	la t4, VGA1INICIO		# atualiza o inicio da memoria vga
	li t5, 0xFF100000
	sw t5, 0(t4)
	
	mv a1, s9
	
	#ebreak
	
apag2:	jal ra, LIMPAR			# Apaga o personagem na frame 1
	
			
					
							
											
	sw s2, 0(s0)			# Salva em personagem 1 inicio a posição personagem na frame 0
	
	addi a2, a2, -1			# Decrementa a quantidade de Frames a serem pintadas
	beq a2, zero, FIM_DESLOCAMENTO	# Todos os Frames foram pintados
	j DESLOCAMENTO			# ainda faltam frames a serem pintados
	
FIM_DESLOCAMENTO:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
