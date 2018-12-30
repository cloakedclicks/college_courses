#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct inventory_def
{
	char name[50];
	int quantity;
	float price;
	int id;
	char date[12];
};
typedef struct inventory_def inventory;

void getInventory (FILE *ifp, int numInv, inventory database[]);
float getInvVal   (int numInv, inventory database[]);
int getTotalInv   (int numInv, inventory database[]);
void ordItem      (int numInv, inventory database[]);
void printInv     (float value, int totalInv);

int main(int argc, char *argv[])
{
	if (argc != 2)
	{
		printf("Syntax Error: ./<exec> <inFile>\n");
		exit(1);
	}

	FILE *ifp    = NULL;
	int numInv   = 0; // number of inventory items
	float value  = 0.00; // total value of inventory in $
	int totalInv = 0;

	ifp = fopen(argv[1], "r");
	if (ifp == NULL) 
	{
		printf("Could not open %s for reading\n", argv[1]);
		exit(1);
	}

	fscanf(ifp, "%d", &numInv); // get number of inventory items

	inventory database[numInv];

	getInventory(ifp, numInv, database);

	// assign inventory totals
	value = getInvVal(numInv, database);
	totalInv = getTotalInv(numInv, database);

	printInv(value, totalInv);
	ordItem(numInv, database);

	return 0;
}

void getInventory(FILE *ifp, int numInv, inventory database[])
{
	int i = 0;
	int len = 0;
	char buf[50];

	for (i = 0; i < numInv; ++i)
	{
		// get name of item
		fscanf(ifp, "%s", database[i].name);

		// get quantity of item
		fscanf(ifp, "%d", &database[i].quantity);

		// get price of item
		fscanf(ifp, "%f", &database[i].price);
		
		// get id of item
		fscanf(ifp, "%d", &database[i].id);
		
		// get date of last order
		fscanf(ifp, "%s", database[i].date);
    }
}

float getInvVal(int numInv, inventory database[])
{
	int i = 0;
	float sum = 0.00;

	for (i = 0; i < numInv; ++i)
	{
		sum += database[i].price;
	}
	return sum;
}

int getTotalInv(int numInv, inventory database[])
{
	int i = 0;
	int sum = 0;

	for (i = 0; i < numInv; ++i)
	{
		sum += database[i].quantity;
	}
	return sum;
}

void ordItem(int numInv, inventory database[])
{
	int i = 0;

	for (i = 0; i < numInv; ++i)
	{
		if ( database[i].quantity < 10 )
		{
			printf("    %s\n", database[i].name);
		}
	}
}

void printInv(float value, int totalInv)
{
	printf("Total inventory value: $%.2f\n", value);
	printf("Total inventory quantity: %d\n", totalInv);
	printf("Items that need to be ordered:\n");
}
