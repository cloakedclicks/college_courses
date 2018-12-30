#include <stdio.h>

int main()
{

    int count;
    int count1;
    int num;
    int num1;
    int sum;
    int sum1;
    int total;
    int total1;

    sum = 0;

    printf("How high do you want to count up to first: ");
    scanf("%d", &count);


    num = 1;

    while ( num <= count  )
    {
        printf("%d ", num);
        num = num + 3;
        sum = sum + num;
        total = sum - count;
    }

    printf("\nThe first sum is %d\n", total);

    sum1 = 0;

    printf("How high do you want to count up to second: ");
    scanf("%d", &count1);

    num1 = 1;

    for ( num1 = 1 ; num1 <= count1 ; num1 = num1 + 3 )
    {
        printf("%d ", num1);
        sum1 = sum1 + num1;
    }
    printf("\nThe second sum is %d\n", sum1);


    return 0;
}
