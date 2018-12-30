#include <stdio.h>

int main()

{
	// vars

	int age;

	// input

	printf("Today's game is called too young to drink, but old enough to vote!\n\n");
	printf("How old are you: ");
	scanf("%d%", &age);

	// compute values

	if (age < 18)
	{
		printf("Wishful thinking, but no cigar! You are too young, no drinky and no votey!\n");
	}
	else if (age <= 20)
	{
		printf("Hooray, you are voting age! Be careful who you vote for.\n");
	}
	else if (age >= 21)
	{
		printf("Lucky you, you can have a few drinks before you vote and after!\n");
	}

	printf("Hope you enjoyed Vote to Drink or Drink to Vote!\n");

	return 0;
}
