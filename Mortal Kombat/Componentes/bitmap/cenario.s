############################################################################################
#Este procedimento n�o possui entradas e nem sa�das 
#Coloca em s9 o endere�o do cen�rio
############################################################################################
CENARIO:
	li a7, 30			# pega a hora
	ecall
	
	addi a1, a0, 1001		# soma 1001 s� de zoas
	li a7, 40			# pega semente usando o a0 e a+1001
	ecall				# temos uma seed yey
	
	li a0, 1			# eu n�o tenho muita certeza do que � isso
	li a1, 3			# 10 � o limite :) ... nvdd � 9 (botei 3 temporariamente... nvdd � 2)
	li a7, 42			# temos um n�mero inteiro pseudoaleat�rio t('-'t)
	ecall
	
	mv t0, a0			# fui um bom menino e segui a conven��o, mere�o presente no natal
	
SWITCH_CASE_CEN�RIO:
	
CENARIO0:
	li t1, 0			# t1 = 0
	bne t0, t1, CENARIO1		# se n�o for o cen�rio 0 pula para o pr�ximo
	la s9, cenario0			# carrega pra s9 o cen�rio
	j FIM_CENARIO			# termina :)
	
CENARIO1:
	li t1, 1			# t1 = 1
	bne t0, t1, CENARIO2		# se n�o for o cen�rio 1 pula para o pr�ximo
	la s9, cenario1			# carrega pra s9 o cen�rio
	j FIM_CENARIO			# termina :)

CENARIO2:
	li t1, 2			# t1 = 2
	bne t0, t1, FIM_CENARIO		# se n�o for o cen�rio 2 pula para o pr�ximo
					# substituir por CENARIO3 dps que tiver mais um cenario
	la s9, cenario2			# carrega pra s9 o cen�rio
	j FIM_CENARIO			# termina :)

#CENARIO3:
#	li t1, 3			# t1 = 3
#	bne t0, t1, CENARIO4		# se n�o for o cen�rio 3 pula para o pr�ximo
#	la s9, cenario3			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO4:
#	li t1, 4			# t1 = 4
#	bne t0, t1, CENARIO5		# se n�o for o cen�rio 4 pula para o pr�ximo
#	la s9, cenario4			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO5:
#	li t1, 5			# t1 = 5
#	bne t0, t1, CENARIO6		# se n�o for o cen�rio 5 pula para o pr�ximo
#	la s9, cenario5			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO6:
#	li t1, 6			# t1 = 6
#	bne t0, t1, CENARIO7		# se n�o for o cen�rio 6 pula para o pr�ximo
#	la s9, cenario6			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO7:
#	li t1, 7			# t1 = 7
#	bne t0, t1, CENARIO8		# se n�o for o cen�rio 7 pula para o pr�ximo
#	la s9, cenario7			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO8:
#	li t1, 8			# t1 = 8
#	bne t0, t1, CENARIO9		# se n�o for o cen�rio 8 pula para o pr�ximo
#	la s9, cenario8			# carrega pra s9 o cen�rio
#	j FIM_CENARIO			# termina :)

#CENARIO9:				# se chegou at� aqui � porque � o 9 :)
#	la s9, cenario9			# carrega pra s9 o cen�rio

FIM_CENARIO:
	la t0, CENARIO_ATUAL
	sw s9, 0(t0)
	ret				# retorna para o procedimento chamador
