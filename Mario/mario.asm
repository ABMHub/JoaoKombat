.data

	.include "Sprites/data/mario1.s"
	.include "Sprites/data/mario3.s"
	.include "Sprites/data/parte1.s"
	
	VGA1INICIO: 	.word 0xFF000000
	VGA1FINAL: 	.word 0xFF012C00
	
	MARIOINICIO:	.word 0xFF00E4C0
	MARIOFINAL:	.word 0xFF00E4D0

.macro	BACKGROUND(%imagem)

	lw t3, VGA1INICIO
	lw t4, VGA1FINAL

	addi %imagem, %imagem, 8
	
LOOP_BG:	
	beq t3, t4, FORA_BG

	lw t5, 0(%imagem)
	sw t5, 0(t3)
	
	addi %imagem, %imagem, 4
	addi t3, t3, 4
	
	j LOOP_BG
	
FORA_BG:
.end_macro

.macro PERSONAGEM(%altura, %marioinicio, %mariofinal, %contador, %imagem)
	
LOOP_MARIO:
	beq %marioinicio, %mariofinal, IF_MARIO
	
	lw t5, 0(%imagem)
	sw t5, 0(%marioinicio)
	
	addi %imagem, %imagem, 4
	addi %marioinicio, %marioinicio, 4
	
	
	j LOOP_MARIO
	
IF_MARIO:
	beq %altura, %contador, FORA_MARIO
	addi %marioinicio, %marioinicio, 304
	addi %mariofinal, %mariofinal, 320
	addi %contador, %contador, 1
	j LOOP_MARIO

FORA_MARIO:

.end_macro

.macro VERIFICA_TECLA()
KBHIT:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO	# TENTANDO SIMULAR UM KBHIT
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_KBHIT  		# Se não há tecla pressionada então vai para FIM
    	lw t2,4(t1)  			# le o valor da tecla tecla
	sw t2,12(t1)  			# escreve a tecla pressionada no display(so pra testar se ta funfando)

	SWITCH_CASE_TECLA: 		#DETERMINA PRA ONDE O CARA TA MEXENDO
	#t2 tem o valor da tecla pressionada
		
	li t3, 'd'
	
	beq t3, t2, DIREITA			#move pra direita
	
	DIREITA:

	la t4, MARIOINICIO		#Coloca em t4 endereço da posição inicial do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 16			#Soma 4 no valor de MARIOINICIO
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOINICIO
	
	la t4, MARIOFINAL		#Coloca em t4 endereço da posição final do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 16			#Soma 4 no valor de MARIOFINAL
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOFINAL
	
	
	li a0, 31			#contador
	la t1, MARIOINICIO		#Coloca dentro de t1 o endereço onde está a posição inicial do mario
	lw a1, 0(t1)			#Carrega pra a1 a posição inicial de onde está o mario
	la t1, MARIOFINAL		#Coloca dentro de t1 o endereço onde está a posição final do Mario
	lw a2, 0(t1)			#Carrega pra a2 a posição final de onde está o mario
	li a3, 0 			#a3 é o contador
	la a4, mario3			#a4 tem os bits de mario
	addi a4, a4, 8			#addi mágico
	
	
	PERSONAGEM(a0, a1, a2, a3, a4)	#pinta o personagem
	
	j END_SWITCH_CASE_TECLA	
	
	
END_SWITCH_CASE_TECLA:
FIM_KBHIT:
.end_macro

.text
	
	la a1, parte1
	BACKGROUND(a1)
	
	li t0, 31
	la t2, mario1
	lw t3, MARIOINICIO
	lw t4, MARIOFINAL
	li t6, 0
	addi t2, t2, 8
	

	PERSONAGEM(t0, t3, t4, t6, t2)
INFINITO:	
	VERIFICA_TECLA()
	j INFINITO
	
	li a7, 10
	ecall
