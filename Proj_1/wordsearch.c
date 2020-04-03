#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// DO NOT INCLUDE OTHER LIBRARY!

// Declarations of the two functions you will implement
// Feel free to declare any helper functions
void printPuzzle(char** arr, int n);
void searchPuzzle(char** arr, int n, char** list, int listSize);
void toLower(char* letter);
int leftRight(char** arr, int row, int col, int n, char* word);
int diagRight(char** arr, int row, int col, int n, char* word);
//int rightLeft(char** arr, int row, int col, int n, char* word);
int upDown(char** arr, int row, int col, int n, char* word);
char toUpper(char letter);

// Main function, DO NOT MODIFY!!!	
int main(int argc, char **argv) {
    int bSize = 15;
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
		return 2;
	}
    int i, j;
    FILE *fptr;
    char **block = (char**)malloc(bSize * sizeof(char*));
	char **words = (char**)malloc(50 * sizeof(char*));

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

	// Read puzzle block into 2D arrays
    for(i=0; i<bSize; i++){
        *(block+i) = (char*)malloc(bSize * sizeof(char));

        fscanf(fptr, "%c %c %c %c %c %c %c %c %c %c %c %c %c %c %c\n", *(block+i), *(block+i)+1, *(block+i)+2, *(block+i)+3, *(block+i)+4, *(block+i)+5, *(block+i)+6, *(block+i)+7, *(block+i)+8, *(block+i)+9, *(block+i)+10, *(block+i)+11, *(block+i)+12, *(block+i)+13, *(block+i)+14 );
    }
	fclose(fptr);

	// Open file for reading word list
	fptr = fopen("states.txt", "r");
	if (fptr == NULL) {
        printf("Cannot Open Words File!\n");
        return 0;
    }
	
	// Save words into arrays
	for(i=0; i<50; i++){
		*(words+i) = (char*)malloc(20 * sizeof(char));
		fgets(*(words+i), 20, fptr);		
	}
	
	// Remove newline characters from each word (except for the last word)
	for(i=0; i<49; i++){
		*(*(words+i) + strlen(*(words+i))-2) = '\0';	
	}
	
	// Print out word list
	printf("Printing list of words:\n");
	for(i=0; i<50; i++){
		printf("%s\n", *(words + i));		
	}
	printf("\n");
	
	// Print out original puzzle grid
    printf("Printing puzzle before search:\n");
    printPuzzle(block, bSize);
	printf("\n");

	// Call searchPuzzle to find all words in the puzzle
	searchPuzzle(block, bSize, words, 50);
	printf("\n");
	
	// Print out final puzzle grid with found words in lower case
    printf("Printing puzzle after search:\n");
    printPuzzle(block, bSize);
	printf("\n");
	
    return 0;
}

void printPuzzle(char** arr, int n){
	// This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
	// Your implementation here
	for(int row = 0; row < n; row ++){
		for(int col = 0; col < n; col ++){
			printf("%c ", *(*(arr + row) + col));
		}
		printf("\n");
	}

}

void searchPuzzle(char** arr, int n, char** list, int listSize){
	// This function checks if arr contains words from list. If a word appears in arr, it will print out that word and then convert that word entry in arr into lower case.
	// Your implementation here
	int TorF;
	char tempUpper;
	for(int row = 0; row < n; row++){ //iterates through letters of puzzle left-right top-down starting in upper left corner
		//printf("Row %d: \n", row+1);
		for(int col = 0; col < n; col++){
			//printf("Column %d: \n", col+1);
			for(int word = 0; word < listSize; word++){ //For each word in list 
				if(**(list+word) == *(*(arr+row)+ col)){ //check if first letter in word in arr
					
					TorF = upDown(arr, row, col, n,  *(list+word));
					TorF = leftRight(arr, row, col, n,  *(list+word));
					TorF = diagRight(arr, row, col, n,  *(list+word));
					//TorF = rightLeft(arr, row, col, n,  *(list+word));
				}
			}
		}
	}
	
	
}

void toLower(char* letter){
	if( (*letter >= 65) && (*letter <=90) ){
		*letter += 'a'-'A';
	}
}

char toUpper(char letter){
	char p = letter;
	if( (letter >= 97) && (letter <=122) ){
		p += ('A'-'a');
	}
	return p;
}


int upDown(char** arr, int row, int col, int n, char* word){
	int y = row;
	char* letter = word;
	char tempUpper;
	while ( (*letter != '\0') && (y < n)){ //y must be within arr or else theres a segmentation fault : 11
		tempUpper = toUpper(*letter);
		if(toUpper(*(*(arr+y)+ col) != tempUpper)){
			return 0;
		}
		y++;
		letter++;
	}
	if(*letter == '\0'){ //ensure didnt exit for loop bc reached end of array
		printf("Word Found: ");
		for(int i = row; i < y; i++){
			toLower( *(arr+i)+ col );
			printf("%c", *(*(arr+i)+ col) );
		}
		printf("\n");
	}
	return 1;
}

int leftRight(char** arr, int row, int col, int n, char* word){
	int x = col;
	char* letter = word;
	char tempUpper;
	while ( (*letter != '\0') && (x < n)){ //y must be within arr or else theres a segmentation fault : 11
		tempUpper = toUpper(*letter);
		if(toUpper(*(*(arr+row)+ x) != tempUpper)){
			return 0;
		}
		x++;
		letter++;
	}
	if(*letter == '\0'){ //ensure didnt exit for loop bc reached end of array
		printf("Word Found: ");
		for(int j = col; j < x; j++){
			toLower( *(arr+row)+ j );
			printf("%c", *(*(arr+row)+ j) );
		}
		printf("\n");
	}
	return 1;
}

int diagRight(char** arr, int row, int col, int n, char* word){
	int x = col;
	int y = row;
	char* letter = word;
	char tempUpper;
	while ( (*letter != '\0') && ((x < n) && (y < n))){ //y must be within arr or else theres a segmentation fault : 11
		tempUpper = toUpper(*letter);
		if(toUpper(*(*(arr+y)+ x) != tempUpper)){
			return 0;
		}
		x++;
		y++;
		letter++;
	}
	if(*letter == '\0'){ //ensure didnt exit for loop bc reached end of array
		printf("Word Found: ");
		int j = col;
		for(int i = row; i < y; i++){
			toLower( *(arr+i)+ j );
			printf("%c", *(*(arr+i)+ j) );
			j++;
		}
		
		printf("\n");
	}
	return 1;
}



/*
int leftRight(char** arr, int row, int col, int n, char* word){
	int x = col;
	char* letter = word;
	while ( (*letter != '\0') && (x < n)){
		if(*(*(arr+row)+ x) != *letter){
			printf("%c %c ", *(*(arr+row)+ x), *letter);
			return 0;
		}else{
			printf("%c %c ", *(*(arr+row)+ x), *letter);
		}
		x++;
		letter++;
	}
	
	
	for(char* letter = word; *letter != '\0'; letter++){ //for each letter in the word
		
	}
	for(int i = row;row < n; row ++){
		toLower( *(arr+i)+ col );
		printf("%c", *(*(arr+i)+ col) );
	}
	printf("\n");
	
	return 1;

}


for(char* letter = *list; *letter != '\0'; letter++){
	tempUpper = toUpper(*letter);
	printf("%c ", tempUpper);
}
*/