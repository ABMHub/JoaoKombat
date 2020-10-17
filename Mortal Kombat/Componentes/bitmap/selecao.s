SELECAO:
	addi sp, sp, -4
	sw ra, 0(sp)
	li s0, 0		#contador linha
	li s1, 0		#contador coluna
	li s2, 3		#limite linha
	li s3, 2		#limite coluna
	
	li s4, 36		#andar na linha
	li s5, 15360		#andar na coluna
	
	la t0, MenuDeEscolha		#background da seleção
	mv a0, t0
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	la a0, Seletor			
	jal ra, PERSONAGEM		#printa o seletor
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
KEY: 	li t1, 0xFF200000		# carrega o endereço de controle do KDMMIO
	sw zero, 0(t1)	
POOL: 	lw t0, 0(t1)			# Le bit de Controle Teclado
   	andi t0, t0, 0x0001		# mascara o bit menos significativo
   	beq t0, zero, POOL		# não tem tecla pressionada então volta ao loop
   	
   	lw t2, 4(t1)			# le o valor da tecla
   	
SWITCH_MENU:
	li t3, 'a'
	beq t3, t2, Persona_Es
	
	li t3, 'd'
	beq t3, t2, Persona_Di
	
	li t3, 'w'
	beq t3, t2, Persona_Ci
	
	li t3, 's'
	beq t3, t2, Persona_Ba
	
	li t3, ' '
	beq t3, t2, FIM_ESCOLHA
	
DEFAULT:
	j KEY
	
#######################################################################
Persona_Es:
	beq s0, zero, DEFAULT		#fora do limite
	
	addi sp, sp, -4			#salva ra na pilha
	sw ra, 0(sp)
	
	la a0, Seletor
	la a1, MenuDeEscolha
	jal ra, APAGAR
	
	la t6, PERSONAGEM1_INICIO
	lw t2, 0(t6)
	sub t2, t2, s4
	sw t2, 0(t6)
	
	la a0, Seletor
	jal ra, PERSONAGEM
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	addi s0, s0, -1
	j DEFAULT
	
	
Persona_Di:
	beq s0, s2, DEFAULT		#fora do limite
	
	addi sp, sp, -4			#salva ra na pilha
	sw ra, 0(sp)
	
	la a0, Seletor
	la a1, MenuDeEscolha
	jal ra, APAGAR
	
	la t6, PERSONAGEM1_INICIO
	lw t2, 0(t6)
	add t2, t2, s4
	sw t2, 0(t6)
	
	la a0, Seletor
	jal ra, PERSONAGEM
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	addi s0, s0, 1
	j DEFAULT
	
Persona_Ci:
	beq s1, zero, DEFAULT		#fora do limite
	
	addi sp, sp, -4			#salva ra na pilha
	sw ra, 0(sp)
	
	la a0, Seletor
	la a1, MenuDeEscolha
	jal ra, APAGAR
	
	la t6, PERSONAGEM1_INICIO
	lw t2, 0(t6)
	sub t2, t2, s5
	sw t2, 0(t6)
	
	la a0, Seletor
	jal ra, PERSONAGEM
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	addi s1, s1, -1
	j DEFAULT
	
Persona_Ba:
	beq s1, s3, DEFAULT		#fora do limite
	
	addi sp, sp, -4			#salva ra na pilha
	sw ra, 0(sp)
	
	la a0, Seletor
	la a1, MenuDeEscolha
	jal ra, APAGAR
	
	la t6, PERSONAGEM1_INICIO
	lw t2, 0(t6)
	add t2, t2, s5
	sw t2, 0(t6)
	
	la a0, Seletor
	jal ra, PERSONAGEM
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	addi s1, s1, 1
	j DEFAULT
######################################################################
			
FIM_ESCOLHA:	
	la t0, PERSONAGEM1
	lw t1, 0(t0)
	la t2, PERSONAGEM1_INICIO
	sw t1, 0(t2)
	
	li t2, 0xFF200000
	sw zero, 4(t1)
	
	ret
