#include <stdint.h>
#include <stdio.h>

uint16_t count_leading_zeros(uint32_t x)
{
	x |= (x >> 1);
	x |= (x >> 2);
	x |= (x >> 4);
	x |= (x >> 8);
	x |= (x >> 16);

	/* count ones (population count) */
	x -= ((x >> 1) & 0x55555555 );
	x = ((x >> 2) & 0x33333333) + (x & 0x33333333 );
	x = ((x >> 4) + x) & 0x0f0f0f0f;
	x += (x >> 8);
	x += (x >> 16);

	return (32 - (x & 0x7f));
}

int main(){
        uint32_t x1,y1,x2,y2,x3,y3;
        x1 = 16, y1 = 12, x2 = 25, y2 = 800, x3 = 956, y3 = 85;
        
        x1 = count_leading_zeros(x1);
        y1 = count_leading_zeros(y1);
        
        x2 = count_leading_zeros(x2);
        y2 = count_leading_zeros(y2);
        
        x3 = count_leading_zeros(x3);
        y3 = count_leading_zeros(y3);

        return 0;
}
