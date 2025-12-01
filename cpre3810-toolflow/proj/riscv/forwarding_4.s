# Forwarding: Load -> ALU (load-use hazard)
.data
vals: .word 8, 4, 10
.text
.globl test
test:
    la   x10, vals          # x10 = &val
    lw   x2, 0(x10)         # x2 = 8

    add  x3, x2, x2         # RAW load-use; hazard unit must insert 1 stall, then forward
                            # expected: x3 = 16
                            
    lw x4, 4(x10)           # Same as above
    addi x5, x4, 1
    
    lw x6 8(x10)	     # Same as above
    addi x7, x6, 1
