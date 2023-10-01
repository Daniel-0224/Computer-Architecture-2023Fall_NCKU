#include <stdint.h>
#include <stdio.h>
uint16_t count_leading_zeros(uint64_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x5555555555555555);
    x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333);
    x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    x += (x >> 32);

    return (64 - (x & 0x7f));
}

int count_trailing_zeros(uint64_t x)
{
    x = ((x - 1) & (~x));
    int num = count_leading_zeros(x);
    
    return (64 - num);
}

int main()
{
    uint64_t x0 = 0x8000000000000011;
  
    printf("%d\n",count_trailing_zeros(x0));
    
    return 0;
}
