%{
#include<stdio.h>
int valid=1;
%}
%token A B
%%

str:S'\n' {return 0;}
;
 
Program : class_dec'{'class_dec'}' ;
class_dec: class'<'ID'>['extends '<'ID'>]{'var_dec '}';
var_dec : Type'<'ID'>['=' 'Expr']';
method_dec : 'public' Type'<'ID'>('['FormalParams']')'{' {'var_dec'} {'statement'}'}''
             | 'public' 'static' 'void' 'main' '(' 'String' '[' ']' 
                <'ID'> ')' '{' {'var_dec'} {'statement'} ' ; 

FormalParams: Formal'{'Formal'}'';
Formal : Type'<'ID'>';
Type :BasicType'[ '[' ']' ]' | <'ID'> | 'void' ;
BasicType : 'boolean' | 'int' | 'double';

Statement  : '{' {'Statement'} '}' 
             | '['Expr' '.'] <'ID'> [ '[' 'Expr' ']' ] '='  'Expr' ';'
             | '['Expr' '.']  <'ID'> '(' ['Explist'] ')' ';' 
             | 'if' '(' 'Expr' ')' 'Statement' ['else' 'Statement']
             | 'while' '(' 'Expr' ')' 'Statement'
             |'system.out.println' '(' ['Expr'|<'STRING'>]')' ';'
             | 'Return' [E'xpr'] ';' ;
Expr :  'Expr' 'Binop' 'Expr'
        | '!' 'Expr'
        | 'Expr' '[' Expr']'
        | 'Expr' '.' 'length'  '('  ')'
        | [ 'Expr' '.']  <'ID'> '(' [ 'Exprlist' ] ')'
        | [ 'Expr' '.'] <'ID'>
        | 'new'  'BasicType' '[' 'Expr'  ']'
        | 'new' <'ID'>  '('  ')'
        |   '(' 'Expr' ')'
        | 'this'
        | 'Number' ;

