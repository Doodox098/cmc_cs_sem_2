#include <stdio.h>

int main(void) {
    int n, a, b;
    b = 1;
    a = 0;
    scanf("%d", &n);
    while(n > 0){
        a = a +  2 * b;
        b = a - b;
        a = a - b;
        n--;
    }
    printf("%d", a);
    return 0;
}
