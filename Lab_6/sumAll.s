	.data 
possum:	.word 0
negsum:	.word 0
str1:	.asciiz "Please enter a number: "
str2:	.asciiz "\nSum of positive numbers is:\n"
str3:	.asciiz "\nSum of negative numbers is:\n"
	.text
main:	la 	$s1, negsum		#Load register $s1 with address of negsum
		lw $t1, 0($s1)		#Load register $t1 with value of negsum
		la $s0, possum		#Load register $s0 with address of possum
		lw $t0, 0($s0)		#Loads register $t0 with value of possum

asknum:	la 	$a0, str1	#"Please enter a number: "
		li $v0, 4 	#string output syscall
		syscall
		
		li $v0, 5	#set to take int input, saves it to $v0
		syscall
		move $t2, $v0	#save user input to $t2
		
		beq $t2, $0, finish	#if user inputs 0, branch to finish
		slt $t3, $t2, $0	#else check if user input < 0 $t3 = 1, else (input > 0) $t3 = 0
		beq $t3, $0, addpos	#if input > 0, go to addpos
					#else
		add $t1, $t2, $t1	# add input to negsum
		#sw $t5, 0($t4)		#Save negsum back into location
		j asknum
		
addpos:	add 	$t0, $t2, $t0 		#adds user input to possum
		#sw $t3, 0($t2)		#Save possum back into location
		j asknum
		

finish:	la	$a0, str2	#"Sum of positive numbers is:\n"
		li $v0, 4 	#string output syscall
		syscall
		
		add $a0, $t0, $0	#load $a0 as possum for output
		li $v0, 1 	#numerical output syscall
		syscall
		
		la $a0, str3	#"Sum of negative numbers is:\n"
		li $v0, 4	#string output syscall
		syscall
		
		add $a0, $t1, $0	#load $a0 as negsum for output
		li $v0, 1 	#numerical output syscall
		syscall
		
		li $v0, 10	#End program	
		syscall	
