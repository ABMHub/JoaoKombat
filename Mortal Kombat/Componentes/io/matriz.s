#escreve matriz
.text

CALCULA_CONTADOR1:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	lw t0, CONTADORV1	# carrega posição vertical
	lw t1, CONTADORH1	# carrega posição horizontal
	
	li t2, 20		# 20 == largura
	mul t0, t0, t2		# medição vertical * 20 para percorrer verticalmente a matriz
	add t0, t0, t1		# t0 é agora o canto inferior esquerdo da hitbox
	
CONTADOR_PARADO1:
	li t1, 1
	la t2, MATRIZ_COMBATE
	
	add t0, t2, t0
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
CALCULA_CONTADOR2:	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	lw t0, CONTADORV2
	lw t1, CONTADORH2
	
	li t2, 20		# 20 == largura
	mul t0, t0, t2		# medição vertical * 20 para percorrer verticalmente a matriz
	add t0, t0, t1		# t0 é agora o canto inferior esquerdo da hitbox
	
CONTADOR_PARADO2:
	li t1, 2
	la t2, MATRIZ_COMBATE
	
	add t0, t2, t0
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	addi t0, t0, -20
	sb t1, 0(t0)
	sb t1, 1(t0)
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
	