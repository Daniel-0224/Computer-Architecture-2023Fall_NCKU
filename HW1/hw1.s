.data
    data_1: .dword 0x0000000000000001
    data_2: .dword 0x8000000000000000
    data_3: .dword 0x0012345678057800
.text

main:
    la a0, data_1
    mv t0, a0
    jal ra, ctz

ctz:
    lw s0, 0(t0) #data's high 32bits in s0
    lw s1, 4(t0) #data's low 32bits in s1
    
    
    
