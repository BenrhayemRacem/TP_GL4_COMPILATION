
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
COMMENT_BLOCK                        "/*"([^*])*"*/"
WRONG_COMMENT_BLOCK                  "/*"([^\*\/])*   


%%
"class"                                     { printf(" keyword_class "); }
"public"                                    { printf(" keyword_public "); }
"static"                                    { printf(" keyword_static "); }
"void"                                      { printf(" keyword_void "); }
"main"                                      { printf(" keyword_main "); }
"return"                                    { printf(" keyword_return "); }
"extends"                                   { printf(" keyword_extends "); }
"if"                                        { printf(" keyword_if "); }
"else"                                      { printf(" keyword_else "); }
"while"                                     { printf(" keyword_while "); }
"System.out.println"                        { printf(" keyword_System_out_println "); }
"length"                                    { printf(" keyword_length "); }
"this"                                      { printf(" keyword_this "); }
"new"                                       { printf(" keyword_new "); }


"String"                                    { printf(" type_string "); }
"int"                                       { printf(" type_int "); }
"boolean"                                   { printf(" type_boolean "); }


"="                                         { printf(" operator_affectation "); }


"+"                                         { printf(" arith_operator_add "); }
"-"                                         { printf(" arith_operator_substract ") ; }
"*"                                         { printf(" arith_operator_multiply ") ; }


"&&"                                        { printf(" logical_operator_and "); }
"<"                                         { printf(" logical_operator_less_than "); }
"<="                                        { printf(" logical_operator_less_or_equal_than ");}
"!"                                         { printf(" logical_operator_not "); }

"."                                         { printf(" point "); }
";"                                         { printf(" semicolon "); }
","                                         { printf( " comma ") ; }


{bl}                                        /* no action */
"\n"                                        /* no action */

{INTEGER_LITERAL}                           { printf( " INTEGER_LITERAL ") ; }
{BOOLEAN_LITERAL}                           { printf( " BOOLEAN_LITERAL ") ; }
{STRING_LITERAL}                            { printf( " STRING_LITERAL ") ; }

{identifier}                                { printf( " identifier ") ; }

{opening_parenthesis}                       { printf( " opening_parenthesis ") ; }
{closing_parenthesis}                       { printf( " closing_parenthesis ") ; }
{opening_bracket}                           { printf( " opening_bracket ") ; }
{closing_bracket}                           { printf( " closing_bracket ") ; }
{opening_curly_brace}                       { printf( " opening_curly_brace ") ; }
{closing_curly_brace}                       { printf( " closing_curly_brace ") ; }

{COMMENT_LINE}                              { printf(" comment_line "); }
{COMMENT_BLOCK}                             { printf(" comment_block "); }
{WRONG_COMMENT_BLOCK}                       { printf(" wrong_comment_block "); }



{wrong_identifier}                          {fprintf(stderr,"illegal identifier \'%s\' on line :%d\n",yytext,yylineno);}



%%

int main(int argc, char *argv[]) 
{
     yyin = fopen(argv[1], "r");
     yylex();
     fclose(yyin);
}

int yywrap()
{
	return(1);
}


