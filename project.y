%{
#include<stdio.h>
int valid=1;
%}
%token ID
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%
%%

str:S'\n' {return 0;}
;
 
Program : class_dec{class_dec};  {printf("\n Accepted\n"); exit(0);}

class_dec: CLASS" "ID '{' {var_dec} {method_dec} '}'           {;}
	| CLASS" "ID "extends"<ID>'{' {var_dec} {method_dec} '}'
	;
var_dec : Type<ID> ';' 
	| Type<ID>'=' Expr ';' 
	|
	;    
method_dec : "public" Type<ID>'('')' '{' {var_dec} {statement} '}'
	     | "public" Type<ID>'(' FormalParams')' '{' {var_dec} {statement} '}'
             | "public" "static" "void" "main" '(' "String" '[' ']' <ID> ')' '{' {var_dec} {statement} '}' 
	     ;


FormalParams : Formal{',' Formal} ;
Formal : Type <ID> ;
Type :  BasicType
	|BasicType'[' ']' 
	| ID 
	| "void" ;

BasicType : "boolean"
	    | "int" 
	    | "double" ;


Statement  : '{' {Statement} '}' 
             | <ID> '=' Expr ';'
	     | <ID> '[' Expr ']'  '=' Expr ';'
	     |Expr '.' <ID> '=' Expr ';'
	     |Expr '.' <ID>  '[' Expr ']'  '=' Expr ';'
	     
             |   <ID> '('  ')' ';' 
	     |   <ID> '(' Explist ')' ';' 
	     | Expr '.'  <ID> '('  ')' ';' 
	     | Expr '.'  <ID> '(' Explist ')' ';' 
	     
             | IF '(' Expr ')' Statement [ELSE Statement]
	     | IF '(' Expr ')' Statement ELSE Statement
             | WHILE '(' Expr ')' Statement
             | "system.out.println" '(' ')' ';'   {print("system.out.println()")}
	     |  "system.out.println" '(' Expr|<STRING>')' ';'
             | Return  ';'
	     |Return Expr ';';

Expr :  Expr Binop Expr   {
				if($2=='+') 
				{
				   $$ = $1 + $3 ;
				}
				else if($2=='-') 
				{
				   $$ = $1 - $3 ;
				}
				else if($2=='*') 
				{
				   $$ = $1 * $3 ;
				}
				else if($2=='/') 
				{
				   $$ = $1 / $3 ;
				}
				else if($2=='==') 
				{
				   if($1==$3) { $$ = 1}
				   else {$$ = 0}
				}
				else if($2=='!=') 
				{
				   if($1!=$3) { $$ = 1}
				   else {$$ = 0}
				}
				else if($2=='<') 
				{
				   if($1<$3) { $$ = 1}
				   else {$$ = 0}
				}
				else if($2=='<=') 
				{
				   if($1<=$3) { $$ = 1}
				   else {$$ = 0}
				}
				else if($2=='>') 
				{
				   if($1>$3) { $$ = 1}
				   else {$$ = 0}
				}
				else if($2=='>=') 
				{
				   if($1>=$3) { $$ = 1}
				   else {$$ = 0}
				}
				;}

        | '!' Expr
        | Expr '[' Expr']'
        | Expr '.' "length"  '('  ')'
        |  <ID> '('  ')'
	|   <ID> '('  Exprlist  ')'
	|  Expr '.'  <ID> '('  ')'
	|  Expr '.'  <ID> '('  Exprlist  ')'
        |  <ID>
	|  Expr '.' <ID>
        | "new"  BasicType '[' Expr  ']'
        | "new" <ID>  '('  ')'
        | '(' Expr ')'
        | "this"
        | Number ;
        
        
Exprlist : Expr {',' Expr}

Number   : NUM
          | "true" 
          | "false" ;
          
Binop : '+'  {;}
        | '-' 
        | '*'
        | '/'
        | '&&'
        | '||'
        | '==' 
        | '!='
        | '<'
        | '<='
        | '>'
        | '>=';
