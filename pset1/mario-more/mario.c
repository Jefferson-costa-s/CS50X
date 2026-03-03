#include <cs50.h>
#include <stdio.h>


int main(void)
{
    int height;

    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);


    for (int row = 1; row <= height; row++)
    {

        for (int space = 0; space < height - row; space++)
        {
            printf(" ");
        }


        for (int left = 0; left < row; left++)
        {
            printf("#");
        }


        printf("  ");


        for (int right = 0; right < row; right++)
        {
            printf("#");
        }

        
        printf("\n");
    }
}
