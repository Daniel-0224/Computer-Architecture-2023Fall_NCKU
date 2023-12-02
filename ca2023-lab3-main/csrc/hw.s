.data
    #test case 1
    x1: .word 16
    y1: .word 12
    #test case 2
    x2: .word 25
    y2: .word 800
    #test case 3
    x3: .word 956
    y3: .word 85 
    string1: .string  "\nshould keep zeros:"

.text
.globl main
main:
    nop
    addi t0,t0,1
    addi sp, sp, -4
    sw t0,0(sp)
    addi t5, zero, 3
    
    la a0, string1
    li a7, 4
    ecall
    
    addi t0,t0,-2
    blt t0, zero, firstx
    beq t0, zero, secondx
    bge t0, zero, thirdx
    
firstx:
    #read x
    lw a0, x1         
    #call func                  
    jal ra, count_leading_zeros
    #store in s1
    sw a0, 0(s1)
    
firsty: 
    #read y
    lw a0, y1    
    #call func              
    jal ra, count_leading_zeros
    jal ra, calcu
    
secondx:
    #read x
    lw a0, x2         
    #call func                  
    jal ra, count_leading_zeros
    #store in s1
    sw a0, 0(s1)
    
secondy: 
    #read y
    lw a0, y2    
    #call func              
    jal ra, count_leading_zeros
    jal ra, calcu
    
thirdx:
    #read x
    lw a0, x3         
    #call func                  
    jal ra, count_leading_zeros
    #store in s1
    sw a0, 0(s1)
    
thirdy: 
    #read y
    lw a0, y3    
    #call func              
    jal ra, count_leading_zeros
    jal ra, calcu
    
calcu:
    #load s1 to t0
    lw t0, 0(s1)
    blt a0, t0, no
    
    #a0>t0
    sub a0, a0, t0
    li a7, 1
    ecall
    jal ra, restore
    
    #t0>a0
no:
    sub a0, t0, a0
    li a7, 1
    ecall
    jal ra, restore

restore:
    lw t0,0(sp)
    addi sp, sp, 4
    beq t0, t5, exit
    jal ra, main
    
exit:
    li a7, 10
    ecall

count_leading_zeros:
    srli t0, a0, 1        # t0: x >> 1
    or a0, a0, t0         # a0: x |= (x >> 1)
    
    srli t0, a0, 2        # t0: x >> 2
    or a0, a0, t0
    
    srli t0, a0, 4        # t0: x >> 4
    or a0, a0, t0
    
    srli t0, a0, 8        # t0: x >> 8
    or a0, a0, t0
    
    srli t0, a0, 16       # t0: x >> 16
    or a0, a0, t0
count_ones:
    srai t0, a0, 1        # t0: x >> 1
    lui t1, 0x55555       # t1: 0x55555555
    ori t1, t1, 0x555
    and t0, t0, t1        # t0: (x >> 1) & 0x55555555
    sub a0, a0, t0
    
    srai t0, a0, 2        # t0: x >> 2
    lui t1, 0x33333       # t1: 0x33333333
    ori t1, t1, 0x333
    and t0, t0, t1        # t0: (x >> 2) & 0x33333333
    and t4, a0, t1        # t4: x & 0x33333333
    add a0, t0, t4
    
    srai t0, a0, 4        # t0: x >> 4
    add t0, t0, a0        # t0: (x >> 4) + x
    lui t1, 0x0f0f0       # t1: 0x0f0f0f0f
    ori t1, t1, 0x787
    addi t1, t1, 0x788
    and a0, t0, t1        # a0: ((x >> 4) + x) & 0x0f0f0f0f
    
    srai t0, a0, 8        # t0: x >> 8
    add a0, a0, t0
    
    srai t0, a0, 16       # t0: x >> 16
    add a0, a0, t0
    
    andi t0, a0, 0x7f     # t0: x & 0x7f
    addi t1, x0, 32       # t1: 32
    sub  a0, t1, t0       # a0: return (32 - (x & 0x7f))
    ret
