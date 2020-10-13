############################################################################################
#a0 = endere�o da imagem
#			$$$$$$$$ s0 e s1 s�o alterados	$$$$$$$$
############################################################################################
FRAME:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv a1, s9			# a1 = background
	
	jal ra, APAGAR			# APAGA O PERSONAGEM
	
	la t0, PERSONAGEM1_INICIO	
	lw t1, 0(t0)			# t1 = posi��o inicial do personagem
	
	addi t1, t1, 4			# soma 4 pixels na posi��o inicial
	sw t1, 0(t0)			# salva a nova posi��o inicial
	
	#la t2, PERSONAGEM1_FINAL	
	#lw t3, 0(t2)			# t3 = posi��o final do personagem

	#addi t3, t3, 4			# soma 4 pixels na posi��o final
	#sw t3, 0(t2)			# salva a nova posi��o final (ISSO N�O EST� SENDO UTILIZADO EM LUGAR ALGUM NO MOMENTO E SE POSS�VEL EVITE USAR)
	
	jal ra, PERSONAGEM		# PINTA O PERSONAGEM
	
	addi s0, s0, 1			# incrementa o contador de frames
	blt  s0, a2, FRAME		# repete enquanto n�o atingir o m�ximo de frames
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	