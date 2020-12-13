Poder_Scorpion:
	addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	ebreak
	la s0, PERSONAGEM1_INICIO
	lw s1, 0(s0)
	
	li t1, -19200
	add t0, t0, t1
	addi a6, t0, 32
	
	li t0, 0xFF200604
	lw t0, 0(t0)				# Descobre em que frame estamos
	
	la a0, ScorpionProjetil_1
	li a1, 1
	
	beq t0, zero, P_SCORPION_1		# se t2!=0 então estamos na frame 1, do contrário estamos na frame 0
	
P_SCORPION_0:
	#1
	li t0, 0x00100000
	or a6, t0, a6

	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	
	#2
	li t0, 0xFF0FFFFF
	and a6, t0, a6
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1
	jal ra, LIMPAR
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x000
	sw t1, 0(t0)			# Muda para a frame 0
	
	
	
	#3
	li t0, 0x00100000
	or a6, t0, a6
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0
	jal ra, LIMPAR

	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	
	
	#4
	li t0, 0xFF0FFFFF
	and a6, t0, a6
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1
	jal ra, LIMPAR
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x000
	sw t1, 0(t0)			# Muda para a frame 0
	
	mv t0, a7
	mv t1, a0
	
	li a7, 32
	li a0 90
	ecall
	
	mv a7, t0
	mv a0, t1
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0
	jal ra, LIMPAR
	
	j P_FIM
	
P_SCORPION_1:
	#1
	li t0, 0xFF0FFFFF
	and a6, t0, a6
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x000
	sw t1, 0(t0)			# Muda para a frame 0
	
	
	
	
	#2
	li t0, 0x00100000
	or a6, t0, a6
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0
	jal ra, LIMPAR
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	
	
	#3
	li t0, 0xFF0FFFFF
	and a6, t0, a6
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1
	jal ra, LIMPAR
	
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x000
	sw t1, 0(t0)			# Muda para a frame 0
	
	
	#4
	li t0, 0x00100000
	or a6, t0, a6
	
		
	la a4, P_LARGURA_FRAME_0
	la a5, P_LARGURA_FRAME_0
	jal ra, LIMPAR
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1	
	jal ra, PERSONAGEM_V2
	
	li t0, 0xFF200604
	li t1, 0x001
	sw t1, 0(t0)			# Muda para a frame 1
	
	mv t0, a7
	mv t1, a0
	
	li a7, 32
	li a0 90
	ecall
	
	mv a7, t0
	mv a0, t1
	
	la a4, P_LARGURA_FRAME_1
	la a5, P_LARGURA_FRAME_1
	jal ra, LIMPAR
	
P_FIM:
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	
	ret