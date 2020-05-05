.data 
str0: .asciiz "Welcome to BobCat Candy, home to the famous BobCat Bars!\n"
# Declare any necessary data here
str1: .asciiz "Please enter the price of a BobCat Bar: \n"
str2: .asciiz "Please enter the number of wrappers needed to exchange for a new bar: \n"
str3: .asciiz "How, how much do you have? \n"
str4: .asciiz "Good! Let me run the numbers ... \n"
str5: .asciiz "You first buy "
str6: .asciiz "Then, you will get another "
str7: .asciiz " bars.\n"
str8: .asciiz "With $"
str9: .asciiz ", you will receive a maximum of "
str10: .asciiz " BobCat Bars!\n"

.text

main:
		#This is the main program.
		la $a0, str0	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
		
		#It then prints out a statement about the maximum BobCat Bars the user will receive.
		
		addi $sp, $sp -16	# Feel free to change the increment if you need for space.
		# Implement your main here
		
		#It first asks user to enter the price of each BobCat Bar.
		la $a0, str1	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
		
		li $v0, 5	#read int value from user
		syscall
		sw $v0, 0($sp)	#save price to sp + 0
		
		#It then asks user to enter the number of bar wrappers needed to exchange for a new bar.
		la $a0, str2	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
		
		li $v0, 5	#read int value from user
		syscall
		sw $v0, 4($sp)	#save n to sp + 4
		
		#It then asks user to enter how much money he/she has.
		la $a0, str3	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
		
		li $v0, 5	#read int value from user
		syscall
		sw $v0, 8($sp)	#save money to sp + 8

		#It then calls maxBars function to perform calculation of the maximum BobCat Bars the user 
		# will receive based on the information entered. 
		
		lw $a1, 0($sp)	#save price to $a1
		lw $a0, 4($sp)	#save n to $a0
		lw $a2, 8($sp)	#save money to $a2
		
		jal maxBars 	# Call maxBars to calculate the maximum number of BobCat Bars
		
		sw $v0, 12($sp)	#save response from maxBars

		# Print out final statement here
		la $a0, str8	# set $a0 to string "with"
		li $v0, 4 	#string output syscall
		syscall
		
		lw $a0, 8($sp) #print orignal money
		li $v0, 1 	#int output syscall
		syscall
		
		la $a0, str9	# set $a0 to string "You will receive"
		li $v0, 4 	#string output syscall
		syscall
		
		lw $a0, 12($sp)	#print number of bars total
		li $v0, 1	#int output syscall
		syscall
	
		la $a0, str10	# set $a0 to string "Bobcat dollars"
		li $v0, 4 	#string output syscall
		syscall
		
		#return stack pointer
		addi $sp, $sp, 20

		j end			# Jump to end of program



maxBars:
		# This function calculates the maximum number of BobCat Bars.
		# It takes in 3 arguments ($a0, $a1, $a2) as n, price, and money. 
		# It returns the maximum number of bars
		
		addi $sp, $sp, -20	# 0 = $ra, 4 =n, 8=1st max candies, 12= wrapper bought candies, 16=wrappers
		
		add $t1, $zero, $zero
		
	Loop1:	slt $t0, $a2, $a1	#if money less than price, branch
		bne $t0, $zero, endLoop1
		sub $a2, $a2, $a1	#subtract price from money
		addi $t1, $t1, 1	#increment (t1 stores number of original candy)
		j Loop1
		
	endLoop1:	
		
		
		sw $ra, 0($sp)		#save $ra and t1(original candies) before jumping
		sw $a0, 4($sp)		#save n
		sw $t1, 8($sp)	
		
		#check if t1 is zero
		slt $t0, $zero, $t1	#if less than one bar can be bought, branch
		bne $t0, $zero, print
		move $v0, $t1		#set response to v0
		addi $sp, $sp, 20	#return stack pointer
		jr $ra
		
		#Print orignal number of candies
	print:	la $a0, str5	# set $a0 to string "You first buy "
		li $v0, 4 	#string output syscall
		syscall
		
		move $a0, $t1	# set $a0 to number of original candies bought
		li $v0, 1 	#integer output syscall
		syscall
		
		la $a0, str7	# set $a0 to string " bars.\n"
		li $v0, 4 	#string output syscall
		syscall
		
		#call newBars	
		
		lw $a1, 4($sp)		#make a1 n	
		lw $a0, 8($sp)			#make a0 number of wrappers
		add $t1, $zero, $zero
		
		jal newBars 	# Call a helper function to keep track of the number of bars.
		
		lw $t1, 8($sp)		#load old max candies
		add $v0, $v0, $t1	#return number of new bars + original bars
		
		lw $ra, 0($sp)
		
		addi $sp, $sp, 20	#return pointer
		
		jr $ra
		# End of maxBars

newBars:
		# This function calculates the number of BobCat Bars a user will receive based on n.
		# It takes in 2 arguments ($a0, $a1) as number of wrappers left so far and n.
		 
		sub $a0, $a0, $a1	#numwrappers - n
		addi $t1, $t1, 1	#increment return
		
		slt $t0, $a0, $a1 	
		beq $t0, $zero, newBars	#if numwrappers - n is still >=0, keep subtracting
		
		lw $t2, 12($sp)		#sum all wrapper bought candies
		add $t2, $t2, $t1	
		sw $t2, 12($sp)		
		
		add $a0, $a0, $t1	#sum old wrappers with new candies -> new wrappers
		sw $a0, 16($sp)		#save new wrappers
		
		#Print orignal number of candies
		la $a0, str6	# set $a0 to string "Then, you will get another "
		li $v0, 4 	#string output syscall
		syscall
		
		move $a0, $t1	# set to new candies wrappers bought
		li $v0, 1 	#int output syscall
		syscall
		
		la $a0, str7	# set $a0 to string "bars.\n"
		li $v0, 4 	#string output syscall
		syscall
		
		#return to newBars if new number wrappers buys more bars
		lw $a0, 16($sp)		#return number of left over wrappers
		
		slt $t0, $a0, $a1 	
		move $t1, $zero		#reset itterator
		beq $t0, $zero, newBars	#if numwrappers - n is still >=0, keep subtracting
		
		#return to maxBars
		lw $v0, 12($sp)		#else: return sum all wrapper bought candies
		jr $ra			
		# End of newBars

end: 
		# Terminating the program
		lw $ra, 0($sp)
		addi $sp, $sp 4
		li $v0, 10 
		syscall
