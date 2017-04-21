%{
#include<stdio.h>
#include"y.tab.h"
extern int yylval;
%}
 alpha [A-Za-z]
digit [0-9]

%%
class return CLASS ;
extends return EXTANDS;
public return PUBLIC;
static return STATIC;
void return VOID;
main return MAIN;
String return STRING;
boolean return BOOLEAN; 
int return INT ;
double return DOUBLE;
system.out.println return SYSTEM.OUT;
length return LENGTH;
new return NEW;
this return THIS;
true return TRUE;
false return FALSE;
if return IF;
then    return THEN;
else    return ELSE;
while return WHILE ;

{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;

' ' return SPACE ;
[\t] ;
\n return 0;
\".*\" return statement;
. return yytext[0];
%%


