#include<stdio.h>
#include<string.h>

void printArr(int *a, int size){
	//Your code here
    printf("printArr:");
    for(int i = 0; i < size; i ++){
        printf(" %d", *(a+i));
    }
    printf("\n");
}

int* arrCopy(int *a, int size){
	//Your code here
    int *copy;
    copy = (int *) malloc(size * sizeof(int));
    for (int i = 0; i < size; i++){
        *(copy + i) = *(a + i);
    }
    return copy;
}

int main(){
    int n;
    int *arr;
    int *arr_copy;
    int i;
    printf("Enter size of array:\n");
    scanf("%d",&n);

    //Dynamically create an int array of n items
    //Your code here
    arr = (int *) malloc(n * sizeof(int));
    
    //Ask user to input content of array
	//Your code here
    for (i = 0; i < n; i++){
        printf("Enter array content #%d: ", i + 1);
        scanf("%d",(arr + i));
    }
	
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	//Print original array
    printArr(arr, n);


	//Copy array
    arr_copy = arrCopy(arr, n);

	//Print new array
    printArr(arr_copy, n);

    /*******************************************/
    free(arr);
    free(arr_copy);
     /*******************************************/
    return 0;
}