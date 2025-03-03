%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int op = 0, i;
float a, b;

void digi();  // Function prototype
%}

digit   [0-9]+(\.[0-9]+)?
add     "+"
sub     "-"
mul     "*"
div     "/"
pow     "^"
ln      "\n"
sin     "sin"
cos     "cos"
tan     "tan"
cosec   "cosec"
sec     "sec"
cot     "cot"

%%

{digit}   {digi(); }
{add}     {op = 1; }
{sub}     {op = 2; }
{mul}     {op = 3; }
{div}     {op = 4; }
{pow}     {op = 5; }
{ln}      {printf("\nThe Answer: %f\n\n", a); }
{sin}     {op = 6; }
{cos}     {op = 7; }
{tan}     {op = 8; }
{cosec}   {op = 9; }
{sec}     {op = 10; }
{cot}     {op = 11; }

%%

void digi()
{
    if (op == 0) {
        // atof() converts the ASCII input to a float
        a = atof(yytext);
    } else {
        if (op >= 6 && op <= 11) {
            // Apply the appropriate trigonometric function
            float angle = atof(yytext);
            angle = angle * (M_PI / 180); // Convert to radians

            switch (op) {
            case 6: a = sin(angle); break;
            case 7: a = cos(angle); break;
            case 8: a = tan(angle); break;
            case 9: a = 1 / sin(angle); break;
            case 10: a = 1 / cos(angle); break;
            case 11: a = 1 / tan(angle); break;
            }

            printf("\nThe Answer: %f\n\n", a);
            op = 0; // Reset operator after trigonometric operation
            return;
        }

        b = atof(yytext);

        switch (op) {
        case 1: a = a + b; break;
        case 2: a = a - b; break;
        case 3: a = a * b; break;
        case 4:
            if (b != 0) {
                a = a / b;
            } else {
                printf("Error: Division by zero\n");
                a = 0; // Reset to avoid unexpected results
            }
            break;
        case 5:
            a = pow(a, b);
            break;
        }

        op = 0; // Reset operator after each operation
    }
}

int main(int argc, char *argv[])
{
    printf("Available operations- +,-,*,/,^,sin,cos,tan,cosec,sec,cot\n");
    printf("Enter the mathematical expression you want to compute:");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
