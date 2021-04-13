#include <stdio.h>
#include <stdlib.h>
#include "MultiplicarMatrizes.h"

int main(int argc, char **argv)
{
    int n = atoi(argv[1]);
    int mode = atoi(argv[2]);
    double* vec = criarVetorAleatorio(n);
    double** mat = criarMatrizAleatoria(n);
    double*result;
    FILE *fptr;
    fptr = fopen("resultados_C.csv","a");
    for(int i=0;i<10;i++)
    {
        long tempo_exec = MultiplicarMatrizVetor(mat, vec, result, n, n, mode);
        fprintf(fptr,"%d, %d, %ld\n",mode,n,tempo_exec);
    }
    //printf("Time taken: %ld\n",tempo_exec);
    fclose(fptr);
    deallocateArray(mat,n);
    free(vec);
}