.data
    	prompt_n: .asciiz "Nhap so phan tu: "
    	prompt_element: .asciiz  "Nhap phan tu thu "
    	prompt_index: .asciiz "\nNhap chi so phan tu muon xem: "
    	result: .asciiz "Gia tri can tim la: "
    	min_val: .asciiz "Min = "
    	max_val: .asciiz "Max = "
    	sum_val: .asciiz "Tong = "
    	newline: .asciiz "\n"
    	.align 2
array: .space 400       

.text 
.globl main

main: 	
    	li $v0, 4
    	la $a0, prompt_n	
    	syscall
    
    	li $v0, 5
    	syscall 
    	move $s0, $v0        
    
    	la $s3, array      
    	li $t0, 0          
    

loop:
    	beq $t0, $s0, input
    
    	li $v0, 4
    	la $a0, prompt_element
    	syscall
    
    	li $v0, 1
    	move $a0, $t0
    	syscall 
    
    	li $v0, 4
    	la $a0, newline
    	syscall 
    
    	li $v0, 5
    	syscall 
    	move $t1, $v0
    
    	mul $t2, $t0, 4
    	add $t3, $s3, $t2
    	sw $t1, 0($t3)
    
    	addi $t0, $t0, 1
    	j loop
    

input:
    	li $t0, 0
    	li $t5, -2147483648
    	li $t6, 2147483647       
    	li $t7, 0                
    
calculation_loop:
    	beq $t0, $s0, done_calculate
    
    	mul $t2, $t0, 4
    	add $t3, $s3, $t2
    	lw $t1, 0($t3)
    
    	bgt $t1, $t5, update_max
    	j check_min
    
update_max:
    	move $t5, $t1

check_min:
    	blt $t1, $t6, update_min
    	j sum_step
    
update_min:
    	move $t6, $t1

sum_step:
    	add $t7, $t7, $t1
    	addi $t0, $t0, 1
    	j calculation_loop


done_calculate:
    	li $v0, 4
    	la $a0, max_val
    	syscall
    	li $v0, 1
    	move $a0, $t5
    	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall

    	li $v0, 4
    	la $a0, min_val
    	syscall
    	li $v0, 1
    	move $a0, $t6
    	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall

    	li $v0, 4
    	la $a0, sum_val
    	syscall
    	li $v0, 1
    	move $a0, $t7
    	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall


    	li $v0, 4
    	la $a0, prompt_index
    	syscall
    	li $v0, 5
    	syscall
    	move $t0, $v0

    	mul $t2, $t0, 4
    	add $t3, $s3, $t2
    	lw $t1, 0($t3)

    	li $v0, 4
    	la $a0, result
    	syscall
    
    	li $v0, 1
    	move $a0, $t1
    	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall

    	li $v0, 10
    	syscall
