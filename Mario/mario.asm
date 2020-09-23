.data

	.include "mario1.s"
	.include "parte1.s"
	
	VGA1INICIO: 	.word 0xFF000000
	VGA1FINAL: 	.word 0xFF012C00
	
	MARIOINICIO:	.word 0xFF00DFC0
	MARIOFINAL:	.word 0xFF00DFD0

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

.text
	
	la a1, parte1
	BACKGROUND(a1)
	
	li t0, 35
	la t2, mario1
	lw t3, MARIOINICIO
	lw t4, MARIOFINAL
	li t6, 0
	addi t2, t2, 8
	
	PERSONAGEM(t0, t3, t4, t6)
	
	li a7, 10
	ecall