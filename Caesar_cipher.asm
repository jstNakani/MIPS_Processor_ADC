.data
    shift_val:  .word 3
    step_val:   .word 4
    str_ptr:    .word 20
    my_string:  .asciiz "hello"

.text
main:
    # 1. Setup
    lw   $t1, shift_val
    lw   $t2, step_val
    lw   $t3, str_ptr

loop:
    lw   $t4, 0($t3)
    beq  $t4, $zero, exit
    add  $t4, $t4, $t1
    sw   $t4, 0($t3)
    add  $t3, $t3, $t2
    j    loop

exit:
    nop