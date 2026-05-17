%{
    #include"y.tab.h"
    #include<stdio.h>
    #include<string.h>
    
%}

%%
[0-9]+ {yylval.exp = strdup(yytext);return NUM;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.exp = strdup(yytext);return IDEN;}
[+\-*/=()] {return yytext[0];}
\n {return '\n';}
[\t] {}
. { return yytext[0];}
%%

int yywrap()
{
    return 1;
}