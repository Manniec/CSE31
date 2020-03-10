
#include <stdio.h>
#include <stdlib.h>
//#include <malloc.h>

 int main() {
	int num;
	int *ptr;
	int **handle;

	num = 14;
	ptr = (int *)malloc(2 * sizeof(int));
	*ptr = num;
	handle = (int **)malloc(1 * sizeof(int *));
	*handle = ptr;

	// Insert extra code here
	printf("adresses of num: %p, ptr: %p, handle: %p\n", &num, &ptr, &handle);
	printf("values of num: %d, ptr: %p, handle: %p\n", num, ptr, handle);
	return 0;
} 

