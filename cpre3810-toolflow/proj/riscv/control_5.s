# Control: bltu control hazard (unsigned)
test:
    # Not taken (unsigned)
    li   x1, -1               # 0xFFFFFFFF
    li   x2, 1
    bltu x1, x2, bltu_taken1  # 0xFFFFFFFF < 1 ? no
    addi x3, x0, 14           # must execute
bltu_taken1:
    # Taken
    addi x4, x0, 1
    li   x5, -1               # 0xFFFFFFFF
    bltu x4, x5, bltu_taken2  # 1 < 0xFFFFFFFF -> taken
    addi x6, x0, 99           # must be flushed
bltu_taken2:
    addi x10, x0, 100
