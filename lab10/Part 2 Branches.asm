# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	lw $t0, Avalue		# Load the word stored at label 'Avalue'
	lw $t1, Bvalue		# Load the word stored at label 'Bvalue'
	lw $t2, Cvalue		# Load the word stored at label 'Cvalue'
	lw $t3, Zvalue		# Load the word stored at label 'Zvalue'
	
	blt $t0, $t1, L1	#If A < B jump to L1
	
	bgt $t0, $t1, L3	#If A > B then jump to L3
	
	
	add $t4, $t2, 1		#Add 1 to C so we can compare the value in the next statement
	
	beq $t4, 7, L3		#If (C + 1) == 7 jump to L3
	
	
	L1:			
		bgt $t2, 5, L2	#If C > 5 jump to L2
		
	L2:
		li $t3, 1 	#Store 1 in Zvalue
		j switch	#Jump to switch statement
		
	L3:
		li $t3, 2 	#Store 1 in Zvalue
		j switch	#Jump to switch statement 
		
		
	li $t3, 3		#Store 3 in Zvalue
	
	
	
	#Starting the switch statement
	switch:
		beq $t3, 1, case1	#Jump to case 1 if $t3 is equal to 1
		beq $t3, 2, case2	#Jump to case 2 if $t3 is equal to 2
		beq $t3, 3, case3	#Jump to case 3 if $t3 is equal to 3
		
		case1:
			li $t3, -1	#Set $t3 to -1
			j done		#Jump to done label
			
		case2:
			li $t3, -2	#Set $t3 to -2
			j done		#Jump to done label
			
		case3:
			li $t3, -3	#Set $t3 to -3
			j done		#Jump to done label
				
		
	li $t3, 0			#Default case set $t3 value to 0	
	
	done:
		sw $t3, Zvalue		#Store value of $t3 into Zvalue


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
Avalue:	.word 10
Bvalue:	.word 15
Cvalue:	.word 6
Zvalue:	.word 0
