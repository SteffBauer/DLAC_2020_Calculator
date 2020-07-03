%option noyywrap

%{
int yyerror(const char *s);
int yyparse();
#include "calc.tab.h"
%}

SEP     [,.]
ZERO    [0]
DIGIT   [0-9]
NONZERO [1-9]

%%

({ZERO}|({NONZERO}{DIGIT}*)*){SEP}{DIGIT}* {
                                yylval=atof(yytext); return FLOAT;          
                            }
{ZERO}|({NONZERO}{DIGIT}*)  {   
                                yylval=atoi(yytext); return INT; 
                            }
{ZERO}{2,}                  {
                                yyerror("More than one zero\n");
                            }
"+"                         {
                                return PLUS;
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
[ \t\n]+	                { 
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

int main() {
    yyparse();
    return 0;
}

/*
int yywrap() {
    return 0;
}
*/


int yyerror(const char *errormsg) {
    fprintf(stderr, "%s\n", errormsg);
    exit(1);
}