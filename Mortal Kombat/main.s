.data
	.include "componentes/io/Labels.s"
	.include "Sprites/data/mario.s"
	.include "Sprites/data/cenarios.s"
	.include "Sprites/data/subzero.s"
	.include "Sprites/data/raiden.s"
	.include "Sprites/data/scorpion.s"
	.include "Sprites/data/menu.s"
	.include "Sprites/data/MenuDeEscolha.s"
	
	
	
#.macro  SLEEP (%x)				#função que faz um delay de x microssegundos
#    	li a0,%x				#a0=valor de delay passado como parâmetro 
#    	li a7,32				#ecall que chama faz o delay de a0 milisegundos
#    	ecall
#.end_macro

.text
	
	jal ra, MENU				#Tela de Abertura
	
	jal ra, SELECAO				#Tela de seleção
	
	jal ra, CENARIO
	
	li a0, 1
	li a1, 5
	li a2, 2
	jal ra, ESCREVE_POSICAO_MATRIZ
	
	li a0, 2
	li a1, 4
	li a2, 2
	jal ra, ESCREVE_POSICAO_MATRIZ
	
	la t0, VGA1INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA1FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	mv a0, s9
	jal ra, BACKGROUND			# argumento em a0 = fundo
	
	mv a0, s9
	la t0, VGA2INICIO
	lw a1, 0(t0)				# ta1 = inicio da memória vga
	la t0, VGA2FINAL
	lw a2, 0(t0)				# ta2 = final da memória vga
	
	jal ra, BACKGROUND			# argumento em a0 = fundo

	jal ra, MATRIZ_ESCOLHA			#escolhe o personagem jogável
	
	#jal ra, CENARIO			#escolhe um cenário de modo pseudoaleatório
###########################################################################################
	li a1, 1 			# da esquerda para direita
	la a6, PERSONAGEM1
	lw a6, PERSONAGEM1
	
	la a4, LARGURA_FRAME_1			# a4 = endereço da largura
	la a5, ALTURA_FRAME_1			# a5 = endereço da altura
	la t0, DANCINHA1_IO
	lw a0, 0(t0)
	jal ra, PERSONAGEM_V2#############################
	
	la a0, DANCINHA2_IO
	lw a0, 0(a0)
	la a7, PERSONAGEM1
	jal ra, FRAME_DANCINHA
###########################################################################################
	#li a1, -1 			# da esquerda para direita
	#la a6, PERSONAGEM2
	#lw a6, PERSONAGEM2
	
	#la a4, LARGURA_FRAME_0			# a4 = endereço da largura
	#la a5, ALTURA_FRAME_0			# a5 = endereço da altura
	#la t0, DANCINHA1_IO
	#lw a0, 0(t0)
	#jal ra, PERSONAGEM_V2#############################
	
	#la a0, SubZeroDancando_2
	#la a7, PERSONAGEM2
	#jal ra, FRAME_DANCINHA
###########################################################################################			
	li s8,0xFF200604	# Escolhe o Frame 0 ou 1
	li s7,0			# inicio Frame 0

INFINITO:
	csrr s6,3073 		# le o time atual
	sw s7,0(s8)		# seleciona a Frame t2
	xori s7,s7,0x001	# escolhe a outra frame
LOOOP:
	jal ra, KDInterrupt
	jal ra, FRAME_DESLOCAMENTO_VGA

 	csrr t0,3073 		# le o time atual
	sub t1,t0,s6 		# calcula o tempo
	li t0, 300
	bge t1, t0, INFINITO

	j LOOOP	
	
	#j INFINITO
	
	li a7, 10
	ecall

.include "componentes/bitmap/cenario.s"
.include "componentes/bitmap/dancinha.s"
.include "componentes/bitmap/background.s"
.include "componentes/bitmap/personagem_v2.s"
.include "componentes/bitmap/personagem.s"
#.include "componentes/io/subzeroio.s"
.include "componentes/io/matriz_combate.s"
.include "componentes/io/KDinterrupt.s"
.include "componentes/io/preenche_fila.s"
.include "componentes/bitmap/apagar.s"
.include "componentes/bitmap/deslocamento.s"
.include "componentes/bitmap/frame_deslocamento3.s"
.include "componentes/bitmap/limpar3.s"
.include "componentes/bitmap/golpe.s"
.include "componentes/bitmap/Menu.s"
.include "componentes/bitmap/selecao.s"
.include "componentes/bitmap/matriz.s"


