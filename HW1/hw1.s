.data
    data_1: .word 0x00000000
    data_2: .word 0x00000001
    data_3: .word 0x80000000
    data_4: .word 0x00000000
    data_5: .word 0x00123456
    data_6: .word 0x78057800
.text

main:
    lw a0, data_2 # a0 = low 32bits of input
    lw a1, data_1 # a1 = high 32bits of input
    jal ra, count_tailing_zeros
    
count_tailing_zeros:
    slt t0, a0, 1 # do input -1
    sub a2, a0, 1
    sub a3, a1, t0

    
