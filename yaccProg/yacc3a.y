%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *s);
    int yylex();
    int cnt=0;
    
%}

%token FOR NUM IDEN INC DEC LE GE ADDSUB

%%
S : BS { if(cnt>=3)
            {printf("Valid no of for loops\n");}
            else{
                printf("Invalid no of for loops\n");
            }
        }

  ;
BS : BS B 
   |
   ;
B : I | E ';' | '{' BS '}'
  ;
I : FOR A B
   {
    cnt++;
    
   }
   ;
A : '(' E ';' E ';' E ')'
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
    printf("The number of FOR's is %d\n",cnt);
   
    return 0;
}
int yyerror(char *s)
{
    return 1;
}