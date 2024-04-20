#include <stdio.h>

int main(void) {
    int n, k;
    scanf("%d %d", &n, &k);
    int a[21] = {0};
    int b[21] = {0};
    int *pr = a;
    int *cr = b;
    int *sw;
    pr[0] = 1;
    int j, i = 0;
    while(i < n){
        i++;
        cr[0] = 1;
        j = 0;
        while(j < i){
            j++;
            cr[j] = pr[j] + pr[j - 1];
        }
        cr[j] = 1;
        sw = pr;
        pr = cr;
        cr = sw;
    }
    j = pr[k];
    printf("%d", j);
    return 0;
}
