%{
#include<stdio.h>
#include"y.tab.h"
extern int yylval;
%}
 alpha [A-Za-z]
digit [0-9]

%%
if return IF;
then    return THEN;
else    return ELSE;
{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;
[\t] ;
\n return 0;
. return yytext[0];
%%


