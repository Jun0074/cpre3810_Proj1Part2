# This test file is designed to validate all the supported 35 RISC-V instructions by our Project with Pipeline CPU.
# SW Version with NOPs inserted

.data
result: .word 0
test_data: .word 0x11223344

.text
.globl _start
_start:

# ---- BASE TEST SECTION ----
addi x1, x0, 5
addi x2, x0, 10
addi x3, x0, -3
addi x4, x0, 0

# ---- Arithmetic operations ----
addi x0, x0, 0
add x5, x1, x2
sub x6, x2, x1
slt x7, x3, x2
slti x8, x1, 8
sltiu x9, x3, 4
lui x10, 0x12345
auipc x11, 0x1

# ---- Logical operations ----
and x12, x1, x2
andi x13, x1, 12
or x14, x1, x3
ori x15, x1, 7
xor x16, x1, x2
xori x17, x2, 15

# ---- Shift operations ----
sll x18, x1, x2
slli x19, x1, 2
srl x20, x2, x1
srli x21, x2, 1
sra x22, x3, x1
srai x23, x3, 1

# ---- LOAD TESTS SECTION ----
lasw t0, test_data
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lw   t1, 0(t0)
addi x0, x0, 0       # REQUIRED NOP (load use hazard)
lb   t2, 1(t0)
lbu  t3, 1(t0)
lh   t4, 0(t0)
lhu  t5, 0(t0)

# ---- CONTROL FLOW TEST SECTION ----
lui sp, 0x7FFFF
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi sp, sp, 0xF0
addi x0, x0, 0
jal func1
addi x0, x0, 0
wfi                     # end if jal never returns

func1:
addi x0, x0, 0
addi sp, sp, -16
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
sw ra, 12(sp)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
jal branch_test
addi x0, x0, 0
addi x4, x0, 4

branch_test:
addi t0, x0, 0
addi t1, x0, 1

beq  t0, t0, L1
addi x0, x0, 0      
L1:
bne  t1, x0, L2
addi x0, x0, 0
L2:
blt  t0, t1, L3
addi x0, x0, 0
L3:
bge  t1, t0, L4
addi x0, x0, 0
L4:
bltu t0, t1, L5
addi x0, x0, 0
L5:
bgeu t1, t0, L6
addi x0, x0, 0
L6:
jalr ra, ra, 4
addi x0, x0, 0

L7:
wfi
