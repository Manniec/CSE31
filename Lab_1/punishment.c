# include <stdio.h>
int main(){
    //taking inputs
    int numLines;
    printf("Enter the number of lines for the punishment: ");
    scanf("%d", &numLines);
    if (numLines <= 0){//incorrect value check
        printf("You entered an incorrect value for the number of lines!\n");
        return 0;
    }

    int typo;
    printf("Enter the line for which we want to make a typo: ");
    scanf("%d", &typo);
    if (typo <=  0 || typo > numLines) {//incorrect value check: typo needs to be less than numlines printed
        printf("You entered an incorrect value of the line typo!\n");
        return 0;
    }


    //for loop for printing punishment
    for(int i = 1; i <= numLines; i++){
        if (i == typo){
            printf("C programming language is the bet! ");
        }else{
            printf("C programming langauge is the best! ");
        }
    }
    printf("\n");
    

    /*
    //Debug: print numLines and typo
    printf("numlines: %d typo: %d\n", numLines, typo);
    return 0;
    */
}