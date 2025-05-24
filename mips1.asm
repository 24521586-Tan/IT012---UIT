.data
	prompt_n:      .asciiz "Nhap so phan tu n: "
	prompt_elem:   .asciiz "Nhap phan tu thu "
	prompt_i:      .asciiz "Nhap i: "
	prompt_j:      .asciiz "Nhap j: "
	newline:       .asciiz "\n"
	space:         .asciiz " "
	array:         .space 400  

.text
.globl main
main:
    	li $v0, 4
    	la $a0, prompt_n
    	syscall

    	li $v0, 5
    	syscall
    	move $t7, $v0

    	li $t0, 0           
    	la $s3, array       
    
nhap_loop:
    	bge $t0, $t7, nhap_done


    	li $v0, 4
    	la $a0, prompt_elem
    	syscall

    	move $a0, $t0
    	li $v0, 1
    	syscall

    	li $v0, 4
    	la $a0, space
    	syscall

    	li $v0, 5
    	syscall
    	move $t1, $v0

    	mul $t2, $t0, 4
    	add $t3, $s3, $t2
    	sw $t1, 0($t3)

    	addi $t0, $t0, 1
    	j nhap_loop

nhap_done:

    	li $v0, 4
    	la $a0, prompt_i
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0 

    	li $v0, 4
    	la $a0, prompt_j
    	syscall

    	li $v0, 5
    	syscall
    	move $s1, $v0    
    	
    	sll $t4, $s0, 2
    	add $t5, $s3, $t4

    	blt $s0, $s1, less_than
    	
    	sw $s1, 0($t5)
    	j print_array

less_than:
    	sw $s0, 0($t5)
    	
print_array:
    	li $v0, 4
    	la $a0, newline
    	syscall

    	li $t0, 0 
print_loop:
    	bge $t0, $t7, end_program

    	mul $t2, $t0, 4
    	add $t3, $s3, $t2
    	lw $a0, 0($t3)

    	li $v0, 1
    	syscall
    	
    	li $v0, 4
    	la $a0, space
    	syscall

    	addi $t0, $t0, 1
    	j print_loop

end_program:
    	li $v0, 10
    	syscall
