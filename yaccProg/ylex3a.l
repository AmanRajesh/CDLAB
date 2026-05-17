%{
    #include<stdio.h>
    #include"y.tab.h"
%}

%%
"for" {return FOR;}
"<=" {return LE;}
">=" {return GE;}
"++" {return INC;}
"--" {return DEC;}
"+=" {return ADDSUB;}
"-=" {return ADDSUB;}
[a-zA-Z_][a-zA-Z0-9_]* {return IDEN;}
[0-9]+ {return NUM;}
[\n\t] ;
. {return yytext[0];}

%%

int yywrap()
{
    return 1;
}
