%{
    #include "semantic.c"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    char nom[256];
    int numval;
    char nomaff[256];
    char oper[10];
    int indexIf;
    int indexWhile1;
    int indexWhile2;
    
	int yylex(void);
	extern int yylineno;
    extern int i;
    extern int j;
    void syntaxerror(const char *msg);
	void yyerror(const char *msg);

    void BeginSemantique();
    void EndSemantique();
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

MainHead               : ClassHead opening_curly_brace keyword_public keyword_static keyword_void keyword_main { g_type = tVoid; verifierFoncID("main"); } opening_parenthesis type_string {g_type = tString;}  opening_bracket closing_bracket
                       ;

MainBody               : identifier { verifierVarID(nom);}  closing_parenthesis { foncDecEnd(); } opening_curly_brace StatementS  closing_curly_brace {finFonction();} MethodDeclarationS closing_curly_brace  {finClass();}
                       ;

ClassDeclarationS	   : ClassDeclaration ClassDeclarationS
                       |
                       ;

ClassDeclaration       : ClassHead keyword_extends Identifier opening_curly_brace VarDeclarationS MethodDeclarationS closing_curly_brace {finClass();}
                        
                        
                       
                       | ClassHead opening_curly_brace VarDeclarationS MethodDeclarationS closing_curly_brace  {finClass();}
                       
                       ;

ClassHead              : keyword_class Identifier  {verifierClassID(nom);}
                       
                       ;

VarDeclarationS        : VarDeclaration VarDeclarationS
                       |
                       ;

VarDeclaration         : Variable  semicolon
                       
                       ;

VariableS              : Variable {verifierVarID(nom);}   comma VariableS
                       | Variable {verifierVarID(nom);}
                       |
                       
                       ;

Variable               : Type Identifier
                       
                       ;

MethodDeclarationS     : MethodDeclaration MethodDeclarationS
                       |
                       
                       ;

MethodDeclaration      : keyword_public Variable { verifierFoncID(nom); }  opening_parenthesis VariableS closing_parenthesis {foncDecEnd();} opening_curly_brace StatementS  keyword_return Expression semicolon closing_curly_brace   {finFonction();}
                       ;

Type                   : type_int opening_bracket closing_bracket  { g_type = tInt; }
                       | type_boolean { g_type = tBoolean; }
                       | type_int { g_type = tInt; }
                       | type_string { g_type = tString; }
                       ;

StatementS             : Statement StatementS
                       | Statement
                       |
                       ;

Statement              : opening_curly_brace StatementS closing_curly_brace
                       | VarDeclaration
                       | keyword_if opening_parenthesis Expression closing_parenthesis 
                        opening_curly_brace StatementS closing_curly_brace 
                         keyword_else opening_curly_brace StatementS closing_curly_brace  
                       | keyword_while  opening_parenthesis Expression closing_parenthesis 
                        opening_curly_brace StatementS closing_curly_brace 
                       | keyword_System_out_println opening_parenthesis Expression closing_parenthesis semicolon
                       | Identifieraff  operator_affectation Expression semicolon  
                       
                       | Identifieraff  opening_bracket Expression closing_bracket operator_affectation Expression semicolon
                       
                       ;

Expression             : INTEGER_LITERAL  ExpressionComp
                       | BOOLEAN_LITERAL ExpressionComp
                       | STRING_LITERAL ExpressionComp
                       | Identifierexp ExpressionComp
                       | keyword_this ExpressionComp
                       | keyword_new type_int opening_bracket Expression closing_bracket ExpressionComp
                        
                       | keyword_new Identifier opening_parenthesis closing_parenthesis ExpressionComp
                       
                       | keyword_new Identifier opening_parenthesis ExpressionS closing_parenthesis ExpressionComp
                       
                      
                       | logical_operator_not Expression ExpressionComp
                       | opening_parenthesis Expression closing_parenthesis ExpressionComp
                       
                       ;

ExpressionComp         : Operator  Expression  ExpressionComp
                       | Logic Expression  ExpressionComp
                       | opening_bracket Expression closing_bracket ExpressionComp
                        
                       | point keyword_length ExpressionComp
                      
                       | MethodCall opening_parenthesis ExpressionS closing_parenthesis {foncCallEnd();} ExpressionComp
                        
                       
                       | MethodCall opening_parenthesis closing_parenthesis  {g_nbParam = 0;foncCallEnd();}  ExpressionComp
                      
                       |
                       ;

MethodCall             : point Identifier {verifierFoncIDDeclare(nom);} 
                       ;

ExpressionS            : Expression {g_nbParam ++;} 
                        comma ExpressionS
                       | Expression {g_nbParam ++;} 
                      
                       ;
Operator               : arith_operator_add {strcpy(oper, "ADD");} 
                       | arith_operator_multiply  {strcpy(oper, "MUL");}
                       
                       | arith_operator_substract  {strcpy(oper, "SUB");}
                      
                       ;
Logic                  : logical_operator_and 
                       | logical_operator_less_than {strcpy(oper, "INF");}
                      
                       | logical_operator_less_or_equal_than  {strcpy(oper, "INFE");}
                       
                    
                       ;
Identifier             : identifier
                       ;
Identifierexp          : identifier {checkID(nom)}
                       ;
Identifieraff          : identifier {checkIDOnInit(nom); strcpy(nomaff, nom);}
                       ;


%%






extern FILE *yyin;

int main(int argc, char **argv)
{
yyin = fopen(argv[1], "r");
 BeginSemantique();
 yyparse();
 EndSemantique();
}

void BeginSemantique()
{
	table = NULL;
	table_local = NULL;
	table_class = NULL;

	g_type = NODE_TYPE_UNKNOWN;

	g_nbParam = 0;

	g_IfFonc = 0 ;
    g_IfFoncParameters = 0 ;
    g_IfClass = 0 ;
}

void EndSemantique()
{
    fclose(yyin);
    char c;
    c=' ';
    if(i>1)
        c='s';
	if(i==0)
        printf("no errors were found\n");
    else
        printf("%d error%c found\n",i,c);
    c=' ';
    if(j>1)
        c='s';
    if(j!=0){
		if(i==0)
        printf("%d warning%c found\n",j,c);
	}


    destructSymbolsTable(table_local);
	destructSymbolsTable(table);
	destructSymbolsTable(table_class);
    }

    