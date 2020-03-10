# include <stdio.h>
int main(){
    //takeing in inputs
    int input = 1, sumPos = 0, sumNeg = 0, numPos = 0, numNeg = 0, ave_pos = 0, ave_neg = 0;
    while (input != 0){
        printf("Please enter an integer: ");
        scanf("%d", &input);
        if (input > 0){
            sumPos += input;
            numPos ++;
        }
        if (input < 0){
            sumNeg += input;
            numNeg ++;
        }
    }
    //Calc averages
    if (numPos != 0){
        ave_pos = sumPos/numPos;
        printf("Positive average: %d\n", ave_pos);
    }
    if (numNeg != 0){
        ave_neg = sumNeg/numNeg;
        printf("Negative average: %d\n", ave_neg);
    }
    

}