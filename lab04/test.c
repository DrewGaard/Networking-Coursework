#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
int main(void)
{
 	const int ROWS = 4;
 	const int COLS = 8;
	char** myArray;
	myArray = createArray(ROWS, COLS);
	fillArray(myArray, ROWS, COLS);
	printArray(myArray, ROWS, COLS);
	deleteArray(myArray, ROWS, COLS);
	
	
	
	printf("Hallo, welt!\n"); /* German for "hello, world" */
	return 0;
}

//From the array example

char** createArray(int rows, int cols) {
  char **myArray;
  
  // Allocate a 1xROWS array to hold pointers to more arrays
  myArray = calloc(rows, sizeof(int *));
  if (myArray == NULL) {
    printf("FATAL ERROR: out of memory: %s\n", strerror(errno));
    exit(EXIT_FAILURE);
  }
  
  // Allocate each row in that column
  for (int i = 0; i < rows; i++) {
    myArray[i] = calloc(cols, sizeof(int));
    if (myArray[i] == NULL) {
      printf("FATAL ERROR: out of memory: %s\n", strerror(errno));
      exit(EXIT_FAILURE);
    }
  }
  
  return myArray;
}

void fillArray(int** myArray, int rows, int cols) {
  char count = ' ';
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      myArray[i][j] = count;
      //count++;
    }
  }
  
  return;
}

void printArray(int** myArray, int rows, int cols) {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      printf("%i ", myArray[i][j]);
    }
    printf("\n");
  }
}

void deleteArray(int** myArray, int rows, int cols) {
  for (int i = 0; i < rows; i++) {
    free(myArray[i]);
  }
  free(myArray);
  
  return;
}
