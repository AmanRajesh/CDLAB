%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
%}

%union {
    char* id;
    int num;
    char* str;
}

%token <id> ID
%token <num> NUM
%token <str> STRING

%token INT MAIN PRINTF ADD ASSIGN LPAREN RPAREN SEMI COMMA LBRACE RBRACE

%start program

%%

program:
INT MAIN LPAREN RPAREN LBRACE {
    printf(".data\n");
    printf(".LC0: .string \"Sum %%d\\n\"\n");
    printf(".text\n");
    printf(".globl main\n");
    printf("main:\n");
}
stmt_list RBRACE {
    printf(" ret\n");
}
;

stmt_list:
stmt
| stmt_list stmt
;

stmt:
INT ID ASSIGN NUM SEMI {
    printf(" movl $%d, %s\n", $4, $2);
}
| ID ASSIGN expr SEMI {
    printf(" movl %%eax, %s\n", $1);
}
| PRINTF LPAREN STRING COMMA ID RPAREN SEMI {
    printf(" movl %s, %%esi\n", $5);
    printf(" lea .LC0(%%rip), %%rdi\n");
    printf(" xor %%eax, %%eax\n");
    printf(" call printf\n");
}
;

expr:
ID ADD ID {
    printf(" movl %s, %%eax\n", $1);
    printf(" addl %s, %%eax\n", $3);
}
| NUM ADD ID {
    printf(" movl $%d, %%eax\n", $1);
    printf(" addl %s, %%eax\n", $3);
}
| ID ADD NUM {
    printf(" movl %s, %%eax\n", $1);
    printf(" addl $%d, %%eax\n", $3);
}
| NUM {
    printf(" movl $%d, %%eax\n", $1);
}
| ID {
    printf(" movl %s, %%eax\n", $1);
}
;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid\n");
    exit(1);
}

/*
Execution commands:
lex 5.l
yacc -d 5.y
gcc lex.yy.c y.tab.c -o output -ll
echo 'int main(){int a=5;int b=10;a=a+b;printf("Sum %d\n",a);}' | ./output
*/