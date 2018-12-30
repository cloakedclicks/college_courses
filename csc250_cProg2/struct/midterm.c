#include <stdio.h>
#include <stdlib.h>

#define N 10  // Do NOT change this line!

/*
	Structure definition should go here.
*/
struct point2d_def
{
	int x;
	int y;
};
typedef struct point2d_def point2d;

void fill(char str[], point2d P[])
{
/*
	This function opens and reads from the input file.  You 
	should close the file when you are done with it.  Read 
	the points into the array of structures in this function.

	Don't forget to check if the file name is valid.
*/
	int i = 0;
    FILE *ifp = NULL;

    ifp = fopen(str, "r");
    if (ifp == NULL)
    {
        printf("Could not open %s for reading\n", str);
        exit(1);
    }

    for (i = 0; i < N; ++i)
    {
        fscanf(ifp, "%d%d", &P[i].x, &P[i].y);
//        printf("%d: (%2d, %2d)\n", i, P[i].x, P[i].y);
    }

	fclose(ifp);
}

int getdist(point2d p, point2d q)
{
/*
	This function gets the distance between 2 points and
	returns that value.

	Yes, you need to do some math here...
*/
	int dist = 0;
	int x = 0;
	int y = 0;

	x = (p.x - q.x);
	y = (p.y - q.y);
	x *= x;
	y *= y;
	dist = x + y;
//	printf("sq(%d - %d) + sq(%d - %d) = %d\n", p.x, q.x, p.y, q.y, dist);
	return dist;
}

void closest(point2d P[], int G[2*N][2*N])
{
/*
	This function finds the 2 points that are the closest.

	You should call the getdist() function from inside here.
*/
	int i = 0;
	int j = 0;
	int p1 = 0;
	int p2 = 0;
	int dist = 0;
	int newdist = 500;

// find the 2 points that are closest
	for (i = 0; i < N; ++i)
	{
		for (j = i + 1; j < N; ++j)
		{
			dist = getdist(P[i], P[j]);
			if (dist < newdist)
			{
				newdist = dist;
				p1 = i;
				p2 = j;
			}
		}
	}

// set values in G to unique values
	G[P[p1].y][P[p1].x] = 2;
	G[P[p2].y][P[p2].x] = 2;
//	printf("G[%d][%d] and G[%d][%d] are the closest points\n", P[p1].x, P[p1].y, P[p2].x, P[p2].y);
}

void grid(point2d P[], int G[2*N][2*N])
{
/*
	This function will transfer all the points from your
	structure into a 2D array used as the grid.

	You will call the closest() function from inside here.
*/
// set G for each of the N points
	int i = 0;

	for (i = 0; i < N; ++i)
	{
		G[P[i].y][P[i].x] = 1;
	}

	closest(P, G);
}

void printpoints(char str[], point2d P[])
{
/*
	This function will print off the list of all the 
	points you have in the following form:

	num: ( x,  y)

	ex.
	0: ( 4, 1)

	** Note the spacing!

	You need to open the output file here and write to it.
*/
	int i = 0;
    FILE *ofp = NULL;

    ofp = fopen(str, "w");
    if (ofp == NULL)
    {
        printf("Could not open %s for reading\n", str);
        exit(1);
    }

    for (i = 0; i < N; ++i)
    {
        fprintf(ofp, "%d: (%2d, %2d)\n", i, P[i].x, P[i].y);
    }

	fclose(ofp);	
}

void printgridxy(char str[], int G[2*N][2*N])
{

/*
	This function will print out your 2D array (the grid)

	Use ' ' for spots without a point,
	use '*' for spots with a point,
	use 'X' for the 2 points that are closest.

	Put 1 space between each element, for example you should
	print "* " instead of just "*".


	You should also have a top and bottom made of 50 hyphens (-)

	This should be printed to the same file as the points were.
		Be careful not to overwrite the file!
*/
	int i = 0;
	int j = 0;
	FILE *ofp = NULL;

	ofp = fopen(str, "a");
	if (ofp == NULL)
	{
		printf("Could not open %s for reading\n", str);
		exit(1);
	}

	fprintf(ofp, "--------------------------------------------------\n");

	for ( i = 19; i >= 0; --i)
	{
		for (j = 0; j < 2 * N; ++j)
		{
			if (G[i][j] == 1)
			{
				fprintf(ofp, "* ");
			}
			else if (G[i][j] == 0)
			{
				fprintf(ofp, "  ");
			}
			else if (G[i][j] == 2)
			{
				fprintf(ofp, "X ");
			}
		}
	
		fprintf(ofp, "\n");
	}

	fprintf(ofp, "--------------------------------------------------\n");

	fclose(ofp);
}


int main(int argc, char *argv[])
{
/*
	Do not change anything in main!  Also do not change the #define
	at the top of the program.

	There is one exception to this, you may change the "type" for the
	structure you made if you don't use my naming scheme.
*/
	if (argc != 3)
	{
		printf("Syntax Error: ./a.out <infile> <outfile>\n");
		exit(1);
	}

	point2d P[N];  //  <-- This is the only line you are allowed to change.
	int G[2*N][2*N] = {0};

	fill(argv[1], P);
	grid(P, G);
	printpoints(argv[2], P);
	printgridxy(argv[2], G);


	return 0;
}
