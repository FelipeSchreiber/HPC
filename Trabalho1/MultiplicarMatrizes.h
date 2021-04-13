long MultiplicarMatrizVetor(double **matriz1, double *matriz2, double *matrizResultado, int NUMERO_MAXIMO_LINHAS1, int NUMERO_MAXIMO_COLUNAS1, int ij);
void deallocateArray(double ** ptr, int row);
double** criarMatrizAleatoria(int n);
long getMicrotime(void);
double* criarVetorAleatorio(int n);