%{
#include <math.h>
#include <stdio.h>
#include "iostream"
using namespace std;
void yyerror (char const *s);
extern int yylex (void);
extern FILE * yyin;
bool flag = false;
%}

%token INT HEX
%token PLUS MINUS
%token TIMES DIVIDE MODULO
%token ROOT POW BITSHIFT_LEFT BITSHIFT_RIGHT
%token DECTOHEX HEXTODEC ABS MIN MAX
%token LEFT RIGHT COMMA
%token END

%left PLUS MINUS
%left TIMES DIVIDE MODULO
%left ROOT POW BITSHIFT_LEFT BITSHIFT_RIGHT
%left DECTOHEX HEXTODEC ABS MIN MAX
%left NEG

%start Input
%%

Input: /* empty */;
Input: Input Line;

Line: END
Line: expr END { if(!flag){
                    cout << showbase << dec <<"Result: "<< $1 << endl;
                    flag = false;
                  }else{
                    cout << showbase << hex <<"Result: "<< $1 << endl;
                    flag = false;
                  }
              };

expr: fourthPriority;

fourthPriority:
  thirdPriority |
  thirdPriority PLUS thirdPriority { $$ =$1 + $3;}; |
  thirdPriority MINUS thirdPriority { $$ = $1 - $3;}; |

thirdPriority:
  seccondPriority |
  seccondPriority TIMES seccondPriority { $$ = $1 * $3;}; |
  seccondPriority DIVIDE seccondPriority { $$ = $1 / $3;}; |
  seccondPriority MODULO seccondPriority { $$ = $1 % $3;};

seccondPriority:
  firstPriority |
  firstPriority ROOT firstPriority { $$ = pow($1, (1/$3));}; |
  firstPriority POW firstPriority { $$ = pow($1, $3);}; |
  firstPriority BITSHIFT_LEFT firstPriority { $$ = $1 << $3;};|
  firstPriority BITSHIFT_RIGHT firstPriority { $$ = $1 >> $3;};

firstPriority:
  factor; | MinMax; | Convert;

Convert:
  ABS LEFT expr RIGHT { $$ = abs($3);}; |
  HEXTODEC LEFT expr RIGHT {$$=$3; flag =false;} ;|
  DECTOHEX LEFT expr RIGHT {$$=$3; flag = true;} ;

MinMax:
  MAX LEFT expr COMMA expr RIGHT { $$ = max($3, $5);}; |
  MIN LEFT expr COMMA expr RIGHT { $$ = min($3, $5);};


factor:
  LEFT expr RIGHT { $$ = $2; }; |
  MINUS expr %prec NEG { $$ = -$2;}; |
  number;

number:
  INT {$$=$1;} |
  HEX {$$=$1;}



%%

void  yyerror(char const *s) {
  printf("\n%s\n", s);
  exit(100);
}

int main(int argc, char** argv)
  {
    ++argv, --argc;
    if(argc > 0){

      if( !(yyin = fopen(argv[0],"r")) ){
       cout<< "File input as argv not given!\n";
       exit(255);
     }
    }else{
    }

    yyparse();

    return 0;
  }
