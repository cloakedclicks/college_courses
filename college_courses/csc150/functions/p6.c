#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Function: rept
//  Purpose: print symbol requested number of times
// 	 Params: how mamny characters to display
//			 symbol to print

void rept( int n, char d )
{
	int k;
    for ( k = 0; k < n; k++ )
    {
        printf("%c", d);
    }
    printf("\n");
}

// Function: box
//  Purpose: diplay a box of specified dimensions
//	 Params: heigh of box ( number of rows )
//           width of the box ( number of cols on each row )

void box( int r, int c )
{
	int k;
	for ( k = 0 ; k < r; k++ )
		rept( c , '@' );
}

// Function: utri
//  Purpose: print triangle that points up
//   Params: height of triangle

void utri( int h )
{
	int r;
	for ( r = 1 ; r <= h; r++ )
		rept( r , '*' );
}

// Function: dtri
//  Purpose: print triangle that points down
//   Params: height of triangle

void dtri( int h )
{
	int r;
	for ( r = h ; r >= 1; r-- )
		rept( r , '*' );
}

// Function: barChart
//  Purpose: make a barchart similar to p5c
//   Params: how many bars to print 
//           low number of range
//           high number of range

void barChart( int bar , int lo , int hi )
{
	int a;
	int b;

	for ( a = 1; a <= bar; a = a + 1)
	{
		b = rand() % ( hi - lo + 1 ) + lo;
        printf("%2d ", b);

        if ( b % 2 == 0 )
        {
            rept( b , '@' );
        }

        else
        {
            rept( b , '=' );
        }

        printf("\n");

    }
}

int main()
{
        srand( time(NULL) );

        rept(20,'#');
        barChart( 9, 2, 11 );
        rept(20,'-');
        barChart( 4, 10, 15 );
        rept(20,'-');
        box(3, 3);
        rept(20,'-');
        box(5,7);
        rept(20,'-');
        utri(3);
        rept(20,'-');
        utri(5);
        rept(20,'-');
        dtri(3);
        rept(20,'-');
        dtri(5);
        rept(20,'#');

        return 0;
}

