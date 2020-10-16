############################################################################################
#Procedimento responsável por pintar um personagem na tela
#ENTRADA: a0 = endereço da imagem
#SAIDA:   a0 = sprite subsequente
#
#            $$$$$ Nenhum registrador salvo é alterado $$$$$
############################################################################################

PERSONAGEM:
    	li t4, 0xC7C7C7C7

	la t0, PERSONAGEM1_INICIO
 	lw t0, 0(t0)            #t0 = posição inicial do personagem

	la t3, ALTURA1
ALT:  	lw t5, 4(a0)            #t6 = altura do personagem
	sw t5, 0(t3)
	
	li t2, -320
    	mul t2, t2, t5
    	add t0, t0, t2

    	lw t6, 0(a0)            #t1 = largura do personagem
    	la t3, LARGURA1
    	sw t6, 0(t3)
    	
    	add t1, t0, t6            #t1 = posição final do personagem

    	addi a0, a0, 8            #addi mágico

    	li t3, 1            #contador de linhas

LOOP_PERSONAGEM:
    	beq t0, t1, SALTAR_LINHA

    	lw t2, 0(a0)            # carrega os pixels da imagem

    	beq t2, t4, CONT
    	sw t2, 0(t0)            # escreve os pixels de a0 na memória vga

CONT:   
	addi t0, t0, 4            # incrementa as colunas da memória vga
    	addi a0, a0, 4            # incrementa a imagem em 4 pixels
    	j LOOP_PERSONAGEM

SALTAR_LINHA:
    	beq t3, t5, FIM_PERSONAGEM    # verifica se todas as linhas já foram escritas

    	addi t3, t3, 1            # incrementa o contador de linhas
    	addi t1, t1, 320        # desloca a posição final do personagem para a linha de baixo
    	addi t0, t0, 320        # desloca a posição inicial do personagem para a linha de baixo
    	sub  t0, t0, t6            # subtrai a largura do personagem da posição inicial (que no momento é igual a final)

    	j LOOP_PERSONAGEM

FIM_PERSONAGEM:

    	mv t0, a0
   	#SLEEP(2)
    	mv a0, t0

    	ret
