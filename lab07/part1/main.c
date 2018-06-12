#include <stdint.h>

int main()
{

	uint32_t array1[3][5]; // 2D array
	uint32_t array2[3][5][7];  // 3D array
	
	printf("Now setting each space in the two dimensional array equal to a value.");
	printf("\n");
	printf("Printing each spaces memory location aswell.");
	printf("\n");

	for (int i = 0; i < 3; i++)
	{
		for(int j = 0; j < 5; j++)
		{
			array1[i][j] = j;
			printf("Now printing space: %d %d Memory Address: %p", i, j, &array1[i][j]);
			printf("\n");
		}
		printf("\n");
	}
	
	
	printf("Now setting each space in the three dimensional array equal to a value.");
	printf("\n");
	printf("Printing each spaces memory location aswell.");
	printf("\n");
	
	for (int i = 0; i < 3; i++)
	{
		for(int j = 0; j < 5; j++)
		{
			for (int k = 0; k < 7; k++)
			{
				array2[i][j][k] = k;
				printf("Now printing space: %d %d %d Memory Address: %p", i, j, k, &array2[i][j][k]);
				printf("\n");
			}
		}
		printf("\n");
	}
	
	printf("As can be seen from the output, each location in memory is allocated sequentially. \n");
	printf("So the entire row is allocated first then the next row and the next. \n");
	printf("The memory address of the location where each sequential array element is stored increments by 4. \n");

}
