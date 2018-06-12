# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	lw $t0, Zvalue		# Load the word stored at label 'Zvalue'
	lw $t1, Ivalue		# Load the word stored at label 'Ivalue'
	
	
	
	forLoop:
		add $t1, $t1, 2		#Increment Ivalue by 2
		add $t0, $t0, 1		#Increment Zvalue by 1
		ble $t1, 20, forLoop	#Continue the forLoop while Ivalue is less than or equal to 20
		j exitLoop		#Jump to exitLoop
		
	exitLoop:
		j doWhileLoop		#Jump to doWhileLoop
	
	
	
	doWhileLoop:
		add $t0, $t0, 1			#Add 1 to the Zvalue
		blt $t0, 100, doWhileLoop	#Continue to loop while $t0 is less than 100
		
	whileLoop:
		sub $t0, $t0, 1			#Subtract 1 to the Zvalue
		sub $t1, $t1, 1			#Subtract 1 from the Ivalue
		blt $t1, 0, exit		#If Ivalue is less than 0 end the loop an jump to exit
		j   whileLoop			#Else keep going through the while loop
		
	exit:					#Exit out of loop
		
		
		sw $t0, Zvalue
		sw $t1, Ivalue
	
		
	
	
	
	

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
Zvalue:	.word 2
Ivalue: .word 0
