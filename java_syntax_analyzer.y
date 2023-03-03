%{
	

#include <stdio.h>	
 			
int yyerror(char const *msg);	
int yylex(void);
extern int yylineno;

%}


%token keyword_class
%token keyword_public
%token keyword_static
%token keyword_void
%token keyword_main
%token keyword_return
%token keyword_extends
%token keyword_if
%token keyword_else
%token keyword_while
%token keyword_System_out_println
%token keyword_length
%token keyword_this
%token keyword_new

%token type_string
%token type_int
%token type_boolean

%token operator_affectation

%token arith_operator_add
%token arith_operator_substract
%token arith_operator_multiply

%token logical_operator_and
%token logical_operator_less_than
%token logical_operator_less_or_equal_than
%token logical_operator_not

%token point
%token semicolon
%token comma

%token INTEGER_LITERAL
%token BOOLEAN_LITERAL
%token STRING_LITERAL

%token identifier

%token opening_parenthesis
%token closing_parenthesis
%token opening_bracket
%token closing_bracket
%token opening_curly_brace
%token closing_curly_brace


%error-verbose
%start Program

%%

Program                 : MainClass ClassDeclarationRecursive | MainClass  ;

MainClass               :  keyword_public keyword_class Identifier opening_curly_brace keyword_public 
                          keyword_static keyword_void keyword_main opening_parenthesis 
                          type_string opening_bracket closing_bracket Identifier 
                          closing_parenthesis opening_curly_brace StatementRecursive closing_curly_brace closing_curly_brace 
                          ;

ClassDeclarationRecursive : ClassDeclaration ClassDeclarationRecursive  ;
ClassDeclaration        : keyword_class Identifier  keyword_extends Identifier ClassDeclarationBody 
                        | keyword_class Identifier ClassDeclarationBody ;

ClassDeclarationBody    : opening_curly_brace VarDeclarationRecursive MethodDeclarationRecursive closing_curly_brace ;

VarDeclarationRecursive : VarDeclaration VarDeclarationRecursive ;

VarDeclaration : Type Identifier semicolon ;

MethodDeclarationRecursive : MethodDeclaration MethodDeclarationRecursive;

MethodDeclaration : MethodPrototypeDeclaration opening_parenthesis closing_parenthesis  MethodBodyDeclaration
                    | MethodPrototypeDeclaration opening_parenthesis MethodArgsDeclarationRescursive 
                        closing_parenthesis MethodBodyDeclaration ; 

MethodPrototypeDeclaration : keyword_public Type Identifier ; 
MethodBodyDeclaration : opening_curly_brace VarDeclarationRecursive StatementRecursive
                        keyword_return Expression semicolon closing_curly_brace ;

MethodArgsDeclaration : Type Identifier ;
MethodArgsDeclarationRescursive : MethodArgsDeclaration comma MethodArgsDeclarationRescursive ;

Type : type_int opening_bracket closing_bracket | type_boolean | 
        type_int | type_string ;

StatementRecursive : Statement StatementRecursive | Statement ;

Statement : opening_curly_brace StatementRecursive closing_curly_brace
            | keyword_if opening_parenthesis Expression closing_parenthesis Statement keyword_else Statement
            | keyword_while opening_parenthesis Expression closing_parenthesis Statement
            | keyword_System_out_println opening_parenthesis Expression closing_parenthesis semicolon
            | Identifier operator_affectation Expression semicolon
            | Identifier opening_bracket Expression closing_bracket operator_affectation Expression semicolon
            | VarDeclaration ;

Expression : Expression logical_operator_and Expression |
             Expression logical_operator_less_than Expression |
             Expression arith_operator_add Expression |
             Expression arith_operator_substract Expression |
             Expression arith_operator_multiply Expression |
             Expression logical_operator_less_or_equal_than Expression |
             Expression opening_bracket Expression closing_bracket |
             Expression point keyword_length |
             INTEGER_LITERAL |
             BOOLEAN_LITERAL |
             STRING_LITERAL |
             Identifier |
             keyword_this |
             keyword_new type_int opening_bracket Expression closing_bracket |
             keyword_new Identifier opening_parenthesis closing_parenthesis |
             logical_operator_not Expression |
             opening_parenthesis Expression closing_parenthesis |
             Expression point Identifier opening_parenthesis ExpressionRecursive closing_parenthesis 
             | Expression point Identifier opening_parenthesis closing_parenthesis ;

ExpressionRecursive : Expression comma ExpressionRecursive | Expression ;

Identifier : identifier ;


%% 

int yyerror(char const *msg) {
       
	
	fprintf(stderr, "%s %d\n", msg,yylineno);
	return 0;
	
	
}

extern FILE *yyin;

int main()
{
 yyparse();
 
 
}
                    

