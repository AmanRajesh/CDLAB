%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *s);
    int yylex();
    int cnt=0;
    int maxdepth=0;
    int depth=0;
%}

%token IF NUM IDEN INC DEC LE GE ADDSUB

%%
S : BS
  ;
BS : BS B 
   |
   ;
B : I | E ';' | '{' BS '}'
  ;
I : IF A 
   {
    cnt++;
    depth++;
    if(depth>maxdepth) maxdepth=depth;
   }
   B 
   {
    depth--;
   }
   ;
A : '(' E ')'
  ;
E : IDEN Z IDEN
  | IDEN Z NUM
  | IDEN U
  | IDEN
  ;
Z : '='|'<'|'>'|LE|GE|ADDSUB
  ;
U : INC|DEC
  ;
%%

int main()
{
    printf("Enter the code Snippet\n");
    yyparse();
    printf("The number of IF's is %d\n",cnt);
    printf("The maximum no of nesting is %d\n",maxdepth);
    return 0;
}
int yyerror(char *s)
{
    return 1;
}