#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include "hangman.h"

bool check_game(char word[]);
void print_game();
void gameOver(int wrongGuess);


int wrongGuess = 0;
bool endLoop = false;
int z = 0;

int main(void)
{	
	char userInput[1];
	//int wrongGuess = 0;
	char word[] = "hangman";
	char guessedWord[] = "_______";
	int winCount = 0;
	char misses[26] = " ";
	//bool endLoop = false;
	printf("Welcome to Hangman!\n");
	printf("Version 1.0\n");
	printf("Implemented by Drew Overgaard\n");
	
	print_game(wrongGuess);
	
	
	do {
		//userInput = user_input();
		
		printf("\n");
		
		printf("Enter next character (A-Z), or 0 (zero to exit): ");
		scanf("%s", userInput);
		//printf("%s", userInput);
		
		
		endLoop = check_game(userInput);
		
		printf("\n");
		
		
		if(strchr(word, tolower(userInput[0])))	//I just convert all chars to lowercase
		{
			for(int i = 0; i < 7; i++)
			{
				if(word[i] == tolower(userInput[0]))
				{
					guessedWord[i] = tolower(userInput[0]);
				}
			}
			//printf(guessedWord);
		}
		else
		{
			//wrongGuess++;
			if((userInput[0] != '0') && (!strchr(misses, tolower(userInput[0]))))
			{
				misses[z] = tolower(userInput[0]); 
				z++;
				wrongGuess++;
			}
		}
		
		printf("\n");
		
		
		gameOver(wrongGuess);
		
		
			
		if(strcmp(guessedWord, "hangman") == 0)
		{
			endLoop = true;
			printf("Congratulations - you win!");
			printf("\n");
		}
		
		
		
		print_game(wrongGuess);
		printf("\n");
		
		printf(guessedWord);
		printf("\n");
		printf("%s", misses);
		printf("\n");
		
		//printf("%s", userInput);
	
	
		//printf("%d", endLoop);
	}while(endLoop == false);
}


bool check_game(char word[])
{
	if(word[0] == '0')
	{
		return true;
	}
	return false;
}


void print_game(int wrongGuess)
{
	char initialGame[100];
	char head[100];
	char body[100];
	char arm1[100];
	char arm2[100];
	char leg1[100];
	char leg2[100];
	if(wrongGuess == 0)
	{
		char initialGame[100] = " |-----|\n |     |\n |     |\n       |\n       |\n       |\n       |\n _______";
		printf("%s", initialGame);
	}
	if(wrongGuess == 1)
	{
		char head[100] = " |-----|\n |     |\n o     |\n       |\n       |\n       |\n       |\n_______";
		printf("%s", head);
	}
	if(wrongGuess == 2)
	{
		char body[100] = " |-----|\n |     |\n o     |\n |     |\n |     |\n       |\n       |\n_______";
		printf("%s", body);
	}
	else if(wrongGuess == 3)
	{
		char arm1[100] = " |-----|\n |     |\n o     |\n/|     |\n |     |\n       |\n       |\n_______";
		printf("%s", arm1);
	}
	else if(wrongGuess == 4)
	{
		char arm2[100] = " |-----|\n |     |\n o     |\n/|\\    |\n |     |\n       |\n       |\n_______";
		printf("%s", arm2);
	}
	else if(wrongGuess == 5)
	{
		char leg1[100] = " |-----|\n |     |\n o     |\n/|\\    |\n |     |\n/      |\n       |\n       |\n_______";
		printf("%s", leg1);
	}
	else if(wrongGuess == 6)
	{
		char leg2[100] = " |-----|\n |     |\n o     |\n/|\\    |\n |     |\n/ \\    |\n       |\n       |\n_______";
		printf("%s", leg2);
	}
}


void gameOver(int wrongGuess)
{
	if(wrongGuess == 6)
		{
			endLoop = true;
			printf("You lose - out of moves");
			printf("\n");
		}
}
