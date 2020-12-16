.data
	.include "Sprites/data/wins.s"
	.include "Sprites/data/fotinhas.s"
	.include "Sprites/data/montanha.s"
	.include "Sprites/data/BarraDeVida.s"
	.include "Sprites/data/menu.s"
	.include "Sprites/data/mensagens.s"
	.include "Sprites/data/MenuDeEscolha.s"
	.include "componentes/io/labels.s"
	.include "Sprites/data/cenarios.s"
	
	#Personagens
	#.include "Sprites/data/jax.s"
	.include "Sprites/data/liukang.s"
    	.include "Sprites/data/kunglao.s"
    	.include "Sprites/data/reptile.s"
    	.include "Sprites/data/johnnycage.s"
    	.include "Sprites/data/shangtsung.s"
	.include "Sprites/data/kitana.s"
	.include "Sprites/data/subzero.s"
	.include "Sprites/data/scorpion.s"
	
	
	
	
	
#.macro  SLEEP (%x)				#função que faz um delay de x microssegundos
#    	li a0,%x				#a0=valor de delay passado como parâmetro 
#    	li a7,32				#ecall que chama faz o delay de a0 milisegundos
#    	ecall
#.end_macro

.text
	
	jal ra, MENU				#Tela de Abertura
	
	jal ra, SELECAO				#Tela de seleção
	
	jal ra, CENARIO
	
	jal ra, MATRIZ_ESCOLHA			#escolhe o personagem jogável
	
	jal ra, ESCOLHENDO_BOT
	
	jal ra, MONTA_VETOR			# escolhe os inimigos aleatoriamente
			
	jal ra, MOSTRA_TUDO			# mostra a torre inteira
	
	#jal ra, TORRE_MK			# mostra o personagem subindo a torre 
	
	li a0, 1
	li a1, 5
	li a2, 2
	jal ra, ESCREVE_POSICAO_MATRIZ
	
	li a0, 2
	li a1, 4
	li a2, 2
	jal ra, ESCREVE_POSICAO_MATRIZ
	
	#jal ra, CENARIO			#escolhe um cenário de modo pseudoaleatório

RESTART:
	jal ra, NOVO_ROUND

FIM_RESTART:
	
########
	li t0,0xFF200604    # Escolhe o Frame 0 ou 1
	mv a7, zero
	csrr s8, 3073

LOOP_IA:
    	jal ra, IA_BOT
    	csrr s8, 3073

INFINITO:
	beq zero, s9, RESTART


LOOOP:

 	csrr t0,3073 		# le o time atual
	sub t1,t0,s6 		# calcula o tempo
	li t0, 300
	bge t1, t0, INFINITO

	j LOOOP	
	
	#j INFINITO
	
	li a7, 10
	ecall


.include "componentes/bitmap/Menu.s"
.include "componentes/bitmap/selecao.s"
.include "componentes/bitmap/cenario.s"
.include "componentes/bitmap/matriz.s"
.include "componentes/bitmap/bot_matriz.s"

.include "componentes/bitmap/Oponentes.s"
.include "componentes/bitmap/background.s"
.include "componentes/bitmap/Torre_MK.s"
.include "componentes/bitmap/personagem_v2.s"
.include "componentes/bitmap/personagem.s"
.include "componentes/bitmap/dancinha.s"
.include "componentes/bitmap/dancinha_round.s"
.include "componentes/bitmap/dancinhaIA.s"
.include "componentes/io/vida.s"
.include "componentes/io/identifica.s"
.include "componentes/poderes/pdepoder.s"
.include "componentes/io/identificaIA.s"
.include "componentes/io/matriz_combate.s"
.include "componentes/io/KDInterrupt.s"
.include "componentes/io/IA_MK.s"
.include "componentes/bitmap/apagar.s"
.include "componentes/bitmap/deslocamento.s"
.include "componentes/bitmap/frame_deslocamento3.s"
.include "componentes/bitmap/frame_deslocamento3IA.s"
.include "componentes/bitmap/frame_deslocamento_msg.s"
.include "componentes/bitmap/limpar3.s"
.include "componentes/bitmap/golpe.s"
.include "componentes/io/msg.s"



