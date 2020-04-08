        .data

# TPS 2 #3 (statement to be displayed)
str1:	.asciiz "Please enter an integer: " #declare the string

        .text
main: 		addi $sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
		# TPS 2 #3 (display statement)
		
		la $a0, str1	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
		
		# TPS 2 #4 (read user input)

		li $v0,5       #string output syscall
		syscall
		move $t3,$v0    #save value in $v0 to $a0 to be argument for recursion func
		
		jal recursion	# Call recursion(x)
		
		# TPS 2 #6 (read user input)
		
		move $a0, $v0
		li $v0, 1 	#numerical output syscall
		syscall
		
		j end		# Jump to end of program


# Implementing recursion
recursion:	addi $sp, $sp, -12	# Push stack frame for local storage

		# TPS 2 #7 
		
		
		
		addi $t0, $a0, 1
		bne $t0, $zero, not_minus_one
		
		# TPS 2 #8 (update returned value)
		
		
		j end_recur
			
not_minus_one:	bne $a0, $zero, not_zero

		# TPS 2 #9 (update returned value)
		
		
		j end_recur		

not_zero:	sw $a0, 4($sp) 	
		# TPS 2 #11 (Prepare new input argument, i.e. m - 2)
		
		
		
		jal recursion	# Call recursion(m - 2)
		
		# TPS 2 #12 

		
		
		# TPS 2 #13 (Prepare new input argument, i.e. m - 1)
		
		
		jal recursion	# Call recursion(m - 1)
		
		# TPS 2 #14 (update returned value)
		
		
		j end_recur
		

# End of recursion function	
end_recur:	# TPS 2 #15 

		addi $sp, $sp, 12	# Pop stack frame 
		jr $ra

# Terminating the program
end:	addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li $v0, 10 
		syscall
