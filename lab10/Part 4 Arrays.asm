# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	
	lw $t1, Ivalue		# Load the word stored at label 'Ivalue'
	
	lw $t4, Cvalue		# Load the word stored at label 'Ivalue'
	
	la $t2, Blist         	# Put address of list into $t3
	la $t3, Alist         	# Put address of list into $t3
	
	
	lw $t6, 0($t2)		#Load the memory location of $t2 into $t6
	lw $t7, 0($t3)		#Load the memory location of $t3 into $t7
	
	forLoop:
		add $t1, $t1, 1		#Increment Ivalue by 1
		
		
		add $t7, $t6, $t4	#add the value in Blist to 12(Cvalue) and save it into Alsit
		
		sw $t7, Alist		#Save the value in $t3 to Alist
		
		add $t6, $t6, 4		#Go to the next memory location in Blist
		add $t7, $t7, 4		#Go to the next memory location in Alist
		
		
		blt $t1, 5, forLoop	#Continue the forLoop while Ivalue is less than 5
		j exitLoop		#Jump to exitLoop
		
	exitLoop:
	
		sub $t1, $t1, 1		#Decrement Ivalue by 1
		j whileLoop		#Jump to the while loop
		

	whileLoop:
		
		mul $t3, $t3, 2		#Multiply each value in Alist by 2
		sw  $t3, Alist		#Save the value in $t3 to Alist
		add $t3, $t3, 4		#Go to the next memory address in Alist
		sub $t1, $t1, 1		#Decrement Ivalue by 1
		bgt $t1, 0, exit	#If Ivalue is less than 0 end the loop an jump to exit
		j   whileLoop		#Else keep going through the while loop
		
	exit:				#Exit out of loop		
		
		
	

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
Alist: .word 0, 0, 0, 0, 0
Blist: .word 1, 2, 3, 4, 5
Cvalue: .word 12
Ivalue: .word 0
