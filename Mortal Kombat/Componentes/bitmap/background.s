############################################################################################
#Procedimento responsável por pintar o fundo 
#Entrada: a0 = cenário
#			$$$$$ Nenhum registrador salvo é alterado $$$$$
############################################################################################ 

BACKGROUND:
	la t3, VGA1INICIO
	lw t3, 0(t3)			# t3 = inicio da memória vga
	la t4, VGA1FINAL
	lw t4, 0(t4)			# t4 = final da memória vga

	addi a0, a0, 8			# addi mágico no background

LOOP_BG:	
	beq t3, t4, FORA_BG		# se já tiver pintado tudo sai fora

	lw t5, 0(a0)			# carrega pra t5 o conteúdo da imagem
	sw t5, 0(t3)			# escreve na memória vga
	
	addi a0, a0, 4			# desloca 4 pixels na imagem
	addi t3, t3, 4			# desloca 4 pixels na memória vga
	
	j LOOP_BG
	
FORA_BG:
	ret
