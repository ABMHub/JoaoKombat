.data
	.include "Sprites/data/mario.s"
	.include "Sprites/data/background1.s"
	.include "Sprites/data/subzero.s"
	
	VGA1INICIO: 		.word 0xFF000000
	VGA1FINAL: 		.word 0xFF012C00

	PERSONAGEM1_INICIO: 	.word 0xFF010E10
	PERSONAGEM1_FINAL: 	.word 0xFF00E4D0	#evite usar
	
	ALTURA1:		.word 0x0
	LARGURA1:		.word 0x0
	
	CONTADOR1:		.word 0x0

.macro  SLEEP (%x)		#fun��o que faz um delay de x microssegundos
	# SLEEP
    	li a0,%x		#a0=valor de delay passado como par�metro 
    	li a7,32		#ecall que chama faz o delay de a0 milisegundos
    	ecall
.end_macro

.text
	la s9, background1	# s9 sempre cont�m o background
	mv a0, s9
	
	la t0, VGA1INICIO
	lw a1, 0(t0)			# ta1 = inicio da mem�ria vga
	la t0, VGA1FINAL
	lw a2, 0(t0)			# ta2 = final da mem�ria vga
	
	jal ra, BACKGROUND	# argumento em a0 = fundo

	la s10, SubZeroParado1
	la a0, SubZeroParado1
	jal ra, PERSONAGEM
	
	la tp,KDInterrupt    	# carrega em tp o endere�o base das rotinas de Tratamento da Interrup��o
	csrrw zero,5,tp     	# seta utvec (reg 5) para o endere�o tp
	csrrsi zero,0,1     	# seta o bit de habilita��o de interrup��o global em ustatus (reg 0)
	li tp,0x100
	csrrw zero,4,tp     	# habilita a interrup��o do usu�rio

	li t1,0xFF200000    	# Endere�o de controle do KDMMIO
	li t0,0x02       	# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)           	# Habilita interrup��o do teclado
	
INFINITO:	
	j INFINITO
	
	li a7, 10
	ecall

.include "componentes/bitmap/background.s"
.include "componentes/bitmap/personagem.s"
.include "componentes/io/subzeroio.s"
.include "componentes/bitmap/apagar.s"
.include "componentes/bitmap/deslocamento.s"
.include "componentes/bitmap/golpe.s"
