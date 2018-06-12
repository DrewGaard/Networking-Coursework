# Lab 11
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	lw $s0, rangeLow		#Load the word that specifies the Lowest value
	lw $s1, rangeHigh 		#Load the word that specifies the highest value
	li $s7, 0
 	
 	
 	#This is the for loop it runs through 10 times 
 	#Each time it calls random_in_range twice.
 	#Once for a and once for b
 	#It then calls gcd passing in the the two random values a and b
 	#It then prints out the gcd of the two variables
	forLoop:	
	
		add $s7, $s7, 1		#Increment loop counter by 1
		
		
		#Call the random_in_range function with $s0 and $s1 as perameters
		move $a0, $s0		#The first argument for the function
		move $a1, $s1		#Second argument
		jal random_in_range
		move $s6, $v0		#Function return value
		
		
		
		#Call the random_in_range function with $s0 and $s1 as perameters
		move $a0, $s0		#The first argument for the function
		move $a1, $s1		#Second argument
		jal random_in_range
		move $s3, $v0		#Function return value
		
		#Call the gcd function with $s2 and $s3 as perameters
		move $a0, $s2		#The first argument for the function
		move $a1, $s6		#Second argument
		jal gcd
		move $s5, $v0		#Function return value
		
		#Print out the asciiz value
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, gcdPrint
		syscall
		
		
		#Print out the first random number
		li $v0, 1		#Use OP code 1	
		move $a0, $s6
		syscall
		
		#Print out the asciiz value
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, gcdPrint2
		syscall
		
		
		#Print out the second random number
		li $v0, 1		#Use OP code 1	
		move $a0, $s3	
		syscall
		
		#Print out the asciiz value
		li $v0, 4		#Use OP code 4 for asciiz
		la $a0, gcdPrint3
		syscall
		
		#Print out the gcd random number
		li $v0, 1		#Use OP code 1	
		move $a0, $s5	
		syscall

		#Print a new line
		la $a0, newLine
		addi $v0, $0, 4
		syscall
		
		
		ble $s7, 9, forLoop	#Continue the forLoop while Ivalue is less than or equal to 10
		j exitLoop		#Jump to exitLoop
		
		
	#This functions calculated the gcd of two numbers 
	#It takes in the two numbers as arguments	
	gcd:
					#Push function values
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		addi $sp, $sp, -4
		sw $s1, 0($sp)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		move $s0, $a0		#a
		move $s1, $a1		#b
		
		divu $s0, $s1	#divide a by b store result in $t1
		
		mflo $t5 	#Need to find the remainder
		
		
		beq $t5, 0, itsZero	#Jump to the label itsZero if $t1 is equal to 0
		move $s0, $s1
		move $s1, $t5
		
		#Move new variables and recursively call the gcd function
		move $a0, $s0
		move $a1, $s1
		jal gcd
		
		
	itsZero:		#Once a divided by b is zero pop values and return
		move $v0, $s1
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
			
		jr $ra
	
	
		
		
	
	#Get a random number that's in a specified range
	
	random_in_range:
	
		#Push onto stack
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		addi $sp, $sp, -4
		sw $s1, 0($sp)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		#Function arguments
		
		move $s0, $a0		#rangeLow
		move $s1, $a1		#rangeHigh
		
		sub $s2, $s1, $s0	#rangeHigh-rangeLow
		addi $s2, 1		#rangeHigh-rangeLow + 1
		
		jal get_random		#Get the random number
		
		move $s3, $v0		#Store the returned random number
		
		#Print returned value to test
		#li $v0, 1		#Use OP code 1	
		#move $a0, $s3	
		#syscall
		
		
		divu $s3, $s2		#Divide $s3 and $s2 get the result in $s4
		
		
		mfhi $s4
		
		
		addu $s4, $s4, $s0	#$s0 should be low: $t0 will be the random in range result
		
		move $v0, $s4
		
		#Pop from stack
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		
		
		jr $ra
	

	#Gets a random number went over in class
	get_random:
	
		#Push registers on the stack here
		#$s0, $s1, #ra 
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		addi $sp, $sp, -4
		sw $s1, 0($sp)
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		
		#Main part of the function went over in class
						
		li $t0, 36969			#Load values into register to get a random number
		li $t1, 18000
		li $t2, 65535
		
		lw $s0, Z			#Load words declared at the bottom of the program
		lw $s1, W
		
		#This is line one of the random number generator function dealing with Z
		and $t3, $s0, $t2
		mul $t3, $t0, $t3
		srl $t4, $s0, 16					#Shift right logical
		addu $s0, $t3, $t4
		sw $s0, Z
		
		#This is the second line of the function dealing with W
		add $t3, $s1, $t2
		mul $t3, $t1, $t3
		srl $t4, $s1, 16
		addu $s1, $t3, $t4
		sw $s1, W
		
		#To get the result: Line three of the function
		sll $t3, $s0, 16
		addu $t3, $t3, $s1			#Add against W: return value is in $t3
		
		move $v0, $t3 				#Return value
		
		#Pop all registers that were pushed
		#$s0, $s1, #ra 
		
		#Pop stack here
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		
		jr $ra				#Return from the function	
		
	#End of the program
	#The for loop is done
	exitLoop:

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
W: .word 50000
Z: .word 60000
rangeHigh: .word 100000
rangeLow: .word 1
gcdPrint: .asciiz " gcd of: " 
gcdPrint2: .asciiz " and "
gcdPrint3: .asciiz " is: "
newLine: .asciiz "\n"
