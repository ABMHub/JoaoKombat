############################################################################################
#Procedimento respons�vel por pintar o fundo 
#Entrada: a0 = cen�rio
#Entrada: a1 = inicio da vga
#Entrada: a2 = final da vga
#			$$$$$ Nenhum registrador salvo � alterado $$$$$
############################################################################################ 

BACKGROUND:
	mv t3, a1
	mv t4, a2

	addi a0, a0, 8			# addi m�gico no background

LOOP_BG:	
	beq t3, t4, FORA_BG		# se j� tiver pintado tudo sai fora

	lw t5, 0(a0)			# carrega pra t5 o conte�do da imagem
	sw t5, 0(t3)			# escreve na mem�ria vga
	
	addi a0, a0, 4			# desloca 4 pixels na imagem
	addi t3, t3, 4			# desloca 4 pixels na mem�ria vga
	
	j LOOP_BG
	
FORA_BG:
	ret
