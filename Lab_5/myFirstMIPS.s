	.data
	
	.text 
main:		addi 	$s0, $zero, 0	#set $s0 to 0
		add 	$t0, $zero, $s0 #set $t0 = $s0
		addi 	$t1, $t0, 1	#$t1 = $t0 + 1 = 1
		addi 	$t2, $t1, 2	#$t2 = $t1 + 2 = 3
		addi 	$t3, $t2, 3	#6
		addi 	$t4, $t3, 4	#10
		addi 	$t5, $t4, 5	#15
		addi 	$t6, $t5, 6	#21
		addi 	$t7, $t6, 7	#28
		
		addi 	$a0, $t7, 0	#$a0 = $t7
		li      $v0, 1		#Load Immediate, loads $v0 as 1, specify Print Integer service
		syscall			#syscall looks back at code run, ouput value of $a0, print number
		li      $v0, 10		#signal end of code
		syscall			#syscall outputs -- program is finished running --
