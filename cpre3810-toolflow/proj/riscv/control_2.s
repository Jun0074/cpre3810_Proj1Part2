# Control: bne control hazard
test:
    # Not taken
    addi x1, x0, 5
    bne  x1, x1, bne_taken1   # not taken
    addi x2, x0, 11           # must execute
bne_taken1:
    # Taken
    addi x3, x0, 5
    addi x4, x0, 7
    bne  x3, x4, bne_taken2   # taken
    addi x5, x0, 99           # must be flushed
bne_taken2:
    addi x10, x0, 100
