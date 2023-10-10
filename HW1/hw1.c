#include <stdint.h>
#include <stdio.h>

uint32_t x0 = 0x00000001;
uint32_t x1 = 0x80000000;
uint32_t x2 = 0x01234580;


uint16_t count_leading_zeros(uint32_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x55555555);
    x = ((x >> 2) & 0x33333333) + (x & 0x33333333);
    x = ((x >> 4) + x) & 0x0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);

    return (32 - (x & 0x3f));
}

int count_tailing_zeros(uint32_t x)
{
    x = ((x - 1) & (~x));
    int num = count_leading_zeros(x);
    
    return (32 - num);
}

int main()
{
    printf("%d\n",count_tailing_zeros(x0));
    printf("%d\n",count_tailing_zeros(x1));
    printf("%d\n",count_tailing_zeros(x2));
    
    return 0;
}
