#include <stdio.h>
#include <string.h>
#define MAX 1000

int _sumAndPrintList(int *list, int length);

int main () 
{
    int numArray[MAX];
    int i, length, num, sum = 0;

    printf("Enter in a list of numbers separated by spaces to stop enter 0: ");
    for (i = 0; i < MAX; i++)
    {
        scanf("%d", &num);
        if ( feof(stdin) ) 
        {
            break;
        }
        else if (num < 0 || num > 0)
        {
            numArray[i] = num;
            length = i + 1;
        }
        else
        {
            break;
        }
    }
    
    sum = _sumAndPrintList(numArray, length);
    
    printf("The sum of the array of numbers is %d!", sum);
    
    /*printf("%d\n\n", length);
    
    for (i = 0; i < length; i++)
    {
        printf("%d\n", numArray[i]);
    }*/

    return 0;
}
