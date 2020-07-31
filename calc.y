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

%token INT DOUBLE
%token PLUS MINUS MULT DIVIDE MODULO POWER SQR
%token BR_LEFT BR_RIGHT
%token OP_EVEN OP_ODD
%token END

%%

Input: /* empty */;
Input: Input Line;

Line: END
Line: expr END  { cout << "Result: "<< $1 << endl; };

expr:  term1
    |  expr PLUS term2 { $$ = $1 + $3; };
    |  expr MINUS term2 { $$ = $1 - $3; };
    ;
term1: factor1
    |  term1 MULT factor2 { $$ = $1 * $3; };
    |  term1 DIVIDE factor2 { $$ = $1 / $3; };
    |  term1 MODULO factor2 { $$ = (int)$1 % (int)$3; };
    |  term1 POWER factor2 { $$ = pow($1, $3); };
    ;
term2: factor2
    |  term2 MULT factor2 { $$ = $1 * $3; };
    |  term2 DIVIDE factor2 { $$ = $1 / $3; };
    |  term2 MODULO factor2 { $$ = (int)$1 % (int)$3; };
    |  term2 POWER factor2 { $$ = pow($1, $3); };
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
    |      op_sqr
    ;
op_even:  OP_EVEN BR_LEFT expr BR_RIGHT { $$ = even($3); };
    ;
op_odd:  OP_ODD BR_LEFT expr BR_RIGHT { $$ = odd($3); };
    ;
op_sqr:  SQR BR_LEFT expr BR_RIGHT { $$ = sqrt($3); };
    ;

negative:  MINUS positive {$$=-$2;};
    ;
positive: INT {$$=$1;}
    |     DOUBLE {$$=$1;}
    ;

%%

void  yyerror(char const *s) {
  printf("\n%s\n", s);
  //exit(100);
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