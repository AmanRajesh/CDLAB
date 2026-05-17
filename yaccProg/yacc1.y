%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *s);
    int yylex();
%}

%%
S : A B 
  ;
A : 'a' A 'b'
  |
  ;
B : 'b' B 'c'
  |
  ;
%%

int main()
{
    printf("Enter the String\n");
    yyparse();
    printf("Valid String\n");
    return 0;
}
int yyerror(char *s)
{
    printf("Invalid String\n");
    return 0;
}
