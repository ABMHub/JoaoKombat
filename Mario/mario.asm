.data
	.include "Sprites/data/mario1.s"
	.include "Sprites/data/parte1.s"
	.include "Sprites/data/subzero.s"
	
	VGA1INICIO: 	.word 0xFF000000
	VGA1FINAL: 	.word 0xFF012C00

	PERSONAGEM1_INICIO: .word 0xFF00E4C0
	PERSONAGEM1_FINAL: .word 0xFF00E4D0	#evite usar

.macro  SLEEP (%x)	#função que faz um delay de x microssegundos
	# SLEEP
    	li a0,%x	#a0=valor de delay passado como parâmetro 
    	li a7,32	#ecall que chama faz o delay de a0 milisegundos
    	ecall
.end_macro

.text
	la s9, parte1		# s9 sempre contém o background
	mv a0, s9
	jal ra, BACKGROUND	# argumento em a0 = fundo

	la a0, mario1
	jal ra, PERSONAGEM
	
	la tp,KDInterrupt    	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
	csrrw zero,5,tp     	# seta utvec (reg 5) para o endereço tp
	csrrsi zero,0,1     	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	li tp,0x100
	csrrw zero,4,tp     	# habilita a interrupção do usuário

	li t1,0xFF200000    	# Endereço de controle do KDMMIO
	li t0,0x02       	# bit 1 habilita/desabilita a interrupção
	sw t0,0(t1)           	# Habilita interrupção do teclado
	
INFINITO:	
	j INFINITO
	
	li a7, 10
	ecall

.include "background.s"
.include "personagem.s"
.include "tecladov2.s"
.include "apagar.s"
