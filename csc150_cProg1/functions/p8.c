#include <stdio.h>
#include <stdlib.h>

// Function: dice
//  Purpose: roll a dice, return the value
//   Params: how many sides on the dice
//           If # of sides is outside 1 to 50 range, return 4

int roll( int s )
{
    int c,d;

    d = rand() % s + 1;

    if ( s < 1 )
        return 4;

    if ( s > 50 )
        return 4;

    else
        return d;
}

int main()
{

	int a,b,c,d,k;
	int sum;
	int A[50];

	srand( 4 );

	// read all number into array
	for ( k = 0; k < 50; ++k )
   		 A[k] = roll(10);

    // find the sum
    sum = 0;
    for (k = 0; k < 50; ++k )
        sum = sum + A[k];

	// how many 7's are rolled
	a = 0;
    for ( k = 0; k < 50; ++k )
    {
        b = A[k];

        if ( b == 7 )
        {
            a = a + 1;
        }
	}

	// how many times are 2 consecutive numbers the same
	c = 0;
	for ( k = 0; k <= 48 ; ++k )
    {
        d = A[k];

        if ( d == A[k+1] )
        {
            c = c + 1;
        }
    }

	// print on output
	for ( k = 0; k < 3; ++k )
    	printf("%2d\n", A[k]);

	printf("Sum of rolls:  %3d\n", sum);

    printf("Sevens rolled: %3d\n", a);

	printf("Consecutive rolls matched: %d\n", c);

	return 0;
}
