#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// functions
void printArr (int theArr[], int numArray)
{
	int i = 0;
	for (i = 0; i < numArray; ++i)
	{
		printf("%4d   | %4d\n", i, theArr[i]);
	}
}

void initArr(int theArr[], int numArray)
{
	int i = 0;
	for (i = 0; i < numArray; ++i)
	{
		theArr[i] = 0;
	}
}

int arrayMin(int theArr[], int numArray) //int pos[])
{
	int i = 0;
	int min = 0;
	min = theArr[0];
	for (i = 0; i < numArray; ++i)
	{
		if (theArr[i] < min )
		{
			min = theArr[i];
			//pos[0] = i;
		}
	}
	return min;
}

int arrayMax(int theArr[], int numArray) //int pos[])
{
	int i = 0;
	int max = 0;
    max = theArr[0];
    for (i = 0; i < numArray; ++i)
    {
        if (theArr[i] > max )
        {
            max = theArr[i];
			//pos[1] = i;
        }
    }
	return max;
}

int genNum( int num )
{
	num = rand() % 1001;
	return num;
}

int arraySum( int theArr[], int numArray)
{
	int i = 0;
	int sum = 0;
	for (i = 0; i < numArray; ++i)
	{
		sum = sum + theArr[i];
	}

	return sum;
}

int main()
{
	// declare vars
	int numArray = 0;
	int i = 0;
	int min = 0;
	int max = 0;
	int pos[2] = {0};
	int sum = 0;
	int avg = 0;

	// input
	printf("Enter an integer: ");
	scanf("%d", &numArray);

	// create & initialize the array with all 0;
	int theArr[numArray];
	initArr(theArr, numArray);

	// generate random numbers into the array
	srand( time ( NULL ));
	for ( i = 0; i < numArray; ++i)
	{
		theArr[i] = genNum(0);
	}

	// find the min, max, sum, and avg numbers in the array
	min = arrayMin(theArr, numArray);
	max = arrayMax(theArr, numArray);
	sum = arraySum(theArr, numArray);
	avg = sum / numArray;

	// output
	printf("min:    %3d pos:  %2d\n", min, pos[0]);
    printf("max:    %3d pos:  %2d\n", max, pos[1]);
	
	printf("sum:  %5d\n", sum);
	printf("avg:  %5d\n\n", avg);

	printf(" Pos   |  Val\n");
	printf("-------------\n");
	
	printArr(theArr, numArray);

	return 0;
}
