%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"int"              { return INT; }
"main"             { return MAIN; }
"printf"           { return PRINTF; }

[a-zA-Z][a-zA-Z0-9]* { yylval.id = strdup(yytext); return ID; }
[0-9]+             { yylval.num = atoi(yytext); return NUM; }

"+"                { return ADD; }
"="                { return ASSIGN; }

"("                { return LPAREN; }
")"                { return RPAREN; }
";"                { return SEMI; }
","                { return COMMA; }

"{"                { return LBRACE; }
"}"                { return RBRACE; }

\"[^\"]*\"         { yylval.str = strdup(yytext); return STRING; }

[ \t\n]            ;

.                  ;

%%

int yywrap() { return 1; }

/*
Execution commands:
lex 5.l
yacc -d 5.y
gcc lex.yy.c y.tab.c -o output -ll
echo 'int main(){int a=5;int b=10;a=a+b;printf("Sum %d\n",a);}' | ./output
*/