	.data
n:	.word 25 
str1: 	.asciiz "Less than\n"
str2: 	.asciiz "Less than or equal to\n"
str3: 	.asciiz "Greater than\n"
str4: 	.asciiz "Greater than or equal to\n"

	.text
main:	la 	$t0, n			#Load register $t0 with address of n
		lw $t0, 0($t0)		#Loads register $t0 with value at $t0, which is n
	
		li $v0, 5		#set to take int input, saves it to $v0
		syscall
		move $t1, $v0		#save contents of user input to register $t1

#------------- Question 5 & 6 ------------------

#		slt $t2, $t1, $t0 	#if user input ($t1) < n ($t0) set $t2 to 1
#		beq $t2, $0, meq	# $t2 is 0, input >= n, 
#		la $a0, str1		#otherwise input < n (should output less than)
#		j finish

#meq:	la	$a0, str4		#if input >= n, set string to "Greater than or equal to"

#------------------------------------------------
		slt $t2, $t0, $t1 	#if user input ($t1) > n ($t0) set $t2 to 1
		bne $t2, $0, more	#if input > n ($t2 !=0, $t2 == 1) branched to more
		la $a0, str2		#if input !> n (input <= n) print "Less than or equal to\n"
		j finish
		
more:	la 	$a0, str3		#if input is greater than
		
finish: li 	$v0, 4			#output comparison
		syscall
		li $v0, 10		#End program	
		syscall	





	
	
	
