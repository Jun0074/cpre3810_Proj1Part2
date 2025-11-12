# ===========================================================
# Proj1_mergesort.s  (fixed)
# Bottom-up iterative mergesort for minimal RV32I
# ===========================================================

.data
N:      .word 8
array:  .word 7, 2, 9, 1, 6, 3, 8, 5
temp:   .space 32

.text
.globl _start

_start:
lui x2, 0x7FFFF
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, 0xF0

la x5, N
addi x0, x0, 0
addi x0, x0, 0
lw x10, 0(x5)            # N
la x11, array            # base A
la x12, temp             # base TMP

addi x13, x0, 1          # curr_size = 1

outer_loop:
blt x13, x10, merge_pass
addi x0, x0, 0
addi x0, x0, 0
jal x0, exit
addi x0, x0, 0
addi x0, x0, 0

merge_pass:
addi x14, x0, 0          # left_start = 0

merge_loop:
addi x15, x10, -1
addi x0, x0, 0
addi x0, x0, 0
bge x14, x15, inc_size   # if left_start >= N-1 => next pass
addi x0, x0, 0
addi x0, x0, 0

# mid = min(left_start + curr_size - 1, N-1)
add x16, x14, x13
addi x0, x0, 0
addi x0, x0, 0
addi x16, x16, -1
addi x18, x10, -1
addi x0, x0, 0
addi x0, x0, 0
blt x16, x18, mid_ok
addi x0, x0, 0
addi x0, x0, 0
add x16, x18, x0
mid_ok:

# right_end = min(left_start + 2*curr_size - 1, N-1)
slli x17, x13, 1
addi x0, x0, 0
addi x0, x0, 0
add x17, x17, x14
addi x0, x0, 0
addi x0, x0, 0
addi x17, x17, -1
addi x0, x0, 0
addi x0, x0, 0
blt x17, x18, keep_re
addi x0, x0, 0
addi x0, x0, 0
add x17, x18, x0
keep_re:

# call merge(A, left_start, mid, right_end)
jal x1, merge
addi x0, x0, 0
addi x0, x0, 0

# left_start += 2*curr_size
slli x19, x13, 1
addi x0, x0, 0
addi x0, x0, 0
add x14, x14, x19
jal x0, merge_loop
addi x0, x0, 0
addi x0, x0, 0

inc_size:
slli x13, x13, 1
jal x0, outer_loop
addi x0, x0, 0
addi x0, x0, 0

# ----------------------------------------------------------
# merge: merges A[left..mid] and A[mid+1..right] into TMP
# uses: x20=i, x21=j, x22=k, x6=mid+1, x7=right+1
# ----------------------------------------------------------
merge:
add x20, x14, x0         # i = left
addi x21, x16, 1         # j = mid+1
addi x22, x0, 0          # k = 0
addi x6,  x16, 1         # mid+1
addi x7,  x17, 1         # right+1

merge_loop_main:
# if i > mid -> copy_right
blt x20, x6, check_j1
addi x0, x0, 0
addi x0, x0, 0
jal x0, copy_right
addi x0, x0, 0
addi x0, x0, 0

check_j1:
# if j > right -> copy_left
blt x21, x7, compare_ok
addi x0, x0, 0
addi x0, x0, 0
jal x0, copy_left
addi x0, x0, 0
addi x0, x0, 0

compare_ok:
# load A[i]
slli x23, x20, 2
addi x0, x0, 0
addi x0, x0, 0
add x23, x11, x23
addi x0, x0, 0
addi x0, x0, 0
lw x24, 0(x23)
# load A[j]
slli x25, x21, 2
addi x0, x0, 0
addi x0, x0, 0
add x25, x11, x25
addi x0, x0, 0
addi x0, x0, 0
lw x26, 0(x25)
# if A[j] < A[i] take_right
blt x26, x24, take_right
addi x0, x0, 0
addi x0, x0, 0
# write A[i] -> TMP[k]
slli x27, x22, 2
addi x0, x0, 0
addi x0, x0, 0
add x27, x12, x27
addi x0, x0, 0
addi x0, x0, 0
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal x0, merge_loop_main
addi x0, x0, 0
addi x0, x0, 0

take_right:
slli x27, x22, 2
addi x0, x0, 0
addi x0, x0, 0
add x27, x12, x27
addi x0, x0, 0
addi x0, x0, 0
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal x0, merge_loop_main
addi x0, x0, 0
addi x0, x0, 0

# copy remaining left while i <= mid  (i < mid+1)
copy_left:
blt x20, x6, copy_left_do
addi x0, x0, 0
addi x0, x0, 0
jal x0, copy_back
addi x0, x0, 0
addi x0, x0, 0

copy_left_do:
slli x23, x20, 2
addi x0, x0, 0
addi x0, x0, 0
add x23, x11, x23
addi x0, x0, 0
addi x0, x0, 0
lw x24, 0(x23)
slli x27, x22, 2
addi x0, x0, 0
addi x0, x0, 0
add x27, x12, x27
addi x0, x0, 0
addi x0, x0, 0
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal x0, copy_left
addi x0, x0, 0
addi x0, x0, 0

# copy remaining right while j <= right (j < right+1)
copy_right:
blt x21, x7, copy_right_do
addi x0, x0, 0
addi x0, x0, 0
jal x0, copy_back
addi x0, x0, 0
addi x0, x0, 0

copy_right_do:
slli x25, x21, 2
addi x0, x0, 0
addi x0, x0, 0
add x25, x11, x25
addi x0, x0, 0
addi x0, x0, 0
lw x26, 0(x25)
slli x27, x22, 2
addi x0, x0, 0
addi x0, x0, 0
add x27, x12, x27
addi x0, x0, 0
addi x0, x0, 0
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal x0, copy_right
addi x0, x0, 0

# copy TMP[0..k-1] back to A[left..left+k-1]
copy_back:
addi x28, x0, 0
copy_back_loop:
addi x0, x0, 0
addi x0, x0, 0
slt x29, x28, x22
addi x0, x0, 0
addi x0, x0, 0
beq x29, x0, merge_return
addi x0, x0, 0
addi x0, x0, 0
slli x30, x28, 2
addi x0, x0, 0
addi x0, x0, 0
add x30, x12, x30
addi x0, x0, 0
addi x0, x0, 0
lw x31, 0(x30)
add x30, x14, x28
addi x0, x0, 0
addi x0, x0, 0
slli x30, x30, 2
addi x0, x0, 0
addi x0, x0, 0
add x30, x11, x30
addi x0, x0, 0
addi x0, x0, 0
sw x31, 0(x30)
addi x28, x28, 1
jal x0, copy_back_loop
addi x0, x0, 0
addi x0, x0, 0

merge_return:
jalr x0, x1, 0          # return
addi x0, x0, 0
addi x0, x0, 0

exit:
wfi

