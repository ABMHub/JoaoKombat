CAMINHAR_FRAME:
	li s0, 0
	
LOOP_FRAME_DESLOCAMENTO:

	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal ra, APAGAR
	
	
	
	la t0, VGA1INICIO
	lw t1, 0(t0)
	
	la t2, PERSONAGEM1_INICIO
	lw t3, 0(t2)
	
	beq s6, zero, VGA1q
	
VGA2q:	li t4, 0x00100000	
	or t1, t1, t4
	or t3, t3, t4

VGA1q:	sw t1, 0(t0)
	
	add t3, t3, a3
	sw t3, 0(t2)
	
	jal ra, PERSONAGEM
	
	li t0,0xFF200604	# Escolhe o Frame 0 ou 1
	xori s6, s6, 0x01
 	sw s6,0(t0)		# seleciona a Frame t2

	addi s0, s0, 1			# incrementa o contador de frames
	blt  s0, a2, LOOP_FRAME_DESLOCAMENTO		# repete enquanto não atingir o máximo de frames
	
	mv t1, a0
	SLEEP(2)
	mv a0, t1
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
