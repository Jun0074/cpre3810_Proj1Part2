.data
res:
    .word 0

.text
.globl _start
_start:
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0

    lui  sp, 0x10011
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi sp, sp, 0

end:
    wfi
