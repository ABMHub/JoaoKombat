INICIALIZA_VIDA:
	li t0, 100
	
	la t1, HP_IO
	sw t0, 0(t1)
	
	la t1, HP_IA
	sw t0, 0(t1)
	
	#la a0, BARRADEVIDA
	li a1, 1

APLICA_DANO:

	li t0, 1
	beq t0, s8, DANO_P2
DANO_P1:
	la t0, HP_IO
	j POS_DANO
DANO_P2:
	la t0, HP_IA
POS_DANO:
	lw t1, 0(t0)
	sub t1, t1, s0
	sw t1, 0(t0)
	
	mv a0, t1
	li a7, 1
	ecall
	
	ret