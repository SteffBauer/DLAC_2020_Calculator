%option noyywrap
%{
#include "iostream"
#include "string"
using namespace std;

#include "y.tab.h"
extern int yyerror (char const *s);
%}


INTEGER   [0-9]
HEXADECIMAL [a-fA-F0-9]


%%
{INTEGER}+            {yylval=atoi(yytext); return INT;}
[0][x]+{HEXADECIMAL}+ {yylval=strtol(yytext, NULL, 0); return HEX;}

"+"                 return PLUS;
"-"                 return MINUS;

"*"                 return TIMES;
"/"                 return DIVIDE;
"%"                 return MODULO;

"#"                 return ROOT;
"^"                 return POW;
"<<"                return BITSHIFT_LEFT;
">>"                return BITSHIFT_RIGHT;

"dectohex"          return DECTOHEX;
"hextodec"          return HEXTODEC;
"abs"               return ABS;
"min"               return MIN;
"max"               return MAX;

"("                 return LEFT;
")"                 return RIGHT;
","                 return COMMA;

[ \t]+            {/* ignore whitespace */;}
[\n]              { return END;}
.                 { //Illegal Input
                      string error;
                      error.append("Unrecognized Token ");
                      error.append(yytext);
                      error.append(" Exiting!");
                      yyerror(error.c_str());
                  }
%%
