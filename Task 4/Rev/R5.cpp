#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    char a[4096], b[4096], c[4096];

    scanf("%s%s", a, b);
    int k;
    scanf("%d", &k);

    for (int h = 0; h < k; h++) {
        scanf("%s", c);
        int len = strlen(c);
        int a_len = strlen(a);
        if (strlen(a) == strlen(b)) {

            for (int i = 0; i < len; i++) {
                for (int j = 0; j < a_len; j++) {
                    if (a[j] == c[i]) {
                        c[i] = b[j];
                        break;
                    }
                }
            }
            printf("%s", c);
            if (h + 1 < k)
                printf("\n");
        }
    }
    return 0;
}