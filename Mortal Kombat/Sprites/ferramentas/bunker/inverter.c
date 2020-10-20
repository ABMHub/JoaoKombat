#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

/*
    OS SPRITES DEVEM ESTAR COM UM ESPAÇO EM BRANCO ENTRE ELES
    PARA O PROGRAMA FUNCIONAR
*/

bool Sprite(FILE* f, FILE* g) {
    char altC[10], largC[10];
    char nome[200];

    fscanf(f, "%[^:]: .word %[^,], %[^\n]\n.byte ", nome, largC, altC);

    int alt, larg;
    alt = atoi(altC);
    larg = atoi(largC);
    
    fprintf(g, "%s: .word %d, %d\n.byte ", nome, larg, alt);

    for (int i = 0; i < alt; i++) {
        char byte[larg][10];

        for (int j = 0; j < larg; j++) {
            fscanf(f, "%[^,],", byte[j]);
            strcat(byte[j], ",");
        }
        fseek(f, 1, SEEK_CUR);

        for (int j = larg - 1; j >= 0; j--) {
            fprintf(g, "%s", byte[j]);
        }
    }

    fprintf(g, "\n\n");
    fscanf(f, "\n\n");

    if(feof(f)){
        printf("teste\n");
        return false;
    }

    fseek(f, -1, SEEK_CUR); 
    return true;
}

int main () {
    FILE* f = fopen("compilado.s" , "r");
    if (f == NULL) {
        printf("Arquivo nao pode ser aberto");
        return 0;
    }

    FILE* g = fopen("compiladoInv.s", "w");

    while (Sprite(f, g));

    fclose(f);
    fclose(g);

    return 0;
}