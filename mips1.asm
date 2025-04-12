.data
prompt_n:          .asciiz "Nhap so phan tu n (1-20): "
prompt_min:        .asciiz "Nhap gia tri nho nhat: "
prompt_max:        .asciiz "Nhap gia tri lon nhat: "
print_min:	   .asciiz "Gia tri nho nhat la: "
print_max:	   .asciiz "Gia tri lon nhat la: "
prompt_elem:       .asciiz "Nhap gia tri phan tu thu "
prompt_elem_end:   .asciiz ": "
newline:           .asciiz "\n"
.align 2
arr:               .space 80

.text
.globl main

main:
nhap_n:
    li $v0, 4
    la $a0, prompt_n
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    blt $t0, 1, nhap_n
    bgt $t0, 20, nhap_n

nhap_min:
    li $v0, 4
    la $a0, prompt_min
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

nhap_max:
    li $v0, 4
    la $a0, prompt_max
    syscall
    li $v0, 5
    syscall
    move $t2, $v0
    blt $t2, $t1, nhap_min

    li $t3, 0
    la $t4, arr

nhap_mang:
    beq $t3, $t0, tim_max_min

    li $v0, 4
    la $a0, prompt_elem
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, prompt_elem_end
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    blt $t5, $t1, nhap_mang
    bgt $t5, $t2, nhap_mang

    sw $t5, 0($t4)
    addi $t4, $t4, 4
    addi $t3, $t3, 1
    j nhap_mang

tim_max_min:
    la $t4, arr
    lw $t6, 0($t4)
    move $t7, $t6
    li $t3, 1
    addi $t4, $t4, 4

tim_loop:
    beq $t3, $t0, in_kq
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    bgt $t8, $t6, set_max
    blt $t8, $t7, set_min
    j next

set_max:
    move $t6, $t8
    j next

set_min:
    move $t7, $t8

next:
    addi $t3, $t3, 1
    j tim_loop

in_kq:
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, print_max
    syscall
    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, print_min
    syscall
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 10
    syscall
