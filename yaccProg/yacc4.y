%{
    #include<stdio.h>
    #include<stdlib.h>
    
    int yylex();
    int yyerror(char *s);

%}
%token NUM FOR IDEN LE GE INC DEC ADDSUB DATATYPE

%%
S : F
{
    printf("Valid function definition\n");
}
;
F : T IDEN '(' P ')' B
   ;
T : DATATYPE

  ;
P : PL
  |
  ;
PL : PL ',' A
   | A
   ;
A : T IDEN 
  ;
B : '{' BS '}'
  ;
BS : BS ST
   |
   ;
ST : IDEN '=' NUM ';'
   | IDEN '=' IDEN ';'
   ;


%%

int main()
{
    printf("Enter the function\n");
     
    yyparse();
    return 0; 
}
int yyerror(char *s)
{
    printf("Invalid function");
    exit(0);
}