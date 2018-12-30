#include <stdio.h>
#include <stdlib.h>

int main()
{
	int d1;    // dice 1
	int d2;    // dice 2
	int s;     // seed value
	int n;     // number of rolls
	int c;	   // count
	int dubs;  // doubles
	int sum;

	dubs = 0;
	sum = 0;

	printf("Enter a number: ");
	scanf("%d", &s);

	printf("Enter the number of dice rolls: ");
	scanf("%d", &n);

	srand( s );

	for ( c = 1 ; c <= n ; c = c + 1 )
	{
		d1 = rand() % 10 + 1;
		d2 = rand() % 10 + 1;

		if ( n <= 10 )
		{
			printf("\nRolled %d\n", d1);
			printf(" Rolled %d\n", d2);
		}

		if ( d1 == d2 )
		{
			printf("You rolled doubles!\n");
			dubs = dubs + 1;
		}

		if ( d1 + d2  == 15 )
		{
			printf("You rolled lucky number 15!\n");
			sum = sum + 1;
		}

	}
	printf("\nDoubles rolled: %d\n", dubs);
	printf("Lucky number 15 rolled: %d\n", sum);

	return 0;
}
