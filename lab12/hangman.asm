# Hangman in MIPS Lab 12 Drew Overgaard

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	
	#Load values here!
	lw $s0, gameOver	#This value tells us if the game loop should end or not	
	lw $s1 printWhat	#This value determines what graphic to display depending on the number of wrong or correct moves
	lw $s3 charH
	lw $s4 charA
	lw $s5 charN
	lw $s6 charG
	lw $s7 charM

	#Print out the welcome message
	li $v0, 4		#Use OP code 4 for asciiz
	la $a0, printWelcome
	syscall
	
	#Print out the version number
	li $v0, 4		#Use OP code 4 for asciiz
	la $a0, printVersion
	syscall
	
	#Print out developer name
	li $v0, 4		#Use OP code 4 for asciiz
	la $a0, printName
	syscall
	
	#Print out the initalGame graphic
	li $v0, 4		#Use OP code 4 for asciiz
	la $a0, printInitialState
	syscall
	
	
	doWhileLoop:
	
		#Print out the prompt for user input
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, promptPrint
		syscall
	
	
		#Get the char from the user
		# Get N from user and save
		li	$v0, 12		# read_character syscall code = 12
		syscall	
		move	$t0,$v0		# syscall results returned in $v0
		
		beq $t0, '0', Exit	#Stop the program if the user enters 0
		
		#Print out a new line
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printNL
		syscall
		
		#Used for printing out chars used so far
		#li $t7, 7			#Used as a counter for the print loop
		la $a0, wordSoFar
		move $t9, $a0
		#li $t8, 0
		
		#Print all the spaces in wordSoFar
		
		
		
		
		#print_loop:
		#	beq $t8, $t7, print_loop_end
		#	#move $t9, $a0
		#	lw $a0, 0($t9) 			#Was lb
		#	li $v0, 11
		#	#move $a0, $t6
		#	syscall
		
		#	addi $t8, $t8, 1
		#	addi $t9, $t9, 4
		
		#	j print_loop
		#print_loop_end:
		#	li $t8, 0
		#	la $a0, wordSoFar
		#	move $t9, $a0
		
	
		#Load the hangManArray address into a register so we can compare values to user input	
		la $t1, hangManArray
		lb $t2, 0($t1)
		#li $v0, 11
		#syscall
		
		
		#All this is just to see if the userINput is equal to one of the chars in hangman
		
		beq $t2, $t0, CharSoFarH
		
		
		#beq $t2, $t0, StayTheSame
		
		
		lb $t2, 1($t1)
		
		beq $t2, $t0, CharSoFarA
		
	
		#beq $t2, $t0, StayTheSame
		
		lb $t2, 2($t1)
		beq $t2, $t0, CharSoFarN
		#beq $t2, $t0, StayTheSame
		
		lb $t2, 3($t1)
		beq $t2, $t0, CharSoFarG
		#beq $t2, $t0, StayTheSame
		
		lb $t2, 4($t1)
		beq $t2, $t0, CharSoFarM
		#beq $t2, $t0, StayTheSame
		
		lb $t2, 5($t1)
		beq $t2, $t0, CharSoFarA2
		#beq $t2, $t0, StayTheSame
		
		lb $t2, 6($t1)
		beq $t2, $t0, CharSoFarN2
		#beq $t2, $t0, StayTheSame
		 
		#Trying to change the value based on what the user types in
		
		
		
		
		#la $a0, wordSoFar2
		#move $t9, $a0
		#addi $t9, $t9, 4
		#sw $s3, 0($t9)	#Move the letter 'h' from $s3 to the first char in wordSoFar2
		
	
		
		
		
		
		j Increment			#If none of the above statements is true then increment
			
			
		
		
		#bne $a0, $t0, Increment
		
		
		blt $s0, 1, doWhileLoop 	#Contiunue looping while $s0(gameOver) is less than 1
		
		
		
		
	CharSoFarH:
		la $a0, wordSoFar
		move $t9, $a0
		sw $s3, 0($t9)
		j StayTheSame 
			
	CharSoFarA:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 4
		sw $t4, 0($t9)
		j StayTheSame
			
	CharSoFarN:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 8
		sw $t5, 0($t9)
		j StayTheSame
		
	CharSoFarG:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 12
		sw $t6, 0($t9)
		j StayTheSame
		
	CharSoFarM:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 16
		sw $t7, 0($t9)
		j StayTheSame
		
	CharSoFarA2:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 20
		sw $t4, 0($t9)
		j StayTheSame
		
	CharSoFarN2:
		la $a0, wordSoFar
		move $t9, $a0
		addi $t9, $t9, 24
		sw $t5, 0($t9)
		j StayTheSame
		
		
		
	
	
	StayTheSame:
		addi $t1, 1
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		j Print
		
	Increment:
		addi $s2, 1
		
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		addi $t9, $t9, 4
		lw $a0, 0($t9) 		#Was lb
		li $v0, 11
		syscall
		
		#sw $t0, guessedLetters
		#Print out a new line
		#li $v0, 11		#Use OP code 11 for char
		#la $a0, guessedLetters
		#syscall
		
		j Print
	
	
	
	
	Print:
		beq $s2, 0, PrintInitial 
		beq $s2, 1, PrintHead 
		beq $s2, 2, PrintBody 
		beq $s2, 3, PrintArm1 
		beq $s2, 4, PrintArm2 
		beq $s2, 5, PrintLeg1 
		beq $s2, 6, PrintLeg2 
	
		
		
		
		
	
	

		
	GuessNotEqual:
	#Print out a new line
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printHead
		syscall
		j doWhileLoop
		
		
		
	PrintInitial:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printInitialState
		syscall
		j doWhileLoop
	
	PrintHead:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printHead
		syscall
		j doWhileLoop
		
	PrintBody:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printBody
		syscall
		j doWhileLoop
		
	PrintArm1:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printArm1
		syscall
		j doWhileLoop
		
	PrintArm2:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printArm2
		syscall
		j doWhileLoop
		
	PrintLeg1:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printLeg1
		syscall
		j doWhileLoop
		
	PrintLeg2:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printLeg2
		syscall
		beq $s2, 6, GameOver
		
	
	#The game is over stop the program	
	GameOver:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printGameOver
		syscall
		j Exit
		
	GameOverWin:
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printGameOverWin
		syscall
		j Exit
	
	
	
	Exit:

	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
Zvalue: .word 0

charH: .word 104
charA: .word 97
charN: .word 110
charG: .word 103
charM: .word 109

hangManArray: .asciiz "hangman"
gameOver: .word 0
printWhat: .word 0
pintWhatWord: .word 0
wordSoFar: .word 95, 95, 95, 95, 95, 95, 95
wordSoFar2: .asciiz "_______"
wordH: .asciiz "h______"
wordA: .asciiz "_a___a_"
wordN: .asciiz "__n___n"
wordG: .asciiz "___g___"
wordM: .asciiz "____m__"
wordHA: .asciiz "ha___a_"
wordHN: .asciiz "h_n___n"
wordHG: .asciiz "h__g___"
wordHM: .asciiz "h___m__"
wordHAN: .asciiz "han__an"
wordHAG: .asciiz "ha_g_an"
wordHAM: .asciiz "ha__ma_"
wordHANG: .asciiz "hang_an"
wordHANGM: .asciiz "hangman"


guessedLetters: .asciiz " "

printWelcome: .asciiz "Welcome to Hangman!\n"
printVersion: .asciiz "Version 1.0\n"
printName: .asciiz "Implemented by Drew Overgaard\n"
promptPrint: .asciiz "Enter next character (A-Z), or 0 (zero to exit): "
printNL: .asciiz "\n"
printGameOver: .asciiz "You lose - out of moves"
printGameOverWin: .asciiz "Congratulations - you win!"
printInitialState: .asciiz "\n |-----|\n |     |\n |     |\n       |\n       |\n       |\n       |\n _______\n"
printHead: .asciiz "\n |-----|\n |     |\n o     |\n       |\n       |\n       |\n       |\n_______\n"
printBody: .asciiz "\n |-----|\n |     |\n o     |\n |     |\n |     |\n       |\n       |\n_______\n"
printArm1: .asciiz "\n |-----|\n |     |\n o     |\n/|     |\n |     |\n       |\n       |\n_______\n"
printArm2: .asciiz "\n |-----|\n |     |\n o     |\n/|\    |\n |     |\n       |\n       |\n_______\n"
printLeg1: .asciiz "\n |-----|\n |     |\n o     |\n/|\    |\n |     |\n/      |\n       |\n       |\n_______\n"
printLeg2: .asciiz "\n |-----|\n |     |\n o     |\n/|\    |\n |     |\n/ \    |\n       |\n       |\n_______\n"
