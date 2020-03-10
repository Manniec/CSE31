#include <stdio.h>
int main(){
    int x = 0, y = 0, *px = &x, *py = &y;
    int arr[10]={ 0 }; 
    //printing x,y,and arr[0]
    printf("x: %d, y:%d, arr[0]: %d\n&x: %p, &y:%p \n",x,y,arr[0],&x,&y );
    printf("px: %p, py: %p\n&px: %p, &py: %p\n", px,py,&px, &py);

    //printing array with pointer
    
    for(int i = 0; i < 10; i++ ){
        printf("arr[%d]: %d\n", i, *(arr+i));
    }

    if (arr == &arr[0]){
        printf("true\n");
    }
    
    printf("arr: %p, &arr[0]: %p, &arr[9]: %p \n", arr, &arr[0], &arr[9]);
    printf("&arr: %p\n", &arr);
    return 0;
}