%{
    #include <stdio.h>
	int yylex(void);
	extern int yylineno;
	int yyerror(const char *msg);
%}

%token identifier
%token type_int
%token type_boolean
%token type_string

%token BOOLEAN_LITERAL
%token INTEGER_LITERAL
%token STRING_LITERAL

%token keyword_class
%token keyword_public
%token keyword_main
%token keyword_extends
%token keyword_return
%token keyword_if
%token keyword_else
%token keyword_while
%token keyword_System_out_println
%token keyword_length
%token keyword_this
%token keyword_new
%token keyword_static
%token keyword_void

%token opening_parenthesis
%token closing_parenthesis
%token opening_bracket
%token closing_bracket
%token opening_curly_brace
%token closing_curly_brace

%token operator_affectation
%token arith_operator_add
%token arith_operator_substract
%token arith_operator_multiply
%token logical_operator_not

%token logical_operator_and
%token logical_operator_less_than
%token logical_operator_less_or_equal_than


%token semicolon
%token point
%token comma


%error-verbose
%start Program

%%

Program		           : MainClass ClassDeclarationS
                       
                       ;

MainClass              : MainHead MainBody
                       ;

MainHead               : ClassHead opening_curly_brace keyword_public keyword_static keyword_void keyword_main opening_parenthesis type_string  opening_bracket closing_bracket
                       ;

MainBody               : identifier  closing_parenthesis opening_curly_brace StatementS  closing_curly_brace MethodDeclarationS closing_curly_brace 
                       ;

ClassDeclarationS	   : ClassDeclaration ClassDeclarationS
                       |
                       ;

ClassDeclaration       : ClassHead keyword_extends Identifier opening_curly_brace VarDeclarationS MethodDeclarationS closing_curly_brace 
                        
                        
                       
                       | ClassHead opening_curly_brace VarDeclarationS MethodDeclarationS closing_curly_brace 
                       
                       ;

ClassHead              : keyword_class Identifier 
                       
                       ;

VarDeclarationS        : VarDeclaration VarDeclarationS
                       |
                       ;

VarDeclaration         : Variable  semicolon
                       
                       ;

VariableS              : Variable   comma VariableS
                       | Variable 
                       |
                       
                       ;

Variable               : Type Identifier
                       
                       ;

MethodDeclarationS     : MethodDeclaration MethodDeclarationS
                       |
                       
                       ;

MethodDeclaration      : keyword_public Variable  opening_parenthesis VariableS closing_parenthesis opening_curly_brace StatementS  keyword_return Expression semicolon closing_curly_brace  
                       ;

Type                   : type_int opening_bracket closing_bracket 
                       | type_boolean 
                       | type_int 
                       | type_string
                       ;

StatementS             : Statement StatementS
                       | Statement
                       |
                       ;

Statement              : opening_curly_brace StatementS closing_curly_brace
                       | VarDeclaration
                       | keyword_if opening_parenthesis Expression closing_parenthesis opening_curly_brace StatementS closing_curly_brace keyword_else opening_curly_brace StatementS closing_curly_brace 
                       | keyword_while opening_parenthesis Expression closing_parenthesis opening_curly_brace StatementS closing_curly_brace 
                       | keyword_System_out_println opening_parenthesis Expression closing_parenthesis semicolon
                       | Identifier operator_affectation Expression semicolon 
                       
                       | Identifier opening_bracket Expression closing_bracket operator_affectation Expression semicolon
                       
                       ;

Expression             : INTEGER_LITERAL ExpressionComp
                       | BOOLEAN_LITERAL ExpressionComp
                       | STRING_LITERAL ExpressionComp
                       | Identifier ExpressionComp
                       | keyword_this ExpressionComp
                       | keyword_new type_int opening_bracket Expression closing_bracket ExpressionComp
                        
                       | keyword_new Identifier opening_parenthesis closing_parenthesis ExpressionComp
                       
                       | keyword_new Identifier opening_parenthesis ExpressionS closing_parenthesis ExpressionComp
                       
                      
                       | logical_operator_not Expression ExpressionComp
                       | opening_parenthesis Expression closing_parenthesis ExpressionComp
                       
                       ;

ExpressionComp         : Operator Expression ExpressionComp
                       | Logic Expression ExpressionComp
                       | opening_bracket Expression closing_bracket ExpressionComp
                        
                       | point keyword_length ExpressionComp
                      
                       | MethodCall opening_parenthesis ExpressionS closing_parenthesis ExpressionComp
                        
                       
                       | MethodCall opening_parenthesis closing_parenthesis   ExpressionComp
                      
                       |
                       ;

MethodCall             : point Identifier 
                       ;

ExpressionS            : Expression 
                        comma ExpressionS
                       | Expression 
                      
                       ;
Operator               : arith_operator_add 
                       | arith_operator_multiply 
                       
                       | arith_operator_substract 
                      
                       ;
Logic                  : logical_operator_and
                       | logical_operator_less_than 
                      
                       | logical_operator_less_or_equal_than 
                       
                    
                       ;
Identifier             : identifier
                       ;


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