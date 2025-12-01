# Control: jal control hazard
test:
    jal  x1, target           # x1 = return address; jump to target

    addi x2, x0, 99           # must be flushed
target:
    addi x3, x0, 1            # executes
