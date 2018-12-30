#include <stdio.h>

int main()
{
    // declare vars

    int radius, radiusSqed, sqPeri;
    float pi, cirArea, cirPeri;

    // read user input

    printf("Please help me compute the area and perimeter of a circle.\n");
    printf("I will also give you the area and perimeter of a square =^.^=\n\n");

    printf("Please enter an integer for the radius of a circle: ");
    scanf("%d", &radius);

    // compute values

    pi = 3.14;
    cirPeri = 2 * pi * radius;
    radiusSqed = radius * radius;
    cirArea = pi * radiusSqed;
    sqPeri = radius * 4;

    // display user output

    printf("\nThe perimeter of a circle is %.2f and the area of the same circle is %.2f.\n", cirPeri, cirArea);
    printf("The perimeter of the square is %d and the area of the same square is %d.\n\n", sqPeri, radiusSqed);
    printf("Thanks for helping me compute the area and perimeter of this circle!\n");
    printf("I hope you enjoyed the bonus square information =^.^=\n");

    return 0;
}

