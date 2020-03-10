#include <stdio.h>
#include <stdlib.h>

void swapArray(int* a1, int* a2, int size){
	int temp = 0;
	for(int i = 0; i < size; i++){
		temp = *(a1 + i);
		*(a1 + i) = *(a2 + i);
		*(a2 + i) = temp;
	}
}

int main (int argc, char **argv) {
    int *arr1, *arr2;
    int n = 4;
    arr1 = (int*) malloc (n * sizeof(int));
    arr2 = (int*) malloc (n * sizeof(int));
    for (int i = 0; i < n; i++){
        *(arr1 + i) = i;
        *(arr2 + i) = i*10;
    }
    printf("arr1: ");
    for (int i = 0; i < n; i++){
        printf("%d ", *(arr1 + i));
    }
    printf("\narr2: ");
    for (int i = 0; i < n; i++){
        printf("%d ", *(arr2 + i));
    }

    swapArray(arr1, arr2, n);
    printf("\nflipped:\n");
    printf("arr1: ");
    for (int i = 0; i < n; i++){
        printf("%d ", *(arr1 + i));
    }
    printf("\narr2: ");
    for (int i = 0; i < n; i++){
        printf("%d ", *(arr2 + i));
    }
      printf("\n");
}

