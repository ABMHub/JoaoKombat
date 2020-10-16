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

void addAltura(FILE* g, FILE* h, int largura) {
    for (int i = 0; i<largura; i++){
        fprintf(g, "199,");
        fprintf(h, "199,");
    }
    fprintf(g, "\n");
    fprintf(h, "\n");
}

void printLargura(FILE* f, FILE *g, FILE *h, int altura, int faltaLarg) {
    char str[2000];
    for (int i = 0; i < altura; i++){
        fscanf(f, "%s", str);
        fprintf(g, str);
        fprintf(h, str);

        for (int j = 0; j < faltaLarg; j++) {
            fprintf(g, "199,");
            fprintf(h, "199,");
        }

        fprintf(g, "\n");
        fprintf(h, "\n");
        fseek(f, 1, SEEK_CUR);
    }
}

void resize(char* arquivo, FILE* h) {
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
    fprintf(h, "%s: .word %d, %d\n.byte ", label, largura + faltaLarg, altura % 2 ? altura + 1: altura);

    if (altura % 2) {
        addAltura(g, h, largura + faltaLarg);
    }

    printLargura(f, g, h, altura, faltaLarg);

    fclose(g);
    fclose(f);
}

int main () {
    FILE *txt = fopen("list.txt", "r");
    FILE *h = fopen("compilado.s", "w");
    if (txt == NULL)
        return 0;
    while (!feof(txt)) {
        char arquivo[100];
        fscanf(txt, "%[^\n]\n", arquivo);
        resize(arquivo, h);
        fprintf(h, "\n");
    }
    fclose(txt);
    fclose(h);
    return 0;
}