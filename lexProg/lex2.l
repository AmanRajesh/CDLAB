%{
    #include<stdio.h>
    int posint=0,negint=0,posfrac=0,negfrac=0;
%}

num [0-9]+
posint \+?{num}
negint -{num}
posfrac (\+?{num}*\.?{num}\/\+?{num}*\.?{num}|-{num}*\.?{num}\/-{num}*\.?{num}|\+?{num}*\.?{num})
negfrac (\+?{num}*\.?{num}\/-{num}*\.?{num}|-{num}*\.?{num}\/\+?{num}*\.?{num}|-{num}*\.?{num})

%%
[\t] ;
{posint} {posint++;}
{negint} {negint++;}
{posfrac} {posfrac++;}
{negfrac} {negfrac++;}
[\n] { return 0;}
%%

int main()
{
    printf("Enter the number\n");
    yylex();
    printf("\nThe number of \nPositive Integer : %d\nNegative Integer : %d\n Positive Fraction : %d\nNegative Fraction : %d\n", posint,negint,posfrac,negfrac);
    return 0;
}
int yywrap()
{
    return 1;
}