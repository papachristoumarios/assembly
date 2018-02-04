main:
    addi $a0, $a0, 3
    jal fibonacci
    add $s2, $v0,$zero
    addi $v0, $zero, 10
    syscall

fibonacci:
    #save in stack
    addi $sp, $sp, -12
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)

    add $s0, $a0, $zero

    slti $t0, $s0, 2 # if n < 2 return n
    bne $t0, $zero, return_as_is

    addi $a0, $s0, -1

    jal fibonacci

    add $s1, $zero, $v0         # $s1 = fib(y - 1)

    addi $a0, $s0, -2

    jal fibonacci # $v0 = fib(n - 2)

    add $v0, $v0, $s1 # $v0 = fib(n - 2) + $s1

    j restore

    return_as_is:
      add $v0, $s0, $zero
      j restore

    restore:
      # restore stack
      lw   $ra, 0($sp)
      lw   $s0, 4($sp)
      lw   $s1, 8($sp)
      addi $sp, $sp, 12
      jr $ra
