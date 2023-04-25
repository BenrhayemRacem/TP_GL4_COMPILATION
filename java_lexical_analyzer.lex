%{	
 /* We usually need these... */	
 #include <stdio.h>	
 #include <stdlib.h>	
 		
 #include "new_java_syntax_analyzer.tab.h"	                                                                         	
 /* Local stuff we need here... */	
#include <math.h>	 			
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

{INTEGER_LITERAL}                           { return  INTEGER_LITERAL  ; }
{BOOLEAN_LITERAL}                           { return  BOOLEAN_LITERAL  ; }
{STRING_LITERAL}                            { return  STRING_LITERAL  ; }

{identifier}                                { return  identifier  ; }

{opening_parenthesis}                       { return  opening_parenthesis  ; }
{closing_parenthesis}                       { return  closing_parenthesis  ; }
{opening_bracket}                           { return  opening_bracket  ; }
{closing_bracket}                           { return  closing_bracket  ; }
{opening_curly_brace}                       { return  opening_curly_brace  ; }
{closing_curly_brace}                       { return  closing_curly_brace  ; }

{COMMENT_LINE}                              /* no action */
{COMMENT_BLOCK}                             /* no action */
{WRONG_COMMENT_BLOCK}                       { fprintf(stderr,"wrong comment block  on line :%d\n",yylineno); }



{wrong_identifier}                          {fprintf(stderr,"illegal identifier \'%s\' on line :%d\n",yytext,yylineno);}



%%



int yywrap()
{
	return(0);
}


