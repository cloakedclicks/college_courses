#include <stdio.h>

int main()
{
	// declare vars

	int quantity;
	float price, subtotal;
	float  tax, total;

	// read user input

	printf("Welcome to Simple Cash Register 2000!\n");
	printf("Price for single item please: $");
	scanf("%f", &price);
	printf("How many would you like to purchase: ");
	scanf("%d", &quantity);

	// compute values

	subtotal = price * quantity;
	tax = subtotal * 0.06; 
	total = subtotal + tax;

	// display output

	printf("Your subtotal is $%.2f plus $%.2f tax\n", subtotal, tax);
	printf("Your total amount due for your purchase is $%.2f\n", total);

	return 0;
}
