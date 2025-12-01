# Control: blt control hazard (signed)
test:
    # Not taken
    addi x1, x0, 5
    addi x2, x0, 3
    blt  x1, x2, blt_taken1   # 5 < 3 ? no
    addi x3, x0, 12           # must execute
blt_taken1:
    # Taken
    addi x4, x0, -1           # negative
    addi x5, x0, 0
    blt  x4, x5, blt_taken2   # -1 < 0 -> taken
    addi x6, x0, 99           # must be flushed
blt_taken2:
    addi x10, x0, 100
