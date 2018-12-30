#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
	int numGen = 7;
	int theArr[numGen];
	int i = 0;

	// initialize the array with all 0;
	for (i = 0; i < numGen; ++i)
	{
		theArr[i] = 0;
	}

	// print the array indexes and values
	for (i = 0; i < numGen; ++i)
	{
		printf("Index: %3d Value: %3d\n", i, theArr[i]);
	}

	return 0;
}
