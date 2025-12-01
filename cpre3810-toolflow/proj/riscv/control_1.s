# Control: beq control hazard
test:
    # Not taken
    addi x1, x0, 1
    beq  x1, x0, beq_taken1   # not taken
    addi x2, x0, 10           # must execute
beq_taken1:
    # Taken
    addi x3, x0, 0
    beq  x3, x0, beq_taken2   # taken
    addi x4, x0, 99           # must be flushed
beq_taken2:
    addi x5, x0, 5
