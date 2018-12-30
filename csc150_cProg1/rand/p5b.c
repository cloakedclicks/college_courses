#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
	int d;  // dice
	int n;  // number of colors
	int c;	// count

	printf("How many: ");
	scanf("%d", &n);

	srand( time(NULL) );
	c = 1;

	while ( c <= n )
	{
		d = rand() % 7 + 1;
		c = c + 1;

		if ( d == 1 )
		{
			printf("Red\n");
		}

		if ( d == 2 )
		{
			printf("Orange\n");
		}

		if ( d == 3 )
		{
			printf("Yellow\n");
		}

		if ( d == 4 )
		{
			printf("Green\n");
		}

		if ( d == 5 )
		{
			printf("Blue\n");
		}

		if ( d == 6 )
		{
			printf("Indigo\n");
		}

		if ( d == 7 )
		{
			printf("Violet\n");
		}

	}

	return 0;
}
