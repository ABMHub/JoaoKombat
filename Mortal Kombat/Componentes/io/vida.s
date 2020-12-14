INICIALIZA_VIDA:
	addi sp, sp, -24
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a4, 12(sp)
	sw a5, 16(sp)
	sw a6, 20(sp)

	li t0, 30
	
	la t1, HP_IA
	sw t0, 0(t1)
	
	la t1, HP_IO
	sw t0, 0(t1)

	la a0, BarraDeVida
	li a1, -1
	mv a4, a0
	addi a5, a0, 4
	li a6, 0xFF001E80
	jal ra, PERSONAGEM_V2
	
	la a0, BarraDeVida
	li a6, 0xFF101E80
	jal ra, PERSONAGEM_V2
	
	li a1, 1
	la a0, BarraDeVida
	li a6, 0xFF001ec0
	jal ra, PERSONAGEM_V2
	
	la a0, BarraDeVida
	li a6, 0xFF101ec0
	jal ra, PERSONAGEM_V2
	
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a4, 12(sp)
	lw a5, 16(sp)
	lw a6, 20(sp)
	addi sp, sp, 24
	
	ret

APLICA_DANO:
	addi sp, sp, -8			# empilha o s1
	sw s1, 0(sp)
	sw ra, 4(sp)
	
	li t0, 1			#
	beq t0, s8, DANO_P2		# teste para ver quem *deu* dano
DANO_P1:				
	la t0, HP_IO			# se for p1, carrega hp de p2
	li t3, 0xFF001E80		# posicao da barra
	li s1, -1			# alguns valores serão invertidos em relacao ao p2
	j POS_DANO
DANO_P2:
	la t0, HP_IA			# se for p2, carrega hp de p1
	li t3, 0xFF001ec0
	addi t3, t3, -1			# posicao da barra
	li s1, 1			# alguns valores serão invertidos em relacao ao p1			# alguns valores podem inv
POS_DANO:
	lw t1, 0(t0)			# carrega hp do jogador
	sub t2, t1, s0			# t2 eh a nova vida (com desconto de dano)
	bgez t2, PULA_ZERA_DANO		# se a vida resultante for negativa:
					#
	add s0, s0, t2			# - reduz o dano tomado
	li t2, 0			# - vida resultante eh 0
	
PULA_ZERA_DANO:
	sw t2, 0(t0)			# salva novo hp na label
	
	mv a0, t2			#
	li a7, 1			#
	ecall				# printa no console a nova vida
	
	mv t0, t3			# t0 tera o endereco da barra na vga
	addi t0, t0, -960		# 960 para cima
	li t5, 3			#
	mul t5, t5, s1			#
	add t0, t0, t5			# 3 para direita ou esquerda
	
	li t3, 100			# vida max
	sub t3, t3, t1			# vida perdida

	mul t3, t3, s1			#
	add t0, t0, t3			# comeca a printar o novo vermelho depois do antigo vermelho
	
	li t1, 0			# contador interno
	li t2, 0			# contador externo
	li t4, 8			# limite do contador interno
	beqz s0, FIM_VERMELHO   	# se o contador externo nao acabou, volta pro loop interno
	
LOOP_VERMELHO:	
	li t3, 0x0F			# vermelho
	sb t3, 0(t0)			# printa pixel vermelho
	li t6, 0x00100000		# 
	add t6, t0, t6			# troca pra outra vga
	sb t3, 0(t6)			# printa na outra vga
	addi t1, t1, 1			# incrementa contador
	addi t0, t0, -320		# sobe um pixel na barra
	bne t4, t1, LOOP_VERMELHO	# se o contador interno nao acabou, continua
	
	# contador interno encerrou
	li t5, 320			# 
	mul t5, t5, t1			# decide quantos pixeis vamos descer de volta
	li t1, 0			# reseta contador interno
	add t0, t0, t5			# desce t5 numero de pixeis
	add t0, t0, s1			# desloca um pixel direita ou esquerda
	addi t2, t2, 1			# incrementa contador externo
	bne t2, s0, LOOP_VERMELHO	# se o contador externo nao acabou, volta pro loop interno

FIM_VERMELHO:	
	#ebreak
	li t0, 1
	beq t0, s8, MORREU_P2
	
MORREU_P1:
	la t0, HP_IO
	j POS_MORREU
MORREU_P2:
	la t0, HP_IA
POS_MORREU:
	lw t1, 0(t0)			# carrega hp do jogador
	beq t1, zero, MORREU
	j FIM_VERMELHO_DE_VERDADE

MORREU:
	#ebreak
	li t2, 1
	beq t2, s8, TONTO_P2
	
TONTO_P1:
	la s10, TONTO_1_IO
	lw a0, 0(s10)
	li a2, 1
	jal ra, IDENTIFICA_POSICAO
	jal ra, FRAME_GOLPE_VGA
	
	la t0, TONTO_2_IO
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA
	
	j FIM_VERMELHO_DE_VERDADE
	
TONTO_P2:
	la s11, TONTO_1_IA
	lw a0, 0(s11)
	li a2, 1
	jal ra, IDENTIFICA_POSICAO_IA
	jal ra, FRAME_GOLPE_VGA_IA
	
	la t0, TONTO_2_IA
	lw a0, 0(t0)
	jal ra, FRAME_DANCINHA_IA
	
FIM_VERMELHO_DE_VERDADE:
	lw s1, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	
	ret


