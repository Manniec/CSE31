        .data
n:      .word 13
str1:	.asciiz "Please enter a number: " #declare the string

        .text
main: 	la	$a0, str1	# set $a0 to string 
		li $v0, 4 	#string output syscall
		syscall
	
	li 	$v0,5		#string output syscall
		syscall
		move $t3,$v0	#save value in $v0 to $t3

	add     $t0, $0, $zero
		addi    $t1, $zero, 1

		
fib: 	beq     $t3, $0, finish
		add     $t2,$t1,$t0
		move    $t0, $t1
		move    $t1, $t2
		subi    $t3, $t3, 1
		j       fib
		
finish: addi    $a0, $t0, 0
		li      $v0, 1		
		syscall			
		li      $v0, 10		
		syscall			

