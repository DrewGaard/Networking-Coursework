# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	li $t0, 15		# Load immediate value (15) A
	li $t1, 10		# Load immediate value (10) B
	li $t2, 5		# Load immediate value (5) C
	li $t3, 2		# Load immediate value (2) D
	li $t4, 18		# Load immediate value (18) E
	li $t5, -3		# Load immediate value (-3)  F
	
	sub $t6, $t0, $t1	#Subtract A($t0) from B($t1)
	mul $t7, $t2, $t3	#Multiply C($t2) from D($t3)
	sub $t8, $t4, $t5	#Subtract E($t4) from F($t5)
	div $t9, $t0, $t2	#Subtract E($t0) from F($t2)
	
	
	
	add $s0, $t6, $t7	#Adding results together and placing result in $s0
	add $s0, $s0, $t8
	sub $s0, $s0, $t9
	
	
	sw $s0, Zvalue

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
