%{
#include <stdio.h>
#include "calc.tab.h"
int yylex();
int yyerror(const char *s);
%}

%token INT FLOAT POSITIVE
%token PLUS MINUS MULT DIVIDE
%token BR_LEFT BR_RIGHT
%token OP_EVEN OP_ODD

%%

expr:  expr term1 PLUS term2 { printf("Plus\n"); }
    |  expr term1 MINUS term2 { printf("Minus\n"); }
    |  term1 PLUS term2 { printf("Plus\n"); }
    |  term1 MINUS term2 { printf("Minus\n"); }
    |  term1 
    ;
term1: term1 termextension
    |  factor1
    |  factor1 termextension
    ;
term2: term2 termextension
    |  factor2
    |  factor2 termextension
    ;
factor1:  factor2 
    |     negative
    ;
factor2:  BR_LEFT expr BR_RIGHT
    |     function
    |     positive
    ;
termextension:  MULT factor2 { printf("Mult\n"); }
    |           DIVIDE factor2 { printf("Divide\n"); }
    ;
function:  op_even 
    |      op_odd
    ;
op_even:  OP_EVEN BR_LEFT expr BR_RIGHT { printf("even\n"); }
    ;
op_odd:  OP_ODD BR_LEFT expr BR_RIGHT { printf("odd\n"); }
    ;

negative:  MINUS positive { printf("Negative\n"); }
    ;
positive: INT { printf("Integer\n"); }
    |     FLOAT { printf("Float\n"); }
    ;
          

%%

/*
int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
*/
/*
int main(void) {
    yyparse();
    return 0;
}
*/
