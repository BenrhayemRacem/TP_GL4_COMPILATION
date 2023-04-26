%{	
 /* We usually need these... */	
 #include <stdio.h>	
 #include <stdlib.h>	
#include <string.h>
 #include <math.h>		
 

 /* Local stuff we need here... */	
 #include "new_java_syntax_analyzer.tab.h"
 
int i=0;
int j=0;
extern char nom[];
extern int numval;
void yyerror(char const *msg);
void lexicerror ( const char *msg);
 void semanticerror (const char *str);
 void semanticwarning ( char *str);
 char* concat(char* s1, char* s2);
%}


%option yylineno

delim                                [ \t] 
bl                                   {delim}+

digit                                [0-9]
letter                               [a-zA-Z]

INTEGER_LITERAL                      {digit}+
BOOLEAN_LITERAL                      true|false
STRING_LITERAL                       \"(.)*\"

identifier                           ({letter}|"_")({letter}|{digit}|"_")*
wrong_identifier                     {digit}({letter}|{digit}|"_")*

opening_parenthesis                  (\()
closing_parenthesis                  (\))

opening_bracket                      (\[)
closing_bracket                      (\])

opening_curly_brace                  (\{)
closing_curly_brace                  (\})


COMMENT_LINE                         "//".*
COMMENT_BLOCK                        "/*"([^*]|\*+[^*/])*\*+"/"
WRONG_COMMENT_BLOCK                  \/\*([^(\*\/)]|\n)*   


%%
"class"                                     { return keyword_class ; }
"public"                                    { return keyword_public ; }
"static"                                    { return keyword_static ; }
"void"                                      { return keyword_void ; }
"main"                                      { return keyword_main ; }
"return"                                    { return keyword_return ; }
"extends"                                   { return keyword_extends ; }
"if"                                        { return keyword_if ; }
"else"                                      { return keyword_else ; }
"while"                                     { return keyword_while ; }
"System.out.println"                        { return keyword_System_out_println ; }
"length"                                    { return keyword_length ; }
"this"                                      { return keyword_this ; }
"new"                                       { return keyword_new ; }


"String"                                    { return type_string ; }
"int"                                       { return type_int ; }
"boolean"                                   { return type_boolean ; }


"="                                         { return operator_affectation ; }


"+"                                         { return arith_operator_add ; }
"-"                                         { return arith_operator_substract  ; }
"*"                                         { return arith_operator_multiply  ; }


"&&"                                        { return logical_operator_and ; }
"<"                                         { return logical_operator_less_than ; }
"<="                                        { return logical_operator_less_or_equal_than ;}
"!"                                         { return logical_operator_not ; }

"."                                         { return point ; }
";"                                         { return semicolon ; }
","                                         { return  comma  ; }


{bl}                                        /* no action */
"\n"                                        /* no action */

{INTEGER_LITERAL}                           { numval = atoi(yytext); return  INTEGER_LITERAL  ; }
{BOOLEAN_LITERAL}                           { return  BOOLEAN_LITERAL  ; }
{STRING_LITERAL}                            { return  STRING_LITERAL  ; }

{identifier}                                { strcpy(nom, yytext); return  identifier  ; }

{opening_parenthesis}                       { return  opening_parenthesis  ; }
{closing_parenthesis}                       { return  closing_parenthesis  ; }
{opening_bracket}                           { return  opening_bracket  ; }
{closing_bracket}                           { return  closing_bracket  ; }
{opening_curly_brace}                       { return  opening_curly_brace  ; }
{closing_curly_brace}                       { return  closing_curly_brace  ; }

{COMMENT_LINE}                              /* no action */
{COMMENT_BLOCK}                             /* no action */
{WRONG_COMMENT_BLOCK}                       {lexicerror("unclosed comment");}



{wrong_identifier}                          {lexicerror(concat("illegal identifier ", yytext));}



%%
void yyerror(const char *str)
{

    if(str[0]=='s'){
        return;
    }
    fprintf(stderr,"#  %s\n",str);
	
}

void lexicerror ( const char *msg ){
    i++;
    char errstr[200];
        sprintf(errstr,"Lexical error on line %d, %s",yylineno,msg);
    yyerror(errstr);
}
void syntaxerror (const char *str){
    i++;
    char errstr[200];
    sprintf(errstr,"Syntax error on line %d, %s",yylineno,str);
    yyerror(errstr);
}

void semanticerror (const char *str){
    i++;
    char errstr[200];
    sprintf(errstr,"Semantic error on line %d, %s",yylineno,str);
    yyerror(errstr);
}

void semanticwarning (char *nom){
    j++;
    char errstr[200];
    sprintf(errstr,"Semantic warning on line %d, declared variable is not used: %s",yylineno,nom);
    yyerror(errstr);
}

int yywrap()
{
	return(0);
}


