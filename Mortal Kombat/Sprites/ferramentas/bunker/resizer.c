#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// retorna em altura e largura as proporcoes do sprite
void getSize(FILE *f, char* name, int *altura, int *largura) {
    char alturaC[5], larguraC[5];
    fscanf(f, "%[^:]: .word %[^,], %[^\n]\n.byte ", name, larguraC, alturaC);
    *altura = atoi(alturaC);
    *largura = atoi(larguraC);
}

void addAltura(FILE* g, int largura) {
    char n[100];
    for (int i = 0; i<largura; i++){
        fprintf(g, "199,");
    }
    fprintf(g, "\n");
}

void printLargura(FILE* f, FILE *g, int altura, int faltaLarg) {
    char str[1000];
    for (int i = 0; i < altura; i++){
        fscanf(f, "%s", str);
        fprintf(g, str);

        for (int j = 0; j < faltaLarg; j++) {
            fprintf(g, "199,");
        }

        fprintf(g, "\n");
        fseek(f, 1, SEEK_CUR);
    }
}

void resize(char* arquivo) {
    FILE *f = fopen(arquivo, "r");

    char name[100];
    int altura, largura;
    getSize(f, name, &altura, &largura);

    char label[100];
    strcpy(label, name);
    strcat(name, ".s");
    printf("%s\n", name);

    FILE *g = fopen(name, "w");

    int faltaLarg = (4 - (largura % 4)) % 4;

    fprintf(g, "%s: .word %d, %d\n.byte ", label, largura + faltaLarg, altura % 2 ? altura + 1: altura);

    if (altura % 2) {
        addAltura(g, largura + faltaLarg);
    }

    printLargura(f, g, altura, faltaLarg);

    fclose(g);
    fclose(f);
}

int main () {
    FILE *txt;
    txt = fopen("list.txt", "r");
    // char lixo[5];
    // fscanf(txt, "%[^\n]\n", lixo);
    bool flag = false;
    while (!feof(txt)) {
        char arquivo[100];
        fscanf(txt, "%[^\n]\n", arquivo);
        resize(arquivo);
    }
    fclose(txt);
    return 0;
}