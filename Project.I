%{
#include<stdio.h>
#include"y.tab.h"
extern int yylval;
%}
alpha [A-Za-z]
digit [0-9]

%%
class return CLASS ;
extends return EXTENDS;
public return PUBLIC;
static return STATIC;
void return VOID;
main return MAIN;
String return STRING;
boolean return BOOLEAN; 
int return INT ;
double return DOUBLE;
system.out.println return SYSTEMOUT;
length return LENGTH;
new return NEW;
this return THIS;
true return TRUE;
false return FALSE;
if return IF;
then    return THEN;
else    return ELSE;
while return WHILE ;
"&&" {return AND;}  
"||" {return OR;}  
"<=" {return LE;}  
">=" {return GE;}  
"!=" {return NE;}  
"==" {return EQ;}  
Return return RETURN ;

{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;

" " return SPACE ;
[\t] ;
\n return 0;
\".*\" return SENTENCE ;
. return yytext[0];
%%

