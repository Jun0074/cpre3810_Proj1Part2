# Control: bge control hazard (signed)
test:
    # Not taken
    addi x1, x0, -1
    addi x2, x0, 0
    bge  x1, x2, bge_taken1   # -1 >= 0 ? no
    addi x3, x0, 13           # must execute
bge_taken1:
    # Taken
    addi x4, x0, 5
    addi x5, x0, 3
    bge  x4, x5, bge_taken2   # 5 >= 3 -> taken
    addi x6, x0, 99           # must be flushed
bge_taken2:
    addi x10, x0, 100
