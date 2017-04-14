%{
#include<stdio.h>
int valid=1;
%}
%token A B
%%

str:S'\n' {return 0;}
;
 
Program : class_dec"{"class_dec"}" ;
class_dec: class"<"ID">["extends "<"ID">]{"var_dec "}";

