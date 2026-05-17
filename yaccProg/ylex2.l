%{
    #include<stdio.h>
    #include "y.tab.h"
    #include<stdlib.h>
    extern yylval;
%}

%%
[0-9]+ {yylval = atoi(yytext);return NUM;}
[-+\*/()] {return yytext[0];}
. {return yytext[0];}
\n {return 0;}

%%

int yywrap()
{
    return 1;
}