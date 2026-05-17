%{
#include<stdio.h>
int nest=0,single=0,mlines=0,multi=0;
%}

%%

"//"[^\n\/\*]* {if(nest==0) {fprintf(yyout,"\n");} single++;}
"/*"[^\n\/\*]* {if(nest==0){fprintf(yyout,"\n");}multi++;nest++;}
"*/" {nest--;}
[\n] {if(nest>0){mlines++;} else{fprintf(yyout,"\n");}}
. {if(nest==0){fprintf(yyout,"%s",yytext);}}

%%

int main()
{
    yyin = fopen("in.txt","r");
    yyout = fopen("out.txt","w");
    yylex();

    printf("The Number of\n");
    printf("nest : %d\n",nest);
    printf("single : %d\n",single);
    printf("mlines: %d\n",mlines);
    printf("multi: %d\n",multi);
    return 0;

}
int yywrap()
{
    return 1;
}