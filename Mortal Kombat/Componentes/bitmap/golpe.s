############################################################################################
#a0 = endereço da imagem
#a2 = número de frames
#            $$$$$$$$ s0 e s1 são alterados    $$$$$$$$
############################################################################################
FRAME_GOLPE:
    li s0, 0

FGLOOP:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv a1, s9            # a1 = background

    jal ra, APAGAR            # APAGA O PERSONAGEM

    #la t2, PERSONAGEM1_FINAL
    #lw t3, 0(t2)            # t3 = posição final do personagem

    #addi t3, t3, 4            # soma 4 pixels na posição final
    #sw t3, 0(t2)            # salva a nova posição final (ISSO NÃO ESTÁ SENDO UTILIZADO EM LUGAR ALGUM NO MOMENTO E SE POSSÍVEL EVITE USAR)

    jal ra, PERSONAGEM        # PINTA O PERSONAGEM

    addi s0, s0, 1            # incrementa o contador de frames
    blt  s0, a2, FGLOOP    # repete enquanto não atingir o máximo de frames

    lw ra, 0(sp)
    addi sp, sp, 4
    ret