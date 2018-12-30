#include <stdio.h>

int main()
{
	// vars

	int age;
	int yrs_to_retire;

	// input

	printf("Welcome to So You Think You Can Retire?!\n");
	printf("How old are you: ");
	scanf("%d", &age);

	// compute values

	yrs_to_retire = 65 - age;

	// cond statement

	if (age >= 65) 
	{
		printf("You should already be retired, lol!\n");
	}
	else if (age <= 63)
	{
		printf("Get back to work you have %d years to retire!\n", yrs_to_retire);
	}
	else if (age = 64)
	{
		printf("Almost there just one more very long year.\n");
	}

	printf("Thanks for playing So You Think You Can Retire!\n");
	printf("Have a fabulous day!\n");

	return 0;
}
