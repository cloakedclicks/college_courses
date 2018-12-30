#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Function: rept
//  Purpose: print symbol requested number of times
//   Params: how mamny characters to display
//           symbol to print

void rept( int n, char d )
{
    int k;
    for ( k = 0; k < n; k++ )
    {
        printf("%c", d);
    }
    printf("\n");
}

void zigRept( int n, char d )
{
    int k;
    for ( k = 0; k < n; k++ )
    {
        printf("%c", d);
    }
	printf("*");
    printf("\n");
}

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

// Function: vowels
//  Purpose: determine if character is a vowel, return 1 for yes, 0 for no
//   Params: a character

int isVowel( char v )
{
    if ( v == 'a' )
        return 1;

    if ( v == 'A' )
        return 1;

    if ( v == 'e' )
        return 1;

    if ( v == 'E' )
        return 1;

    if ( v == 'i' )
        return 1;

    if ( v == 'I' )
        return 1;

    if ( v == 'o' )
        return 1;

    if ( v == 'O' )
        return 1;

    if ( v == 'u' )
        return 1;

    if ( v == 'U' )
        return 1;

    else
        return 0;
}

// Function: grades
//  Purpose: convert numeric score to letter grade, standard 90-80-70¦
//   Params: integer representing score
//           if score is outside 0 to 100 legal range, return ?

char toGrade( int g )
{
    if (( g <= 100) && ( g >= 90 ))
        return 'A';

    if (( g <= 89) && ( g >= 80 ))
        return 'B';

    if (( g <= 79) && ( g >= 70 ))
        return 'C';

    if (( g <= 69) && ( g >= 60 ))
        return 'D';

    if (( g <= 59) && ( g >= 1 ))
        return 'F';

    else
		return '?';
}

// Function: eggs
//  Purpose: how many egg cartons (dozen) can be filled 
//   Params: number of eggs

int fullCartons( int e )
{
	int c;
	int p;

	c = e / 12;
	p = e % 12;

	if ( p >= 1 )
		c = c + 1;

	return c;
}

// Function: zigzag
//  Purpose: make 1 zig-zag bump as described in video
//   Params: height of the zig

void zigzag( int h )
{

    int r;
    for ( r = 1 ; r <= h ; r++ )
	{
        zigRept( r , ' ' );
	}
    for ( r = h - 1 ; r >= 1; r-- )
	{
        zigRept( r , ' ' );
	}
}

int main()
{
	int e, f, g, s, t, z;
	int ans1, ans2, ans3;
	int vns;
	int lg;

	srand( time ( NULL ));

	// isVowel
	printf("Enter a character: ");
	scanf("%c", &t);

	vns = isVowel(t);

	printf("%c is %d\n", t, vns);

	// roll
	printf("How many sides on dice: ");
	scanf("%d", &s);

	ans1 = roll(s);
	ans2 = roll(s);
	ans3 = roll(s);

	printf("Rolled %d sided dice: %d %d %d \n", s, ans1, ans2, ans3);

	// toGrade
	printf("Enter in a grade: ");
	scanf("%d", &g);

	lg = toGrade(g);

	printf("%d is a %c\n", g, lg);

	// fullCartons
	printf("How many eggs: ");
	scanf("%d", &e);

	f = fullCartons(e);

	printf("%d fills %d cartons\n", e, f);

	// zigzag
	printf("Enter a height: ");
	scanf("%d",&z);

	zigzag(z);
 
	return 0;
}

