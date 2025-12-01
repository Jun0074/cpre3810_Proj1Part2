# Forwarding: Load -> store data
.data
vals: .word 21, 40, 20, 3, 6
.text
.globl _start
_start:
    la   x10, vals           # x10 = &val
    
    lw   x2, 0(x10)         # x2 = 21
    sw   x2, 4(x10)         # store loaded value at val+4

    lw   x2, 8(x10)         # x2 = 21
    sw   x2, 12(x10)         # store loaded value at val+4
    
    lw   x2, 16(x10)         # x2 = 21
    sw   x2, 20(x10)         # store loaded value at val+4
    
