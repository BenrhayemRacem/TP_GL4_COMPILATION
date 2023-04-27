#ifndef GENERATOR_H_INCLUDED
#define GENERATOR_H_INCLUDED
#include "stdio.h"
#include <stdlib.h>
#include <string.h>
//static char * code_op [] = { "LDC", "LDV", "STORE", "APPEL", "ENTREE", "SORTIE", "RETOUR", "ADD", "MUL", "DIV",
  //                          "SUB", "INF", "INFE", "SUP", "SUPE", "DIF", "EGAL"};

typedef struct ENTREE_CODE
{
    char* code_op;
    int operande;
    char* nomFct;
}ENTREE_CODE;



ENTREE_CODE creerEnt (const char* code, int op, const char* nomfonc);
ENTREE_CODE creerOp (const char* code,int op);
ENTREE_CODE creerCode (const char* code);

#endif // GENERATOR_H_INCLUDED