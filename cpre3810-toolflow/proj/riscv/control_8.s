# Control: jalr control hazard
test:
    auipc x4, 0
    addi  x4, x4, 16          # x4 ~ address of target
    jalr  x1, x4, 0           # x1 = return address, jump to target

    addi x5, x0, 99           # must be flushed
target:
    addi x6, x0, 2            # executes
