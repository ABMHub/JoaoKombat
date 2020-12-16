BUSCA_ELEMENTO:
		li t5, 0			#Contador
Loop_Busca:	
		slli t1, t5, 2			#Offset
		add t1, s0, t1			#Endereço do vetor
		lw t1, 0(t1)			#Pega o elemento nesse endereço
		beq t1, a0, EXISTE_ELEMEM	#Se for igual, vai para Existe Elemento
		addi t5, t5, 1			#Contador++
		blt t5, a1, Loop_Busca		#Loop enquanto não achar o elemento igual e contador < N
		
		li a2, 1			#Elemento diferente
		ret
EXISTE_ELEMEM:	
		li a2, 0			#Elemento igual
		ret
		

#####################################################################################################################################
MONTA_VETOR:	addi sp, sp, -12
		sw ra, 0(sp)
		sw s0, 4(sp)
		sw s1, 8(sp)
		
		li t0, 0		#CONTADOR
		li s1, 12		#Tamanho do vetor
		la s0, VETOR_INIMIGOS	

#Inicializa o vetor com -1	
LOOP_Vinimigos:
		slli t1, t0, 2		#Calcula o offset do endereço
		add t3, s0, t1		#Endereço do vetor
		li t2, -1		#Inicia com -1
		
		sw t2, 0(t3)		#Carrega -1 no vetor inteiro
		addi t0, t0, 1		#Contador++
		
		blt t0, s1, LOOP_Vinimigos
		
		li t0, 0		#Reinicia o contador	
		
ESCOLHENDO_INIMIGO:
		li a7, 41		#Numero aleatório
		ecall
		
		li t1, 12
		remu a0, a0, t1			#mod 12
		mv a1, t0			#a0 = valor que quero buscar, a1 = até que indice já foi preenchido		
		jal ra, BUSCA_ELEMENTO		#Ve se o elemento já está no vetor
		
		beq a2, zero, ESCOLHENDO_INIMIGO	#Se estiver, busca outro elemento
		
		slli t1, t0, 2		#Offset
		add t1, s0, t1		#Endereço
		sw a0, 0(t1)		#Salva o elemento
		addi t0, t0, 1		#Contador++
		
		blt t0, s1, ESCOLHENDO_INIMIGO
		
		lw ra, 0(sp)
		lw s0, 4(sp)
		lw s1, 8(sp)
		addi sp, sp, 12
		
		ret
