# Forwarding: Load -> branch compare
.data
zero_val: .word 0
.text
.globl test
test:
    la x1, zero_val
    lw x2, 0(x1) 

    beq  x2, x0, label      # RAW load->branch; must stall so branch sees loaded value
    addi x3, x0, 1          # MUST be flushed (branch is taken)

label:
    addi x4, x0, 4