# Forwarding: Store -> load same address (memory ordering)
.data
vals: .word 1, 2, 3, 4, 5
.text
.globl test
test:
    la   x10, vals
    
    addi x1, x0, 55
    sw   x1, 0(x10)         # MEM[vals] = 55
    lw   x2, 0(x10)         # must see 55
    
    addi x1, x0, 66
    sw   x1, 4(x10)         # MEM[vals] = 55
    lw   x3, 4(x10)         # must see 55
    
    addi x1, x0, 77
    sw   x1, 8(x10)         # MEM[vals] = 55
    lw   x4, 8(x10)         # must see 55
   
    addi x1, x0, 88
    sw   x1, 12(x10)         # MEM[vals] = 55
    lw   x5, 12(x10)         # must see 55
    
    addi x1, x0, 99
    sw   x1, 16(x10)         # MEM[vals] = 55
    lw   x6, 16(x10)         # must see 55
