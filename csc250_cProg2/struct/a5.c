#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct properties_def
{
	char type[12];
	float cost;
	float maint;
	int bedrooms;
	int bathrooms;

	//owner values
	float totalcost;
	float totalmaint;
	int totalbdrms;
	int housesowned;
};
typedef struct properties_def rental;

int main(int argc, char *argv[])
{
	if (argc != 2)
    {
        printf("Syntax Error: ./<exec> <inFile>\n");
        exit(1);
    }	
	
	const int OWNERS = 2;
	int i, j = 0;
	int k = 0;
	int len = 0;
	int numproperties = 0;
	float totalcost = 0.00;
	float totalavgcost = 0.00;
	char buf[50];
	char string[] = "house";
	FILE *ifp = NULL;

	ifp = fopen(argv[1], "r");
	if (ifp == NULL)
	{
		printf("Could not open %s for reading\n", argv[1]);
		exit(1);
	}

	rental property[50];
	rental owner[50];

	for(i = 0; i < OWNERS; ++i)
	{
        fgets(buf, sizeof(buf), ifp);
        sscanf(buf, "%d", &numproperties);
		//printf("Number of rental properties: %d\n", numproperties);

		for(j = 0; j < numproperties; ++j)
		{
			// type of property
			fgets(property[k].type, sizeof(property[k].type), ifp);
        	len = strlen(property[k].type);
        	property[k].type[len-1] = property[k].type[len];
			//printf("Rental %d type: %s\n", k, property[k].type);
			
			if(strstr(property[k].type, "house") != 0)
			{
				++owner[i].housesowned;
				//printf("house found\n");
			}

        	// monthly rental cost
        	fgets(buf, sizeof(buf), ifp);
        	sscanf(buf, "%f", &property[k].cost);
        	//printf("Rental %d cost: %.2f\n", k, property[k].cost);

        	// monthly maintenance cost
        	fgets(buf, sizeof(buf), ifp);
        	sscanf(buf, "%f", &property[k].maint);
        	//printf("Maint %d cost: %.2f\n", k, property[k].maint);

        	// number of bedrooms
        	fgets(buf, sizeof(buf), ifp);
        	sscanf(buf, "%d", &property[k].bedrooms);
        	//printf("Rental %d bedrooms: %d\n", k, property[k].bedrooms);

        	// number of bathrooms
        	fgets(buf, sizeof(buf), ifp);
        	sscanf(buf, "%d", &property[k].bathrooms);
        	//printf("Rental %d bathrooms: %d\n", k, property[k].bathrooms);
			
			owner[i].totalcost += property[k].cost;
			totalcost += property[k].cost;
			owner[i].totalmaint += property[k].maint;
			owner[i].totalbdrms += property[k].bedrooms;

			++k;
        }
		
		//printf("Total cost of properties: $%.2f\n", totalcost);
		//totalavgcost = totalcost/k;


		//printf("Owner %d total cost: $%.2f\n", i+1, owner[i].totalcost);
		//printf("Owner %d total maintenance cost: $%.2f\n", i+1, owner[i].totalmaint);
		//printf("Owner %d average price per bedroom: $%.2f\n", i+1, (owner[i].totalcost/owner[i].totalbdrms));
		//printf("Owner %d owns %d houses.\n", i+1, owner[i].housesowned);
		//printf("Average price of all properties: $%.2f\n\n", totalavgcost);
	}
		//printf("Total cost of properties: $%.2f\n", totalcost);
		totalavgcost = totalcost/k;
		
		printf("Total income Owner1: $%.2f\n", owner[0].totalcost);
		printf("Total cost Owner2: $%.2f\n", owner[1].totalmaint);
		printf("Average price per bedroom Owner1: $%.2f\n", (owner[0].totalcost/owner[0].totalbdrms));
		printf("Average price per bedroom Owner2: $%.2f\n", (owner[1].totalcost/owner[1].totalbdrms));
		printf("# of Houses Owner1: %d\n", owner[0].housesowned);
		printf("# of Houses Owner2: %d\n", owner[1].housesowned);
		printf("Average price of all properties: $%.2f\n", totalavgcost);

	fclose(ifp);

	return 0;
}
