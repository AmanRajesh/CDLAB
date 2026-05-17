%{
    #include<stdio.h>
    int op=0,keywords=0,iden=0;
%}

%%
"int"|"float"|"void"|"char"|"for"|"while"|"break"|"return" {keywords++;}
[a-zA-Z_][a-zA-Z0-9_]* { iden++;}

[\+\-\*\/\!\%\&\|\^\=] {op++;}
"#include".*;
"#"[a-zA-Z]+.*;
[ ] ;
[,] ;
[;] ;
[\n] ;

%%

int main()
{
    yyin = fopen("in2.txt","r");
    yylex();
    printf("The Number of\n");
    printf("Identifiers : %d\n",iden);
    printf("keywords : %d\n",keywords);
    printf("Operators : %d\n",op);
    return 0;
}
int yywrap()
{
    return 1;
}
