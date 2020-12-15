############################################################################################
#Este procedimento não possui entradas e nem saídas 
#Coloca em s9 o endereço do cenário
############################################################################################
CENARIO:
	li a7, 30			# pega a hora
	ecall
	
	addi a1, a0, 1001		# soma 1001 só de zoas
	li a7, 40			# pega semente usando o a0 e a+1001
	ecall				# temos uma seed yey
	
	li a0, 1			# eu não tenho muita certeza do que é isso
	li a1, 3			# 10 é o limite :) ... nvdd é 9 (botei 3 temporariamente... nvdd é 2)
	li a7, 42			# temos um número inteiro pseudoaleatório t('-'t)
	ecall
	
	mv t0, a0			# fui um bom menino e segui a convenção, mereço presente no natal
	
SWITCH_CASE_CENÁRIO:
	
CENARIO0:
	li t1, 0			# t1 = 0
	bne t0, t1, CENARIO1		# se não for o cenário 0 pula para o próximo
	la s9, cenario0			# carrega pra s9 o cenário
	j FIM_CENARIO			# termina :)
	
CENARIO1:
	li t1, 1			# t1 = 1
	bne t0, t1, CENARIO2		# se não for o cenário 1 pula para o próximo
	la s9, cenario1			# carrega pra s9 o cenário
	j FIM_CENARIO			# termina :)

CENARIO2:
	li t1, 2			# t1 = 2
	bne t0, t1, FIM_CENARIO		# se não for o cenário 2 pula para o próximo
					# substituir por CENARIO3 dps que tiver mais um cenario
	la s9, cenario2			# carrega pra s9 o cenário
	j FIM_CENARIO			# termina :)

#CENARIO3:
#	li t1, 3			# t1 = 3
#	bne t0, t1, CENARIO4		# se não for o cenário 3 pula para o próximo
#	la s9, cenario3			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO4:
#	li t1, 4			# t1 = 4
#	bne t0, t1, CENARIO5		# se não for o cenário 4 pula para o próximo
#	la s9, cenario4			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO5:
#	li t1, 5			# t1 = 5
#	bne t0, t1, CENARIO6		# se não for o cenário 5 pula para o próximo
#	la s9, cenario5			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO6:
#	li t1, 6			# t1 = 6
#	bne t0, t1, CENARIO7		# se não for o cenário 6 pula para o próximo
#	la s9, cenario6			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO7:
#	li t1, 7			# t1 = 7
#	bne t0, t1, CENARIO8		# se não for o cenário 7 pula para o próximo
#	la s9, cenario7			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO8:
#	li t1, 8			# t1 = 8
#	bne t0, t1, CENARIO9		# se não for o cenário 8 pula para o próximo
#	la s9, cenario8			# carrega pra s9 o cenário
#	j FIM_CENARIO			# termina :)

#CENARIO9:				# se chegou até aqui é porque é o 9 :)
#	la s9, cenario9			# carrega pra s9 o cenário

FIM_CENARIO:
	la t0, CENARIO_ATUAL
	sw s9, 0(t0)
	ret				# retorna para o procedimento chamador
