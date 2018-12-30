#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    int a;
	int b;
    int c;

	srand( time(NULL ) );

    for ( a = 1; a <= 7; a = a + 1)
    {
        b = rand() % 15 + 1;
        printf("%2d ", b);

		if ( b % 2 == 0 )
		{
			for (c = 1; c <= b; c = c +1 )
				printf("@");
		}

		else
		{
			for (c = 1; c <= b; c = c +1 )
				printf("=");
		}

		printf("\n");

    }

    return 0;
}

