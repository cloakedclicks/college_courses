#include <stdio.h>
#include <stdlib.h>

void getStudents(int cols, char classes[][15]);
void getGrades(char classes[][15], int rows, int cols, int grades[rows][cols]);
void printClasses(int cols, char classes[][15]);
void printGrades(int rows, int cols, int grades[rows][cols]);
void calcGrades(int rows, int cols, int grades[rows][cols], char Fgrades[]);
void printFinalGrades(int cols, char Fgrades[]);

int main()
{
    int rows = 0; // number of assignments
    int cols = 0;  // number of students

    char classes[cols][15];

    printf("How many students? ");
    scanf("%d", &cols);

    printf("How many assignments? ");
    scanf("%d", &rows);

    int grades[rows][cols];
    char finalGrade[cols];

    getStudents(cols, classes);
    getGrades(classes, rows, cols, grades);
    printClasses(cols, classes);
    printGrades(rows, cols, grades);
    calcGrades(rows, cols, grades, finalGrade);
    printFinalGrades(cols, finalGrade);

    return 0;
}

void getStudents(int cols, char classes[][15])
{
    int j = 0;

    for (j = 0; j < cols; ++j)
        {
            printf("Enter name for Student %d: ", j);
            scanf("%s", classes[j]);
        }

}

void getGrades(char classes[][15], int rows, int cols, int grades[rows][cols])
{
    int i = 0, j = 0;

    for (i = 0; i < rows; ++i)
        for (j = 0; j < cols; ++j)
        {
            printf("Enter grade for Assignment %d for %s: ", i, classes[j]);
            scanf("%d", &grades[i][j]);
        }
    printf("\n");
}

void printClasses(int cols, char classes[][15])
{
    int i = 0;
    int numClasses = cols;

    for (i = 0; i < numClasses; ++i)
        printf("%10s", classes[i]);
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
