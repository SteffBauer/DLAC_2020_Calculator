%option noyywrap

%{
#include "iostream"
#include "string"
#include "calc.tab.h"
#include "./libs/methods.h"

using namespace std;

extern int yyerror (char const *s);
%}

SEP     [,.]
ZERO    [0]
DIGIT   [0-9]
NONZERO [1-9]

%%

({ZERO}|({NONZERO}{DIGIT}*)*){SEP}{DIGIT}+ {
                                yylval=stringToDouble(yytext); return DOUBLE;          
                            }
{ZERO}|({NONZERO}{DIGIT}*)  {   
                                yylval=atoi(yytext); return INT; 
                            }
{ZERO}{2,}                  {
                                yyerror("More than one zero\n");
                            }
"+"                         {
                                return PLUS ;
                            }
"-"                         {
                                return MINUS;
                            }
"*"                         {
                                return MULT;
                            }
"/"                         {
                                return DIVIDE;
                            }
"%"                         {
                                return MODULO;
                            }
"^"                         {
                                return POWER;
                            }
"sqr"                       {
                                return SQR;
                            }
"("                         {
                                return BR_LEFT;
                            }
")"                         {
                                return BR_RIGHT;
                            }
"even"                      {
                                return OP_EVEN;
                            }
"odd"                       {
                                return OP_ODD;
                            }
[\n]                        {
                                return END;
                            }
[ \t]+	                    { 
                                /* Do nothing at whitespace - eat it! */
                            }    
"E"|"e"                     {
                                printf("Exiting the calculator.\n"); 
                                return 0;    
                            }                               
.                           {
                                yyerror("Unrecognized token\n");  /* Is there anything else? Fail on it! */
                            }

%%
