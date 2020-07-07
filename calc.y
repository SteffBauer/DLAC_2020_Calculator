%code requires{
    #define YYSTYPE double
}
%{

#include <math.h>
#include <stdio.h>
#include "iostream"
#include "./libs/methods.h"
using namespace std;
void yyerror (char const *s);
extern int yylex (void);
extern FILE * yyin;

%}

%token INT DOUBLE POSITIVE
%token PLUS MINUS MULT DIVIDE
%token BR_LEFT BR_RIGHT
%token OP_EVEN OP_ODD
%token END

%%



Input: /* empty */;
Input: Input Line;

Line: END
Line: expr END  { cout << "Result: "<< $1 << endl; };

expr:  term1
    |  expr PLUS term1 { $$ = $1 + $3; };
    |  expr MINUS term1 { $$ = $1 - $3; };
    ;
term1: factor1
    |  term1 MULT factor1 { $$ = $1 * $3; };
    |  term1 DIVIDE factor1 { $$ = $1 / $3; };
    ;
factor1:  factor2 
    |     negative
    ;
factor2:  BR_LEFT expr BR_RIGHT { $$ = $2; };
    |     function
    |     positive
    ;

function:  op_even 
    |      op_odd
    ;
op_even:  OP_EVEN BR_LEFT expr BR_RIGHT { $$ = even($3); };
    ;
op_odd:  OP_ODD BR_LEFT expr BR_RIGHT { $$ = odd($3); };
    ;

negative:  MINUS positive {$$=-$2;};
    ;
positive: INT {$$=$1;}
    |     DOUBLE {$$=$1;}
    ;

%%

void  yyerror(char const *s) {
  printf("\n%s\n", s);
  exit(100);
}

int main(int argc, char** argv) {
    ++argv, --argc;
    if(argc > 0) {
        if( !(yyin = fopen(argv[0],"r")) ) {
            cout<< "File input as argv not given!\n";
            exit(255);
        }
    }

    yyparse();

    return 0;
}