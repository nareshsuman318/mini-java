%{
#include<stdio.h>
#include "lex.yy.c"
int valid=1;
%}
%token A B
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%
%%

str:S'\n' {printf("Accepted"); exit(0);}
;
 S :Program;
Program : class_dec{class_dec};  
class_dec: CLASS ID [EXTENDS ID]'{' {var_dec} {method_dec} '}';
var_dec : Type ID ['=' Expr ] ';' ;
method_dec : PUBLIC Type ID'(' [FormalParams]')' '{' {var_dec} {statement} '}'
             | PUBLIC STATIC VOID MAIN '(' STRING  '[' ']' <ID> ')' '{' {var_dec} {statement} '}' ;


FormalParams : Formal{',' Formal} ;
Formal : Type <ID> ;
Type :  BasicType [ '[' ']' ] 
	| <ID> 
	| VOID ;

BasicType : BOOLEAN
	    | INT 
	    | DOUBLEE ;


Statement  : '{' {Statement} '}' 
             | [Expr '.'] <ID> [ '[' Expr ']' ] '=' Expr ';'
             | [Expr '.']  <ID> '(' [Explist] ')' ';' 
             | IF '(' Expr ')' Statement [ELSE Statement]
             | WHILE '(' Expr ')' Statement
             | SYSTEM.OUT '(' [Expr|<STRING>]')' ';'
             | Return [Expr] ';' ;

Expr :  Expr Binop Expr      
        | '!' Expr
        | Expr '[' Expr']'
        | Expr '.' "length"  '('  ')'
        | [ Expr '.']  <ID> '(' [ Exprlist ] ')'
        | [ Expr '.'] <ID>
        | NEW  BasicType '[' Expr  ']'
        | NEW <ID>  '('  ')'
        | '(' Expr ')'
        | THIS
        | Number ;
        
        
Exprlist : Expr {',' Expr}

Number   : INT
          | REAL
          | TRUE 
          | FALSE ;
          
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



int yyerror(char *msg){
printf("error has occured");
exit(0);
}

main()
{
printf("Enter the input ");
yyparse();
}
