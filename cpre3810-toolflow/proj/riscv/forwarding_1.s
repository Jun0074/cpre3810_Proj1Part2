# Forwarding: ALU -> ALU forwarding (rs1 and rs2)
test:
    addi x1, x0, 5          # x1 = 5
    addi x2, x0, 7          # x2 = 7

    add  x3, x1, x2         # x3 = 12, @ RAW of x2 and x1
    add  x4, x3, x2         # RAW x3 in rs1 (EX/MEM -> EX), expect x4 = 19
    add  x5, x2, x3         # RAW x3 in rs2 (EX/MEM -> EX), expect x5 = 19
    
    addi x6, x5, 10	     # Raw x5 in rs1, expect x6 = 29