#include <stdio.h>

int main(void) {
    unsigned int a;
    int k = 32;
    scanf("%d", &a);
    while(a > 0){
        if(a % 2)k--;
        a /= 2;
    }
    printf("%u", k);
    return 0;
}
