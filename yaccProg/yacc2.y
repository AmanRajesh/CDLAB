%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    int yyerror(char *s);
    
%}

%token NUM
%left '+''-'
%left '*''/'

%%
S : I { printf("The Result is %d\n",$1);}
  ;
I : I '+' I { $$ = $1 + $3;}
  |I '-' I { $$ = $1 - $3;}
  |I '*' I { $$ = $1 * $3;}
  |I '/' I { 
    if($3==0) {printf("Invalid\n");exit(0);}
    else {$$ = $1 / $3;}
  }
  | '(' I ')' {$$ = $2;}
  | NUM {$$ = $1;}
  | '-'NUM {$$ = -$2;}
  ;
%%

int main()
{
    printf("Enter the Expression\n");
    yyparse();
    return 0;
}
int yyerror(char *s)
{
    return 0;
}