
#include <stdio.h>
#include <stdlib.h>
//#include <malloc.h>

int** matMult(int **a, int **b, int size){
	// (4) Implement your matrix multiplication here. You will need to create a new matrix to store the product.
	int temp = 0;
	int **arr = (int**)malloc(size * sizeof(int*));
	for (int i = 0; i < size; i++){
		*(arr + i) = (int*)malloc(size * sizeof(int));
		for(int j = 0; j < size; j++){
			//*(*(arr + i) + j) = 0; //initalize everything in resulting array to zero
			temp = 0;
			for(int k = 0; k < size; k++){
				temp += (*(*(a + i) + k)) * (*(*(b + k) + j)); 
			}
			*(*(arr + i) + j) = temp;
		}
	}
	return arr;

}

void printArray(int **arr, int n){
	// (2) Implement your printArray function here
	for (int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			printf("%d\t", *(*(arr + i) + j));
		}
		printf("\n");
	}
}

int main() {
	int n = 3;
	int **matA, **matB, **matC;

	//random number 
	

	// (1) Define 2 n x n arrays (matrices). 
	matA = (int**)malloc(n * sizeof(int*));
	matB = (int**)malloc(n * sizeof(int*));
	for (int i = 0; i < n; i++){
		*(matA + i) = (int*)malloc(n * sizeof(int));
		*(matB + i) = (int*)malloc(n * sizeof(int));
		for(int j = 0; j < n; j++){
			*(*(matA + i) + j) = j+(i*n)+1;
			*(*(matB + i) + j) = j+(i*n)+2;
		}
		//*(*(matA + i) + i) = 1;
	}

	// (3) Call printArray to print out the 2 arrays here.
	printf("matA\n");
	printArray(matA, n);
	printf("matB\n");
	printArray(matB, n);
	
	//(5) Call matMult to multiply the 2 arrays here.
	matC = matMult(matA, matB, n);
	
	//(6) Call printArray to print out resulting array here.
	printf("matC\n");
	printArray(matC, n);


    return 0;
}