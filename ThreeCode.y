%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    

    int yyerror(char *s);
    int yylex();

    typedef char *string;

    struct{
        string res,op1,op2;
        char op;
    }code[100];

    int idx = -1;

    string addToTable(string,string,char);
    void targetCode();

%}

%union{ char *exp;}
%token <exp> IDEN NUM
%type <exp> EXP

%right '='
%left '+' '-'
%left '*' '/' 

%%
STMTS : STMTS STMT
     |
     ;

STMT : EXP '\n'
     ;

EXP : IDEN '=' EXP
      {
        $$ = addToTable($1,$3,'=');
      }
    |EXP '+' EXP
      {
        $$ = addToTable($1,$3,'+');
      }
      
    |EXP '-' EXP
      {
        $$ = addToTable($1,$3,'-');
      }
      
    |EXP '*' EXP
      {
        $$ = addToTable($1,$3,'*');
      }
    |EXP '/' EXP
      {
        $$ = addToTable($1,$3,'/');
      }
    |'(' EXP ')'
      {
        $$ = $2;
      }
    |IDEN 
      {
        $$ = $1;
      }
    |NUM
      {
        $$ =$1;
      }
    ;
%%

int yyerror(char *s)
{
    printf("Invalid \n");
    return 0;
}

int main()
{
    printf("Enter Expression\n");
    fflush(stdout);
    yyparse();
    printf("Target Code\n");
    targetCode();
    return 0;
}

string addToTable(string op1,string op2,char op)
{
    idx++;

    if(op=='=')
    {
        code[idx].res = strdup(op1);
        code[idx].op1 = strdup(op2);
        code[idx].op2 = strdup("");
        code[idx].op = op;
        return strdup(op1);
    }
    string res = (string)malloc(10);
    sprintf(res,"@%c",idx + 'A');

    
    code[idx].op1 = strdup(op1);
    code[idx].op2 = strdup(op2);
    code[idx].op = op;
    code[idx].res = strdup(res);
    return res;

}

void targetCode()
{
    for(int i=0;i<=idx;i++)
    {
        if(code[i].op=='=')
        {
            printf("LOAD\tR1, %s\n",code[i].op1);
            printf("STORE\t %s, R1\n",code[i].res);
            continue;
        }
        char *instr;
        switch(code[i].op)
        {
            case '+':instr = "ADD";break;
            case '-':instr = "SUB";break;
            case '*':instr = "MUL";break;
            case '/':instr = "DIV";break;

        }
        printf("LOAD\tR1, %s\n",code[i].op1);
        printf("LOAD\tR2, %s\n",code[i].op2);
        printf("%s\tR3, R1, R2\n",instr);
        printf("STORE\t %s, R3\n",code[i].res);
    }
    for(int i=0;i<=idx;i++)
    {
        printf("%d\t: %s\t %s\t %s\t %c\n",i,code[i].res,code[i].op1,code[i].op2,code[i].op);
    }
    
	for(int i = 0; i <= idx; i++) {
		printf("%s = %s %c %s\n", code[i].res, code[i].op1, code[i].op, code[i].op2);
	}
}


