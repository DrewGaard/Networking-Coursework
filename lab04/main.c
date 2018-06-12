#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <string.h>
#include "boat.h"

int** createArray(int rows, int cols);
void fillArray(int** myArray, int rows, int cols);
void printArray(int** myArray, int rows, int cols);
void deleteArray(int** myArray, int rows, int cols);

int main()
{
   int ROWS = 0;
   int COLS = 0;
   int gridSize = 0;
   int** myArray;
   int** myArray2;

   //The coordinate the player wants to move to
   char coordinate = ' ';

//   struct Ships ship1;

   //Number of shells a player gets based on the grid size
   int shells = 0;

   //Get the size of the grid from the user
   printf("How large should I make the grid? ");
   scanf("%d", &gridSize);
   //If the grid size entered by the user is less than 5 create a grid of size 5
   if(gridSize < 5)
   {
        printf("The minimum grid size is 5... I'll create one that size.\n");
        gridSize = 5;
        shells = (gridSize * gridSize) / 2;
   }
   if(gridSize > 20)
   {
        printf("The maximum grid size is 20... I'll create one that size.\n");
        gridSize = 20;
        shells = (gridSize * gridSize) / 2;
   }

   ROWS = gridSize;
   COLS = gridSize;
   shells = (gridSize * gridSize) / 2;

    //To test if the number of shells is correct
   //printf("%d", shells);

   myArray = createArray(ROWS, COLS);

   myArray2 = createArray(ROWS, COLS);
   //fillArrayShips(myArray2, ROWS, COLS);

   fillArray(myArray, ROWS, COLS);
   //printArray(myArray2, ROWS, COLS);
   placeBoats(myArray, ROWS, COLS);
   fillArray(myArray2, ROWS, COLS);
   //printArray(myArray2, ROWS, COLS);

   char c;

   while((c = getchar()) != '\n' && c != EOF);
   /* discard */

   while(shells > 0)
   {
        int row1;
        char move;
        int moveNum;

        printArray(myArray2, ROWS, COLS);
        //array1[0] = ' ';
        //array1[1] = ' ';
        //printf("Enter the coordinate for your shot (%d shots remaning): ", shells);
        printf("Enter the coordinate for your shot (%d shots remaning): \n", shells);
        scanf("%c%i", &move, &moveNum);
        //fflush(stdin);

       // printf("%c and the int is %i", move, moveNum);

        char a = 'a';
        int i = 0;

       while(i < 26)
       {
            if(move == a)
            {
                row1 = i;
            }
            i++;
            a++;
       }

        int j = 0;

        if(myArray[moveNum - 1][row1] =='f')
        {
            myArray2[moveNum - 1][row1] = 'h';
        }
        if(myArray[moveNum - 1][row1] =='F')
        {
            myArray2[moveNum - 1][row1] = 'h';
        }
        if(myArray[moveNum - 1][row1] =='b')
        {
            myArray2[moveNum - 1][row1] = 'h';
        }
        if(myArray[moveNum - 1][row1] =='c')
        {
            myArray2[moveNum - 1][row1] = 'h';
        }
       if(myArray[moveNum - 1][row1] == '-')
       {
            myArray2[moveNum - 1][row1] = 'm';
       }

       int carrierDown = 0;
       int frigateDown = 0;
       int frigate2Down = 0;
       int battleshipDown = 0;
/*
       for(int i = 0; i < gridSize; i++)
       {
            for(int j = 0; j < gridSize; j++)
            {
             if(myArray[i][j] = 'c' && myArray2[i][j] = 'h')
             {
                carrierDown++;
             }
            }
        }

       if(myArray[0][0] = 'c' && myArray[0][0] = 'h')
       {
            carrierDown++;
       }
       */

        /*
        while(int i < ROWS && int j < COLS )
        {
            if()
        }
        */
       //printArray(myArray2, ROWS, COLS);

        //printf(strlen(array1));

/*
        for(int i = 0; i < 2; i++)
        {
            scanf("%c", &array1[i]);
        }
    */
    shells--;
   }



   deleteArray(myArray, ROWS, COLS);
   deleteArray(myArray2, ROWS, COLS);

   return EXIT_SUCCESS;


    printf("Hello world!\n");
    return 0;
}

int** createArray(int rows, int cols) {
  int **myArray;

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
  int count = 1;
  char spacer = '-';
  //struct Ships newShip;
  int randomLocation;

  //myArray[rand() % (rows * cols)][rand() % (rows * cols)] = newShip;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      myArray[i][j] = spacer;
      count++;
    }
  }

  return;
}

void fillArrayShips(int** myArray, int rows, int cols) {
  int count = 1;
  char spacer = '-';
  //struct Frigate newShip;
  //int randomLocation;

  //myArray[0][0] = newShip.Frigate;


  return;
}



void printArray(int** myArray, int rows, int cols) {
char chCounter = 'A';
printf("    ");
for(int k = 0; k < cols; k++)
{
    printf("%c", chCounter);
    chCounter++;
    printf(" ");
}
printf("\n");

printf("   ");
printf("+");
for(int l = 0; l < cols; l++)
{
    printf("--");
}

printf("\n");

int counter = 1;
  for (int i = 0; i < rows; i++) {
    printf("%i", counter);
    counter++;
    printf("  |");
    for (int j = 0; j < cols; j++) {
      printf("%c ", myArray[i][j]);
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

void placeBoats(int** myArray, int rows, int cols)
{
  struct boat carrier;
  struct boat battleship;
  struct boat frigate;
  struct boat frigate2;

  carrier.length = 5;
  carrier.id = 'c';

  battleship.length = 4;
  battleship.id = 'b';

  frigate.length = 2;
  frigate.id = 'f';

  frigate2.length = 2;
  frigate2.id = 'F';

  srand(time(NULL));
  int clearSpot = rand() % (rows - (carrier.length - 1));
  int newColRow = rand() % cols;
  int isVert = rand() % 2;

  if(isVert == 1){
   for(int i = clearSpot; i < clearSpot + carrier.length; i++){
     myArray[i][newColRow] = carrier.id;
     }
   }
    else
    {
      for(int i = clearSpot; i < clearSpot + carrier.length; i++){
         myArray[newColRow][i] = carrier.id;
     }
  }


int validPosition;

do{
  validPosition = 1;
  clearSpot = rand() % (rows - (battleship.length - 1));
  newColRow = rand() % cols;
  isVert = rand() % 2;

  if(isVert = 1)
  {
    for(int j = clearSpot; j < clearSpot + battleship.length; j++)
    {
      if(myArray[j][newColRow] != '-') validPosition = 0;
    }
   }
   else
   {
     for(int j = clearSpot; j < clearSpot + battleship.length; j++)
    {
       if(myArray[newColRow][j] != '-') validPosition = 0;
    }
   }
}while(validPosition == 0);


if(isVert == 1)
{
   for(int j = clearSpot; j < clearSpot + battleship.length; j++)
   {
     myArray[j][newColRow] = battleship.id;
   }
}
  else
  {
  for(int j = clearSpot; j < clearSpot + battleship.length; j++){
     myArray[newColRow][j] = battleship.id;
     }
  }

void placeFrigate(validPosition, verticle, rows, cols, frigate2, myArray);

void placeFrigate2(validPosition, verticle, rows, cols, frigate2, myArray);

  return;
}

//Place thge second Frigate
void placeFrigate2(int validPosition, int verticle, int rows, int cols, struct boat frigate2, int **myArray)
{
    int clearSpot = 0;
    int newColRow = 0;
    int isVert = rand() % 2;

  do
  {
  validPosition = 1;
  clearSpot = rand() % (rows - (frigate2.length - 1));
  newColRow = rand() % cols;

  if(isVert = 1)
  {
    for(int l = clearSpot; l < clearSpot + frigate2.length; l++)
    {
      if(myArray[l][newColRow] != '-') validPosition = 0;
    }
  }
   else
   {
     for(int l = clearSpot; l < clearSpot + frigate2.length; l++)
    {
       if(myArray[newColRow][l] != '-') validPosition = 0;
    }
   }
}while(validPosition == 0);


  if(isVert == 1)
  {
   for(int l = clearSpot; l < clearSpot + frigate2.length; l++)
   {
     myArray[l][newColRow] = frigate2.id;
    }
   }
  else
  {
  for(int l = clearSpot; l < clearSpot + frigate2.length; l++)
  {
     myArray[newColRow][l] = frigate2.id;
  }
}
}

//Place the first frigate
void placeFrigate(int validPosition, int verticle, int rows, int cols, struct boat frigate, int **myArray)
{

    int clearSpot = 0;
    int newColRow = 0;
    int isVert = rand() % 2;

  do
  {
  validPosition = 1;
  clearSpot = rand() % (rows - (frigate.length - 1));
  newColRow = rand() % cols;

  if(isVert = 1)
  {
    for(int l = clearSpot; l < clearSpot + frigate.length; l++)
    {
      if(myArray[l][newColRow] != '-') validPosition = 0;
    }
  }
   else
   {
     for(int l = clearSpot; l < clearSpot + frigate.length; l++)
    {
       if(myArray[newColRow][l] != '-') validPosition = 0;
    }
   }
}while(validPosition == 0);


  if(isVert == 1)
  {
   for(int l = clearSpot; l < clearSpot + frigate.length; l++)
   {
     myArray[l][newColRow] = frigate.id;
    }
   }
  else
  {
  for(int l = clearSpot; l < clearSpot + frigate.length; l++)
  {
     myArray[newColRow][l] = frigate.id;
  }
}
}

