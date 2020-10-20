
MENU:	addi sp, sp, -4			#salva o valor de retorno
	sw ra, 0(sp)			
	
	la t0, menu1			#Endereço do dragão
	mv a0, t0
	
	la t0, VGA1INICIO		#Inicio da Frame 0
	lw a1, 0(t0)
	la t0, VGA1FINAL		#Final da Frame 1
	lw a2, 0(t0)

	jal ra, BACKGROUND		#Printa a tela
	
	la t0, menu2			#Endereço do Logo
	mv a0, t0
	
	la t0, VGA2INICIO		#Inicio da Frame 1
	lw a1, 0(t0)
	la t0, VGA2FINAL		#Final da Frame 1
	lw a2, 0(t0)
	
	jal ra, BACKGROUND		#Printa a tela
	
	lw ra, 0(sp)			#recupera o ra
	addi sp, sp, 4
	
FORA:	li s0, 0xFF200604		# Escolhe o Frame 0 ou 1
	li t2,0				# inicio Frame 0
	li t1, 0xFF200000
LOOP3: 	
	lw t0, 0(t1)			# Le bit de Controle Teclado
   	andi t0, t0, 0x0001		# mascara o bit menos significativo
   	
	sw t2, 0(s0)			# seleciona a Frame t2
	xori t2, t2, 0x001		# escolhe a outra frame
	
	li a0, 600
	li a7, 32
	ecall				# sleep de 600 
	
   	beq t0, zero, LOOP3		#Loop conrinua se nenhuma tecla for pressionada
	
	sw zero, 4(t1)			#zera o valor no teclado
	li t2, 0			#Força a Frame 0
	sw t2, 0(s0)
	ret				#retorno
