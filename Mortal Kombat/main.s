.data
	.include "Sprites/data/mario.s"
	.include "Sprites/data/cenarios.s"
	.include "Sprites/data/subzero.s"
	.include "Sprites/data/raiden.s"
	.include "Sprites/data/scorpion.s"
	.include "Sprites/data/menu.s"
	.include "Sprites/data/MenuDeEscolha.s"
	
	VGA1INICIO: 		.word 0xFF000000
	VGA1FINAL: 		.word 0xFF012C00
	
	VGA2INICIO:		.word 0xFF100000
	VGA2FINAL:		.word 0xFF112C00

	PERSONAGEM1: 		.word 0xFF010410
	PERSONAGEM1_INICIO:	.word 0xFF009158
	PERSONAGEM1_FINAL: 	.word 0xFF00E4D0	#evite usar
	
	ALTURA1:		.word 0x0
	LARGURA1:		.word 0x0
	
	CONTADOR1:		.word 0x1
	CONTADOR2:		.word 0x0
	
#.macro  SLEEP (%x)				#função que faz um delay de x microssegundos
#    	li a0,%x				#a0=valor de delay passado como parâmetro 
#    	li a7,32				#ecall que chama faz o delay de a0 milisegundos
#    	ecall
#.end_macro

.text
	jal ra, MENU				#Tela de Abertura
	
	jal ra, SELECAO				#Tela de seleção
	
	jal ra, CENARIO
	mv a0, s9
	
	la t0, VGA1INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA1FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	jal ra, BACKGROUND			# argumento em a0 = fundo

	jal ra, MATRIZ_ESCOLHA			#escolhe o personagem jogável
	
	#jal ra, CENARIO			#escolhe um cenário de modo pseudoaleatório
	
INFINITO:	
	j INFINITO
	
	li a7, 10
	ecall

.include "componentes/bitmap/cenario.s"
.include "componentes/bitmap/background.s"
.include "componentes/bitmap/personagem.s"
.include "componentes/io/subzeroio.s"
.include "componentes/io/scorpionio.s"
.include "componentes/io/raidenio.s"
.include "componentes/bitmap/apagar.s"
.include "componentes/bitmap/deslocamento.s"
.include "componentes/bitmap/golpe.s"
.include "componentes/bitmap/Menu.s"
.include "componentes/bitmap/selecao.s"
.include "componentes/bitmap/matriz.s"