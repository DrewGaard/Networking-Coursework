# Final Exam Drew Overgaard ECPE 170

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	lw $s1, array		# Load the address of the array into $s1
	lw $s2, arraySize	# Load the arraySize value into $S2	
	lw $s3, search		# Load the search value into $s3
	lw $s4, result		# Store the result variable in $s4
	
	
	li $t0, 0
	
	#The arraySearch recursive function
	#Push registers on the stack here
	arraySeach:
	
	
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		addi $sp, $sp, -4
		sw $s1, 4($sp)
		addi $sp, $sp, -4
		sw $s2, 8($sp)
		sw $ra, 0($sp)
		
		
		lw $t6, array($t0)
		#Function arguments
		
		#array[arraySize] == search
		beq $t6, $s1, resultEqual
		
		#else if (arraySize == -1)
		beq $s2, -1, resultNegativeOne
		
		#else
		addi $t0, 4
		jal arraySearch
		
		
		
		#Pop from stack
		lw $ra, 0($sp)
		lw $s2, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		move $s2, $s4
		
	
	
	#Creating the if statement
	blt $s4, 0, notFound

	
	Found:
		#Print out the found message
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printFound
		syscall
		
		#Print out the search element
		li $v0, 1		#Use OP code 1	
		move $a0, $s3
		syscall
		
		#Print out the found message
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printFound2
		syscall
		
		#Print out the result
		li $v0, 1		#Use OP code 1	
		move $a0, $s4
		syscall
		
		#Print out the newLine
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printNewLine
		syscall
		
		j Exit
	
	
	notFound:
		#Print out the not found message
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, printNotFound
		syscall
		j Exit
		
		
	resultEqual:
		#Pop from stack
		lw $ra, 0($sp)
		lw $s2, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		move $s2, $s4
		j Found
		
	resultNegativeOne:
		#Pop from stack
		lw $ra, 0($sp)
		lw $s2, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		li $s4, -1
		j Found
		
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
array: .space 20
arraySize: .word 5
search: .word 7
result: .word 0
i: .word 0
printNotFound: .asciiz "Search key not found\n"
printFound: .asciiz "Element "
printFound2: .asciiz " found at array index "
printNewLine: .asciiz "\n"
