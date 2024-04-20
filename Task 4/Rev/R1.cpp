#include <stdio.h>

unsigned int f(unsigned int a){
    unsigned int c = 1;
    while(a > 0){
        c = c * 3;
        a--;
    }
    return c;
}

int main(void) {
    unsigned int a;
    scanf("%u", &a);
    printf("%u", f(a));
    return 0;
}
