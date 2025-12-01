# Forwarding: ALU result forwarded into Store Data path (EX/MEM -> MEM[store])
.data
array: .word 0            # observable memory location
.text
.globl test
test:
    addi x1, x0, 30       # x1 = 30
    addi x2, x0, 12       # x2 = 12
    add  x3, x1, x2       # x3 = 42 (producer in EX/MEM)

    la   x10, array        # address to store into
    sw   x3, 0(x10)       # consumes x3 as store-data ? must be forwarded

    ebreak
