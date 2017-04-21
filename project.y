%{
#include<stdio.h>
int valid=1;
%}
%token ID CLASS EXTENDS PUBLIC STATIC VOID MAIN STRING BOOLEAN INT DOUBLE SYSTEMOUT LENGTH NEW THIS TRUE FALSE IF THEN ELSE WHILE RETURN NUM SPACE SENTENCE
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%
%%

str:S'\n' {return 0;}
;
 
Program : class_dec   {printf("\n Accepted\n"); exit(0);} 
	| class_dec Program 
	;
class_dec: CLASS SPACE ID '{' var_dec  method_dec  '}'           {;}
 	| CLASS SPACE ID SPACE EXTENDS SPACE ID '{' var_dec method_dec '}'  {;}
 	;
 var_dec : Type SPACE ID ';' 
 	| Type SPACE ID '=' Expr ';' 
 	| var_dec var_dec 
 	;    
 method_dec : PUBLIC SPACE  Type SPACE ID '(' ')' '{' var_dec statement '}'
 	     | PUBLIC SPACE  Type SPACE ID '(' FormalParams')' '{' var_dec statement '}'
              | PUBLIC SPACE STATIC SPACE VOID SPACE MAIN '(' STRING '[' ']' ID ')' '{' var_dec statement '}' 
 	     ;
  

FormalParams    : Formal             { $$ = dcl ($2, (char *) NULL, $1, 0, PARAM); }
        	| FormalParams ',' Formal    { $$ = dcl ($4, (char *) NULL, $3, 0, PARAM); }
        	;
Formal : Type SPACE ID ;
Type :  BasicType
	|BasicType'[' ']'  
	| ID  ;         {}
	| "void" ;     {}

BasicType : "boolean"
	    | "int" 
	    | "double" ;


Statement  : '{' Statement '}' 
             | ID '=' Expr ';'
 	     | ID '[' Expr ']'  '=' Expr ';'
	     |Expr '.' <ID> '=' Expr ';'
	     |Expr '.' <ID>  '[' Expr ']'  '=' Expr ';'
 	     
             | ID '('  ')' ';' 
 	     |ID '(' Explist ')' ';' 
 	     | Expr '.' ID '('  ')' ';' 
 	     | Expr '.'  ID '(' Explist ')' ';' 
 	     
             | IF '(' Expr ')' Statement ELSE Statement   
	     |IF '(' Expr ')' Statement
             | WHILE '(' Expr ')' Statement
             | SYSTEMOUT '(' ')' ';'   {print("\n");}
 	     | SYSTEMOUT '(' SENTENCE ')' ';'   {print("$2\n");}
	     |SYSTEMOUT '(' Expr ')' ';'   {print("$2\n");}
             |RETURN  ';'    
 	     |RETURN Expr ';'  {$$ = $2;}
	     ;
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
				else if($2=='&&') 
				{
				   if(($1==true)&&($2==true)) { $$ = true}
				   else {$$ = false}
				}else if($2=='||') 
				{
				   if(($1==false)&&($2==false)) { $$ = false}
				   else {$$ = true}
				}
				else if($2=='==') 
				{
				   if($1==$3) { $$ = true}
				   else {$$ = 0}
				}
				else if($2=='!=') 
				{
				   if($1!=$3) { $$ = true}
				   else {$$ = false}
				}
				else if($2=='<') 
				{
				   if($1<$3) { $$ = true}
				   else {$$ = false}
				}
				else if($2=='<=') 
				{
				   if($1<=$3) { $$ = true}
				   else {$$ = false}
				}
				else if($2=='>') 
				{
				   if($1>$3) { $$ = true}
				   else {$$ = false}
				}
				else if($2=='>=') 
				{
				   if($1>=$3) { $$ = true}
				   else {$$ = false}
				}
				;}
				

        | '!' Expr             {$$ = !$1 ;}
        | Expr '[' Expr']'	{;}
        | Expr '.' "length"  '('  ')'	{;}
        |  <ID> '('  ')'	{;}
 	|   <ID> '('  Exprlist  ')'	{;}
 	|  Expr '.'  <ID> '('  ')'	{;}
 	|  Expr '.'  <ID> '('  Exprlist  ')'	{;}
        |  <ID>			{;}
 	|  Expr '.' <ID> 	{;}
        | "new"  BasicType '[' Expr  ']'   {;}
        | "new" <ID>  '('  ')'		{;}
        | '(' Expr ')'		{;}
        | "this"         {;}
        | Number ;      {$$ = $1}
        
        
Exprlist : Expr {',' Expr}

Number   : NUM
          | "true" 
          | "false" ;
          
Binop : '+'  {;}
        | '-'  {;}
        | '*'  {;}
        | '/'  {;}
        | '&&'  {;}
        | '||'  {;}
        | '==' {;}
        | '!=' {;}
        | '<' {;}
        | '<='  {;}
        | '>'   {;}
        | '>=';  {;}
