%{
#include<stdio.h>
int valid=1;
extern File* yyin
%}
%token ID CLASS EXTENDS PUBLIC STATIC VOID MAIN STRING BOOLEAN INT DOUBLE SYSTEMOUT LENGTH NEW THIS TRUE FALSE IF THEN ELSE WHILE RETURN NUM SPACE SENTENCE LE GE NE EQ AND OR
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%



Program : class_dec   {printf("\n Accepted\n"); exit(0);} 
	| class_dec Program 
	;
class_dec: CLASS SPACE ID '{' var_dec  method_dec  '}'           {;}
 	| CLASS SPACE ID SPACE EXTENDS SPACE ID '{' var_dec method_dec '}'  {;}
 	;
 var_dec : Type SPACE ID ';' 
 	| Type SPACE ID '=' Expr ';' 
 	| var_dec var_dec 
 	|
 	;    
 method_dec : PUBLIC SPACE  Type SPACE ID '(' ')' '{' var_dec Statement '}'
 	     | PUBLIC SPACE  Type SPACE ID '(' FormalParams')' '{' var_dec Statement '}'
              | PUBLIC SPACE STATIC SPACE VOID SPACE MAIN '(' STRING '[' ']' SPACE ID ')' '{' var_dec Statement '}' 
 	     ;
  

FormalParams    : Formal             { ; }
        	| FormalParams ',' Formal    { ; }
        	;
Formal : Type SPACE ID ;
Type :  BasicType
	|BasicType'[' ']'  
	| ID           {;}
	| VOID     {;}
	;
BasicType : BOOLEAN
	    | INT 
	    | DOUBLE
	    ;

Statement  : '{' Statement '}' 
             | ID '=' Expr ';'    
 	     | ID '[' Expr ']'  '=' Expr ';'
	     |Expr '.' ID '=' Expr ';'
	     |Expr '.' ID  '[' Expr ']'  '=' Expr ';'
 	     
             | ID '('  ')' ';' 
 	     |ID '(' Exprlist ')' ';' 
 	     | Expr '.' ID '('  ')' ';' 
 	     | Expr '.'  ID '(' Exprlist ')' ';' 
 	     
             | IF '(' Expr ')' Statement ELSE Statement   
	     |IF '(' Expr ')' Statement
             |WHILE '(' Expr ')' Statement
             |SYSTEMOUT '(' ')' ';'   {printf("\n");}
 	     |SYSTEMOUT '('SENTENCE')' ';'   {printf("%s\n",$2);}
	     |SYSTEMOUT '(' Expr ')' ';'   {printf("%d\n",$2);}
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
				else if($2=='&&') {
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
        | Expr '.' LENGTH  '('  ')'	{;}
        |  ID '('  ')'	{;}
 	|  ID '('  Exprlist  ')'	{;}
 	|  Expr '.'  ID '('  ')'	{;}
 	|  Expr '.'  ID '('  Exprlist  ')'	{;}
        |  ID		{;}
 	|  Expr '.' ID 	{;}
        | NEW  BasicType '[' Expr  ']'   {;}
        | NEW ID  '('  ')'		{;}
        | '(' Expr ')'		{;}
        | THIS         {;}
        | Number       {;}
        ;
        
Exprlist : Expr 	{;}
	  | Exprlist ',' Expr  {;}
	  ;
	  
Number   : NUM    
          | TRUE 
          | FALSE 
          ;
          
Binop : '+'  {;}
        | '-'  {;}
        | '*'  {;}
        | '/'  {;}
        | AND  {;}
        | OR  {;}
        | EQ {;}
        | NE {;}
        | '<' {;}
        | LE  {;}
        | '>'   {;}
        | GE  {;}
        ;
        
%%

main()
{
  printf("Enter the File: ");
  yyin("sam.java",w+);
  yyparse();
}  

yyerror(char *s)  
 {  
  printf("\nError\n");  
 } 
