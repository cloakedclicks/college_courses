#include <stdio.h>
#include <stdlib.h>

void getStudents(FILE *ifp, int cols, char students[][15]);
void getGrades(FILE *ifp, char students[][15], int rows, int cols, int grades[rows][cols]);
void printStudents(int cols, char students[][15]);
void printGrades(int rows, int cols, int grades[rows][cols]);
void calcGrades(int rows, int cols, int grades[rows][cols], char Fgrades[]);
void printFinalGrades(int cols, char Fgrades[]);

int main(int argc, char *argv[])
{
    if (argc != 2)
	{
		printf("Syntax Error: ./<exec> <inFile>\n");
		exit(1);
	}
	
	FILE *ifp = NULL;
	int rows = 0; // number of assignments
    int cols = 0;  // number of students

	ifp = fopen(argv[1], "r");
	if (ifp == NULL)
	{
		printf("Could not open %s for reading\n", argv[1]);
		exit(1);
	}

    fscanf(ifp, "%d", &cols);
    fscanf(ifp, "%d", &rows);
    
	char students[cols][15];
	int grades[rows][cols];
	char finalGrade[cols];

	// Used for testing rows and cols values
	//printf("cols is %d\n", cols);
	//printf("rows is %d\n", rows);

    getStudents(ifp, cols, students);
    getGrades(ifp, students, rows, cols, grades);
    printStudents(cols, students);
    printGrades(rows, cols, grades);
    calcGrades(rows, cols, grades, finalGrade);
    printFinalGrades(cols, finalGrade);

    return 0;
}

void getStudents(FILE *ifp, int cols, char students[][15])
{
    int j = 0;

    for (j = 0; j < cols; ++j)
        {
            fscanf(ifp, "%s", students[j]);
        }

}

void getGrades(FILE *ifp, char students[][15], int rows, int cols, int grades[rows][cols])
{
    int i = 0, j = 0;

    for (i = 0; i < rows; ++i)
        for (j = 0; j < cols; ++j)
        {
            fscanf(ifp, "%d", &grades[i][j]);
        }
    printf("\n");
}

void printStudents(int cols, char students[][15])
{
    int i = 0;
    int numStudents = cols;

    for (i = 0; i < numStudents; ++i)
        printf("%10s", students[i]);
    printf("\n");
}

void printGrades(int rows, int cols, int grades[rows][cols])
{
    int i = 0, j = 0;

    for (i = 0; i < rows; ++i)
    {
        for (j = 0; j < cols; ++j)
        {
            printf("%10d", grades[i][j]);
        }
        printf("\n");
    }
}

void calcGrades(int rows, int cols, int grades[rows][cols], char Fgrades[])
{
    int i = 0, j = 0;
    int avg = 0;
    int sum = 0;

    for (j = 0; j < cols; ++j)
    {
        sum = 0;
        for (i = 0; i < rows; ++i)
        {
            sum += grades[i][j];
        }

        avg = sum / rows;

        if (avg >= 90)
            Fgrades[j] = 'A';
        else if (avg >= 80)
            Fgrades[j] = 'B';
        else if (avg >= 70)
            Fgrades[j] = 'C';
        else if (avg >= 60)
            Fgrades[j] = 'D';
        else
            Fgrades[j] = 'F';
    }
}

void printFinalGrades(int cols, char Fgrades[])
{
    int j = 0;

    for (j = 0; j < cols; ++j)
        printf("%10c", Fgrades[j]);
    printf("\n");
}
