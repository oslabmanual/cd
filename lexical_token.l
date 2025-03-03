%{
#include <stdio.h>
#include <string.h>

int word_count = 0;  // Counter for word occurrences
char target_word[50];  // Word to search for
%}

%%
"int"     { printf("TOKEN: KEYWORD (int)\n"); }
"float"   { printf("TOKEN: KEYWORD (float)\n"); }
"return"  { printf("TOKEN: KEYWORD (return)\n"); }


[a-zA-Z][a-zA-Z0-9]*  { printf("TOKEN: IDENTIFIER (%s)\n", yytext); }


[0-9]+        { printf("TOKEN: INTEGER (%s)\n", yytext); }
[0-9]+"."[0-9]+  { printf("TOKEN: FLOAT (%s)\n", yytext); }

  
"="    { printf("TOKEN: OPERATOR (=)\n"); }
"+"    { printf("TOKEN: OPERATOR (+)\n"); }
"-"    { printf("TOKEN: OPERATOR (-)\n"); }
"*"    { printf("TOKEN: OPERATOR (*)\n"); }
"/"    { printf("TOKEN: OPERATOR (/)\n"); }


[ \t\n]    { /* Skip spaces, tabs, and newlines */ }


. { printf("TOKEN: UNKNOWN (%s)\n", yytext); }
%%

int yywrap() {
    return 1; // Required to avoid linker error
}

int main() {
    printf("Enter code snippet:\n");
    yylex(); // Start lexical analysis
    return 0;
}
