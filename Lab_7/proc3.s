		.data
x:		.word 5
y:		.word 10

		.text
MAIN:	la $t0, x
		lw $s0, 0($t0)	# s0 = x
		la $t0, y
		lw $s1, 0($t0) 	# s1 = y
		
		add $s1, $s0, $s1	#y(s1) = x(s0) + y(s1)
		
		# Prepare to call sum(x)
		add $a0, $s0, $zero	# Set a0 = m <= x
		add $a1, $s1, $zero	# Set a1 = n <= y
		jal SUM
		
		add $s1, $s1, $v0	# Add result of sum to y, y = (x+y) + sum(x,y)
		
		add $a0, $s1, $zero 	#print result y
		li $v0, 1		 
		syscall	
		j END

		
SUM: 	addi $sp, $sp, -20		#prepare to save 3 items
		sw $a0, 16($sp)		#Save a0 = m before jumping
		sw $a1, 12($sp)		#Save a1 = n before jumping
		sw $s0, 8($sp)		#Save main's s0 = x as callee
		sw $s1, 4($sp)		#Save main's s1 = y as callee
		sw $ra, 0($sp)		#Save $ra back to main before jumping
		
		add $t0, $a0, $zero	#temp m(sum a0) is t0
		add $t1, $a1, $zero	#temp n(sum a1) is t1
		
		addi $a0, $t1, 1	# sub a0 (1st arg) a = n+1 -> a0
		addi $a1, $t0, 1	# sub a1 (2nd arg) b = m+1 -> a1
		jal SUB
		add $s0, $v0, $zero	#save sub response to p = s0
		
		addi $a0, $t0, -1	# sub a0 (1st arg) a = m-1 -> a0
		addi $a1, $t1, -1	# sub a1 (2nd arg) b = n-1 -> a1
		jal SUB
		add $s1, $v0, $zero	#save sub response to q = s1
		
		add $v0, $s0, $s1 	# return p + q, s0 + s1
		
		lw $a0, 16($sp)		#Restore a0 = m before jumping
		lw $a1, 12($sp)		#Restore a1 = n before jumping
		lw $s0, 8($sp)		#Restore main's s0 = x as callee
		lw $s1, 4($sp)		#Restore main's s1 = y as callee
		lw $ra, 0($sp)		#Restore $ra back to main before jumping
		addi $sp, $sp, 20	#return sp space
		jr $ra			#return to main
		
SUB:	sub $v0, $a1, $a0		#subtract b - a, save result to $v0
		jr $ra

		
END:	li $v0, 10	#End program	
		syscall	

