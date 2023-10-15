.data
    data_1: .word 0x00000001
    data_2: .word 0x80000000
    data_3: .word 0x12345678
.text

main:
    la t0, data_1

    #load data
    lw a0, 0(t0)
    jal ra, count_tailing_zeros
    
    #print result
    jal ra, print
    
count_tailing_zeros:
    addi sp, sp, -20
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)

    add s0, zero, a0
    # (operand-1) & (~operand)
    sub s1, s0, 1
    not s2, s0
    and s3, s1, s2

    #clz
loop:
    
    srli t0, s3, 1  # x >> 1
    or s3, s3, t0   # x |= (x >> 1)
    

    
