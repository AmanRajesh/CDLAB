%{
    #include<stdio.h>
    int lines=1, characters=0, words =0,spaces=0;
%}

%%
[\n] { lines++;}
[\t] { spaces+=4;}
[ ] { spaces++;}
[a-zA-Z0-9]+ { characters+=yyleng;words++;}
. {characters++;}
# {return 0;}
%%  


int main()
{
    printf("Enter the text\n");
    yylex();
    printf("\nThe number of lines : %d\n characters : %d\n words : %d\n spaces : %d\n",lines,characters,words,spaces);
    return 0;
}
int yywrap()
{
    return 1;
}