// LaNier, Robert
// CSC 250
// a2

#include <stdio.h>
#include <string.h>

#define SIZE 500

int getUserChoice();
int getShift();
void getString(char buf[]);
void encrypt(char buf[], int shift);
void decrypt(char buf[], int shift);

int main()
{
    char buf[SIZE];
    //int shiftVal = 3;
    int shift    = 3;
    int option   = 1;
    int str      = 0;
    int i        = 0;

    while( option <= 4 && option >=1)
    {
        option = getUserChoice();
        switch (option)
        {
            case 1:
                shift = getShift();
                if(shift != 4 || shift != 3 || shift != 2 || shift != 1)
                {
                    printf("Invalid entry!\n");
                }
                option = 0;
                break;

            case 2:
                getString(buf);
                encrypt(buf, shift);
                break;

            case 3:
                getString(buf);
                decrypt(buf, shift);
                break;

            case 4:
                printf("Good bye\n");
                option = 0;
                break;

            default:
                printf("Error invalid option, please try again.\n");
                break;
        }
    }

    return 0;
}

int getUserChoice()
{
    int option;

    printf("-------------------------------\n");
    printf("| 1) Change Shift (default 3) |\n");
    printf("| 2) Encrypt a message        |\n");
    printf("| 3) Decrypt a message        |\n");
    printf("| 4) Quit                     |\n");
    printf("-------------------------------\n");

    printf("Option: ");
    scanf("%d", &option);

    return option;
}

int getShift()
{
    int shiftVal = 0;

    printf("Enter new shift value (4 or less): ");
    scanf("%d", &shiftVal);

    while( shiftVal <= 4 && shiftVal >=1)
    {
        switch(shiftVal)
        {
            case 1:
                return shiftVal;
                break;

            case 2:
                return shiftVal;
                break;

            case 3:
                return shiftVal;
                break;

            case 4:
                return shiftVal;
                break;

            default:
            printf("Invalid entry, please try again.\n");
        }
    }

    return 0;
}


void getString(char buf[])
{
    printf(" Input: ");
    scanf("%s", buf);
    //fgets(buf, 500, stdin);
}

void encrypt(char buf[], int
{
    int i = 0;
    int str = 0;
    str = strlen(buf);

    for( i = 0; i < str ; ++i)
    {
        buf[i] = buf[i] + shift;
    }
    printf("Output: %s\n\n", buf);
}

void decrypt(char buf[], int shift)
{
    int i = 0;
    int str = 0;
    str = strlen(buf);

    for( i = 0; i < str ; ++i)
    {
        buf[i] = buf[i] - shift;
    }
    printf("Output: %s\n\n", buf);
}