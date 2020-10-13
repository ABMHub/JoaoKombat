KDInterrupt:    
	csrrci zero,0,1     	# clear o bit de habilitação de interrupção global em ustatus (reg 0)

        lw t2,4(t1)             # le a tecla
        sw t2,12(t1)            # escreve no display
        

SWITCH_CASE_TECLA: 		#DETERMINA PRA ONDE O CARA TA MEXENDO
	#t2 tem o valor da tecla pressionada
	addi sp, sp, -4		#aloca uma word na pilha
	sw ra, 0(sp)		#salva ra na pilha
	
	mv t0, a0
	SLEEP(50)
	mv a0, t0
		
	la a1, parte1
	APAGAR(a1)
		
	li t3, 'd'
	
	beq t3, t2, DIREITA			#move pra direita
	
	DIREITA:
	
	#FRAME1
	la t4, PERSONAGEM1_INICIO		#Coloca em t4 endereço da posição inicial do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de PERSONAGEM1_INICIO
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL PERSONAGEM1_INICIO
	
	la t4, MARIOFINAL		#Coloca em t4 endereço da posição final do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de MARIOFINAL
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOFINAL
	
	
	li a0, 31			#contador
	la t1, PERSONAGEM1_INICIO		#Coloca dentro de t1 o endereço onde está a posição inicial do mario
	lw a1, 0(t1)			#Carrega pra a1 a posição inicial de onde está o mario
	la t1, MARIOFINAL		#Coloca dentro de t1 o endereço onde está a posição final do Mario
	lw a2, 0(t1)			#Carrega pra a2 a posição final de onde está o mario
	li a3, 0 			#a3 é o contador
	la a4, mario2			#a4 tem os bits de mario
	addi a4, a4, 8			#addi mágico
	
	
	#PERSONAGEM(a0, a1, a2, a3, a4)	#pinta o personagem
	jal ra, PERSONAGEM
	
	##FRAME 2
	mv t0, a0
	SLEEP(50)
	mv a0, t0
	
	la a1, parte1
	APAGAR(a1)
	
	la t4, PERSONAGEM1_INICIO		#Coloca em t4 endereço da posição inicial do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de PERSONAGEM1_INICIO
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL PERSONAGEM1_INICIO
	
	la t4, MARIOFINAL		#Coloca em t4 endereço da posição final do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de MARIOFINAL
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOFINAL
	
	
	li a0, 31			#contador
	la t1, PERSONAGEM1_INICIO		#Coloca dentro de t1 o endereço onde está a posição inicial do mario
	lw a1, 0(t1)			#Carrega pra a1 a posição inicial de onde está o mario
	la t1, MARIOFINAL		#Coloca dentro de t1 o endereço onde está a posição final do Mario
	lw a2, 0(t1)			#Carrega pra a2 a posição final de onde está o mario
	li a3, 0 			#a3 é o contador
	la a4, mario3			#a4 tem os bits de mario
	addi a4, a4, 8			#addi mágico
	
	
	#PERSONAGEM(a0, a1, a2, a3, a4)	#pinta o personagem
	jal ra, PERSONAGEM
	#FRAME 3
	mv t0, a0
	SLEEP(50)
	mv a0, t0
	
	la a1, parte1
	APAGAR(a1)
	
	la t4, PERSONAGEM1_INICIO		#Coloca em t4 endereço da posição inicial do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de PERSONAGEM1_INICIO
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL PERSONAGEM1_INICIO
	
	la t4, MARIOFINAL		#Coloca em t4 endereço da posição final do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de MARIOFINAL
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOFINAL
	
	
	li a0, 31			#contador
	la t1, PERSONAGEM1_INICIO		#Coloca dentro de t1 o endereço onde está a posição inicial do mario
	lw a1, 0(t1)			#Carrega pra a1 a posição inicial de onde está o mario
	la t1, MARIOFINAL		#Coloca dentro de t1 o endereço onde está a posição final do Mario
	lw a2, 0(t1)			#Carrega pra a2 a posição final de onde está o mario
	li a3, 0 			#a3 é o contador
	la a4, mario4			#a4 tem os bits de mario
	addi a4, a4, 8			#addi mágico
	
	
	#PERSONAGEM(a0, a1, a2, a3, a4)	#pinta o personagem
	jal ra, PERSONAGEM
	#FRAME 4
	mv t0, a0
	SLEEP(50)
	mv a0, t0
	
	la a1, parte1
	APAGAR(a1)
	
	la t4, PERSONAGEM1_INICIO		#Coloca em t4 endereço da posição inicial do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de PERSONAGEM1_INICIO
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL PERSONAGEM1_INICIO
	
	la t4, MARIOFINAL		#Coloca em t4 endereço da posição final do mario
	lw t5, 0(t4)			#Carrega pra t5 o valor contido no endereço que está em t4
	addi t5, t5, 4			#Soma 4 no valor de MARIOFINAL
	sw t5, 0(t4)			#Coloca o novo valor de t4 na LABEL MARIOFINAL
	
	
	li a0, 31			#contador
	la t1, PERSONAGEM1_INICIO		#Coloca dentro de t1 o endereço onde está a posição inicial do mario
	lw a1, 0(t1)			#Carrega pra a1 a posição inicial de onde está o mario
	la t1, MARIOFINAL		#Coloca dentro de t1 o endereço onde está a posição final do Mario
	lw a2, 0(t1)			#Carrega pra a2 a posição final de onde está o mario
	li a3, 0 			#a3 é o contador
	la a4, mario1			#a4 tem os bits de mario
	addi a4, a4, 8			#addi mágico
	
	
	#PERSONAGEM(a0, a1, a2, a3, a4)	#pinta o personagem
	jal ra, PERSONAGEM	
				
	j END_SWITCH_CASE_TECLA	
	
	
END_SWITCH_CASE_TECLA:
	lw ra, 0(sp)		#recupera ra 
	addi sp, sp, 4		#limpa a pilha
	csrrsi zero,0,0x10     	# seta o bit de habilitação de interrupção em ustatus 
        uret            	# retorna PC=uepc
        