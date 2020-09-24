.data

	.include "Sprites/data/mario1.s"
	.include "parte1.s"
	
	VGA1INICIO: 	.word 0xFF000000
	VGA1FINAL: 	.word 0xFF012C00
	
	MARIOINICIO:    .word 0xFF00E4C0
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

.macro PERSONAGEM(%limite, %marioinicio, %mariofinal, %contador)
	
LOOP_MARIO:
	beq %marioinicio, %mariofinal, IF_MARIO
	
	lw t5, 0(t2)
	sw t5, 0(%marioinicio)
	
	addi t2, t2, 4
	addi %marioinicio, %marioinicio, 4
	
	
	j LOOP_MARIO
	
IF_MARIO:
	beq %limite, %contador, FORA_MARIO
	addi %marioinicio, %marioinicio, 304
	addi %mariofinal, %mariofinal, 320
	addi %contador, %contador, 1
	j LOOP_MARIO

FORA_MARIO:

.end_macro

.macro APAGAR(%background)
 
 	# t0 = contador horizontal
 	# t1 = pos na vga
 	# t3 = contador vertical
 	# %background = pos no parte1.s
	lw t0, MARIOINICIO # carrega a posição do mario em t0
	lw t4, MARIOFINAL # carrega o final do matio em t4 ###################
	lw t1, VGA1INICIO # carrega vga inicio em t1 
	sub t0, t0, t1 # calcula a diferença entre mario inicio e vga inicio ###################
	sub t4, t4, t1 # calcula a diferença entre mario final e vga inicio
	addi %background, %background, 8 # soma mágica
	add %background, %background, t0 # soma a diferença com o bg para chegar na posição do mario
	add t1, t1, t0 # soma a diferença com a vga para chegar na posição do mario
	li t3, 0 # inicia contador vertical com 0 
	
PRE_LOOP_APAGAR:
	li t0, 0 # inicia contador horizontal com 0 
	
LOOP_APAGAR:
	lw t6, 0(%background) # carrega cor em t6
	sw t6, 0(t1) # aplica cor na vga
	addi t0, t0, 1 # incrementa contador horizontal
	
	addi t1, t1, 4 # incrementa posição da vga
	addi %background, %background, 4 # incrementa posição da imagem
	
	li t4, 4
	beq t0, t4, APAGAR_NOVA_LINHA # se contador horizontal == 16, 
	j LOOP_APAGAR
	
APAGAR_NOVA_LINHA:
	addi t3, t3, 1 
	li t0, 32
	
	beq t3, t0, FORA_APAGAR
	
	addi %background, %background, 304
	addi t1, t1, 304
	
	j PRE_LOOP_APAGAR

FORA_APAGAR:
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
	
	PERSONAGEM(t0, t3, t4, t6)
	
	la a1, parte1
	
	APAGAR(a1)
	
	li a7, 10
	ecall
