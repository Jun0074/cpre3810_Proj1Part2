# Forwarding: ALU -> ALU via MEM/WB -> EX forwarding
test:
    addi x1, x0, 10         # x1 = 10
    addi x2, x0, 1          # x2 = 1

    add  x3, x1, x2         # x3 = 11, should be forwarding x2 from MEM/WB and x1 from EX/Mem

    addi x6, x0, 0          # nop

    add  x4, x3, x2         # RAW x3, should be forwarded from MEM/WB -> x4 = 12
