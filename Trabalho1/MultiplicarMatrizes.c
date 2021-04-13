#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include "MultiplicarMatrizes.h"

long getMicrotime(){
	struct timeval currentTime;
	gettimeofday(&currentTime, NULL);
	return currentTime.tv_sec * (int)1e6 + currentTime.tv_usec;
}

//Multiplica o vetor coluna por uma matriz NUMERO_MAXIMO_LINHAS1 x NUMERO_MAXIMO_COLUNAS1. 
//A variavel ij indica a ordem com que os elementos são percorridos 
long
MultiplicarMatrizVetor(double **matriz1, double *matriz2, double *matrizResultado, int NUMERO_MAXIMO_LINHAS1, int NUMERO_MAXIMO_COLUNAS1, int ij)
{
 matrizResultado = malloc(NUMERO_MAXIMO_LINHAS1*sizeof(double));
 memset(matrizResultado,0,NUMERO_MAXIMO_LINHAS1*sizeof(double));
 long end,start;
 unsigned linha1,coluna1;
 start = getMicrotime();
 if(ij)
 {
    for(linha1 = 0;linha1 < NUMERO_MAXIMO_LINHAS1;linha1++)
    {
        for(coluna1 = 0;coluna1 < NUMERO_MAXIMO_COLUNAS1;coluna1++)
        {
            matrizResultado[linha1] += matriz1[linha1][coluna1]*matriz2[coluna1];
        }
    }
 }
 else
 {
    for(coluna1 = 0;coluna1 < NUMERO_MAXIMO_COLUNAS1;coluna1++)
    {
        for(linha1 = 0;linha1 < NUMERO_MAXIMO_LINHAS1;linha1++)
        {
            matrizResultado[linha1] += matriz1[linha1][coluna1]*matriz2[coluna1];
        }
    }
 }
 end = getMicrotime();
 return (end - start);
}

void deallocateArray(double ** ptr, int row)
{
	for(int i = 0; i < row; i++)
	{
		free(ptr[i]);
	}
	free(ptr);
}

double** criarMatrizAleatoria(int n)
{
  time_t t;
  srand((unsigned) time(&t));
  double**randomMatrix = (double**) malloc(n*sizeof(double*));
  for(int i = 0; i < n; i++)
  {
   randomMatrix[i] = (double*) malloc(n*sizeof(double));
   for(int j = 0; j < n; j++)
   {
    randomMatrix[i][j] = rand();
   }
  }
  return randomMatrix;
}

double* criarVetorAleatorio(int n)
{
    time_t t;
    srand((unsigned int)time(&t));
    double* randomVec = (double*) malloc(n*sizeof(double));
    for(int i = 0; i < n; i++)
        randomVec[i] = rand();
    return randomVec;
}