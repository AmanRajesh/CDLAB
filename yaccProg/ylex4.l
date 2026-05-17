%{
    #include "y.tab.h"
    #include<stdio.h>
    #include<stdlib.h>
%}
%%
[0-9]+  {return NUM;}

"int"|"float"|"char"|"double" {return DATATYPE;}
[ \t\n] ;
[a-zA-Z_][a-zA-Z0-9_]* {return IDEN;}
[(){}<>=;] {return yytext[0];}
.    {return yytext[0];}
%%
int yywrap()
{
    return 1;
}