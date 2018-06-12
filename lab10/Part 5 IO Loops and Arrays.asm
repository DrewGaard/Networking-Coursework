# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	
	la $t8, string		#Load the address of the first byte of the string
	
	# Print msg1
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	
	syscall

	# Get N from user and save
	li	$v0, 8		# read_int syscall code = 5
	syscall	
	move	$t0,$v0		# syscall results returned in $v0
	
	li	$v0, 4		# print_string syscall code = 4
	la	$a0, msg2
	syscall
	
	# Initialize registers
	li	$t1, 0		# initialize counter (i)
	move	$t2, $t0		# initialize sum
	
	

	

		# Exit routine - print msg2
	exit:	li	$v0, 4		# print_string syscall code = 4
		la	$a0, msg2
		syscall

		# Print sum
		li	$v0, 4		# print_string syscall code = 4
		move	$a0, $t2
		syscall

	
	
	
	#whileLoop:
		#sub $t0, $t0, 1			#Subtract 1 to the Zvalue
		#sub $t1, $t1, 1			#Subtract 1 from the Ivalue
		#blt $t1, 0, exit		#If Ivalue is less than 0 end the loop an jump to exit
		#j   whileLoop			#Else keep going through the while loop
		
	#exit:					#Exit out of loop

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
Ivalue:	.word 0
msg1:	.asciiz	"Please enter a string: "
msg2:	.asciiz	"String match: "
lf:     .asciiz	"\n"

string  : .byte 0:256   
