# Forwarding: ALU -> branch compare (forwarding, no stall)
test:
    addi x1, x0, 5
    addi x2, x0, -5
    add  x3, x1, x2         # x3 = 0

    beq  x3, x0, taken      # must use forwarded x3; no stall expected
    addi x4, x0, 1          # flushed because branch taken

taken:
    addi x5, x0, 5
