.data
TAMANHO: 185
NOTAS: .word 60,222,60,222,64,222,60,222,65,222,60,222,67,222,65,222,64,222,64,222,67,222,64,222,71,222,64,222,67,222,64,222,59,222,59,222,62,222,59,222,64,222,59,222,65,222,64,222,57,222,57,222,60,222,57,222,64,222,57,222,64,222,62,222,60,222,60,222,64,222,60,222,65,222,60,222,67,222,65,222,64,222,64,222,67,222,64,222,71,222,64,222,67,222,64,222,59,222,59,222,62,222,59,222,64,222,59,222,65,222,64,222,57,222,57,222,60,222,57,222,64,222,57,222,64,222,62,222,60,333,60,333,60,333,60,333,59,222,64,222,60,333,60,333,60,333,60,333,59,222,55,222,60,333,60,333,60,333,60,333,59,222,64,222,60,333,60,333,60,333,60,333,60,444,60,333,60,333,60,333,60,333,59,222,64,222,60,333,60,333,60,333,60,333,59,222,55,222,60,333,60,333,60,333,60,333,59,222,64,222,60,333,60,333,60,333,60,333,60,444,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222,60,111,67,222,60,111,64,222,59,111,59,222,59,111,60,222,60,444,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222,60,111,67,222,60,111,64,222,60,111,63,222,60,111,64,222,60,111,63,111,59,222

.text
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
	
	
	li a2, 1			#define instrumento. aperte f1, vá em syscalls
					#e na parte inferior tem a lista de instrumentos
					
	li a3, 50			#define o volume das notas
	li t4, 0			#define contador = 0
	la t3, NOTAS			#armazena a posição de memória inicial das notas no registrador s0
	
FORA:	li s0, 0xFF200604		# Escolhe o Frame 0 ou 1
	li t2,0				# inicio Frame 0
	li t1, 0xFF200000
LOOP3: 	
	lw a0, 0(t3)			#carrega a nota na posição de memória t3 + 0 para o registrador a0
	lw a1, 4(t3)			#carrega a duração da nota na posição de memória t3 + 4 para o registrador a1
	li a7, 31			#indica que o ecall vai tocar a nota
	ecall				#toca nota
	mv a0,a1			#muda o registrador da duração da nota para fazer o sleep
					#o sleep requer como parametro o registrador a0, então nós passamos
					#a duração da nota (que estava em a1) para a0 para que o sleep seja igual a duração
					
	lw t0, 0(t1)			# Le bit de Controle Teclado
   	andi t0, t0, 0x0001		# mascara o bit menos significativo
   	
	sw t2, 0(s0)			# seleciona a Frame t2
	xori t2, t2, 0x001		# escolhe a outra frame
					
	li a7,32			#indica que o ecall vai fazer um sleep
	ecall				#sleep
	addi t3, t3, 8 			#incrementa a posição da memória em 8 bytes (2 words)
	addi t4, t4, 1 			#incrementa contador de notas tocadas
	lw t5, TAMANHO
	
	blt t4, t5, CONTINUA 		#se t4 < t5, recomeça o loop
	li t4, 0			#define contador = 0
	la t3, NOTAS			#armazena a posição de memória inicial das notas no registrador s0

CONTINUA:
   	beq t0, zero, LOOP3		#Loop conrinua se nenhuma tecla for pressionada
	
	sw zero, 4(t1)			#zera o valor no teclado
	li t2, 0			#Força a Frame 0
	sw t2, 0(s0)
	ret				#retorno
