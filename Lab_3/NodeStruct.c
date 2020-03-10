
#include <stdio.h>
#include <stdlib.h>
//#include <malloc.h>

struct Node {
    int iValue;
    float fValue ;
    struct Node *next;
};

int main() {

    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;
	
	// Insert extra code here
	printf("address head: %p, ", &head);
    printf("value head: %p", head);
    printf("\naddresses of iValue: %p, fValue: %p, next: %p\n", &(head->iValue), &(head->fValue), &(head->next));


	return 0;
}