FRAME_DANCINHA:	

	addi sp, sp, -4
	sw ra, 0(sp)

	la s0, PERSONAGEM1_INICIO	# Resgata a posi��o inicial no do personagem
	lw s1, 0(s0)			# s1 = personagem 1 INICIO
	
	la t0, SPRITE_DANCA
	sw a0, 0(t0)
	
	# Decis�o: frame 0 ou frame 1?
	
	li t2, 0x00100000
	and t2, s1, t2			# mascara o valor da frame
	# t2 = frame atual
	
	# se t2 = 0 estamos na frame 0, do contr�rio, estamos na frame 1 
	li t2, 0xFF200604
	lw t2, 0(t2)	
	
	bne t2, zero, FRAME_DANCINHA_1	# se t2!=0 ent�o estamos na frame 1, do contr�rio estamos na frame 0

FRAME_DANCINHA_0:
	li t0, 0x00100000
	or t0, t0, s1
	sw t0, 0(s0)
	jal ra, PERSONAGEM
	sw s1, 0(s0)
	
	j FIM_DANCINHA

FRAME_DANCINHA_1:
	li t0, 0xFF0FFFFF
	and t0, t0, s1 
	sw t0, 0(s0)
	jal ra, PERSONAGEM
	sw s1, 0(s0)
	
FIM_DANCINHA: 

	lw ra, 0(sp)
	addi sp, sp, 4
	ret