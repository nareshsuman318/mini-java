%{
#include<stdio.h>
#include"y.tab.h"
extern int yylval;
%}
 alpha [A-Za-z]
digit [0-9]

%%
class return CLASS ;
if return IF;
public return PUBLIC
then    return THEN;
extends return EXTENDS;
static return STATIC;
void return VOID;
main return MAIN;
String return STRING;
else    return ELSE;
while return WHILE ;
{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;
[\t] ;
\n return 0;
. return yytext[0];
%%


