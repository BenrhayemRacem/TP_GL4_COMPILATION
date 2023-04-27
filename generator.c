#include "generator.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int indextab;
ENTREE_CODE tabCodeInt[2000];


ENTREE_CODE creerEnt (const char* code, int op, const char* nomfonc) {
    ENTREE_CODE ent;
    ent.code_op = (char *)malloc(strlen(code)+2);
    strcpy(ent.code_op, code);
    ent.operande=op;
    ent.nomFct = (char *)malloc(strlen(nomfonc)+2);
    strcpy(ent.nomFct, nomfonc);
    return ent;
}

ENTREE_CODE creerOp (const char* code,int op) {
    return creerEnt (code,op,"");
}

ENTREE_CODE creerCode (const char* code) {
    // printf("aaaaa\n");
    return creerOp (code,-1);
}

void genererCode() {
    // printf("here %d" , sizeof(tabCodeInt)/sizeof(tabCodeInt[0]));
    printf("here2 %d %d %d", tabCodeInt[0].operande,tabCodeInt[0].code_op, tabCodeInt[0].nomFct);
    /* FILE *fgc;
    //fgc=fopen("generatedCode.txt","w");
    if(fgc==NULL){
        printf("Error");
        exit(1);
    }
    */
    for (int f=0; f<indextab; f++) {
        printf("%s ",tabCodeInt[f].operande);
        if(tabCodeInt[f].operande!=-1)
            printf("%d ",tabCodeInt[f].operande);
        printf("\n");
    }
    //fclose(fgc);
}