# Control: bgeu control hazard (unsigned)
test:
    # Not taken
    addi x1, x0, 1
    li   x2, -1               # 0xFFFFFFFF
    bgeu x1, x2, bgeu_taken1  # 1 >= 0xFFFFFFFF ? no
    addi x3, x0, 15           # must execute
bgeu_taken1:
    # Taken
    li   x4, -1               # 0xFFFFFFFF
    addi x5, x0, 1
    bgeu x4, x5, bgeu_taken2  # 0xFFFFFFFF >= 1 -> taken
    addi x6, x0, 99           # must be flushed
bgeu_taken2:
    addi x10, x0, 100
