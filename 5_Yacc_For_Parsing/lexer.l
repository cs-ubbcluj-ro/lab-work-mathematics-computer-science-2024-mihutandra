%{
#include "parser.tab.h"
#include <stdlib.h>
#include <stdio.h>

void yyerror(const char *s);
%}

%%

"întreg"     return INT;
"bool"       return BOOL;
"caracter"   return CHAR;
"șir"        return STRING;
"dacă"       return IF;
"altfel"     return ELSE;
"cât"        return WHILE;
"execută"    return DO;
"returnează" return RETURN;
"citește"    return CIN;
"afișează"   return COUT;
"constanta"  return CONST;
"pentru"     return FOR;
"main"       return MAIN;

"adevărat"   return TRUE;
"fals"       return FALSE;

[0-9]+       { yylval = atoi(yytext); return INT_CONST; }
\"[^\"]*\"   { return STRING_LITERAL; }
[a-zA-Zăîșțâ_][a-zA-Zăîșțâ0-9_]* return IDENTIFIER;

"=="         return EQ;
"!="         return NEQ;
"<="         return LTE;
">="         return GTE;
"<"          return LT;
">"          return GT;
"="          return ASSIGN;
";"          return SEMICOLON;
"+"          return PLUS;
"-"          return MINUS;
"*"          return MUL;
"/"          return DIV;
"%"          return MOD;
"&&"         return AND;
"||"         return OR;
"!"          return NOT;

"{"          return LBRACE;
"}"          return RBRACE;
"("          return LPAREN;
")"          return RPAREN;

[ \t\n]+     ; /* Ignore whitespace */

.            { yyerror("Unexpected character"); }

%%

int yywrap() {
    return 1;
}
