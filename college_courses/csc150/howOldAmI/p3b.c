#include <stdio.h>

int main()
{
	int age;
	int manyAges;
	int minors;
	int retired;

	manyAges = 0;
	minors = 0;
	retired = 0;

	while ( age >= 0 )
	{
		printf("How old are you: ");
		scanf("%d", &age);
		manyAges = manyAges + 1;

		if ( age <= 17)
		{
			printf("You are a minor.\n");
			minors = minors + 1;
		}

		if ( age >= 65 )
		{
			printf("You could be retired.\n");
			retired = retired + 1;
		}
	}

	printf("Asked ages %d times.\n", manyAges);
	printf("Total minors %d.\n", minors);
	printf("Total people that could be retired %d.\n", retired);

	return 0;
}
