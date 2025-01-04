%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);

%}

/* Tokens */
%token INT BOOL CHAR STRING IF ELSE CONST DO WHILE CIN COUT RETURN FOR
%token IDENTIFIER INT_CONST STRING_LITERAL TRUE FALSE
%token PLUS MINUS MUL DIV ASSIGN EQ NEQ LT LTE GT GTE PLUSEQ MINUSEQ MULEQ DIVEQ
%token SEMICOLON LBRACE RBRACE LPAREN RPAREN LSQUARE RSQUARE

/* Precedence and associativity */
%left PLUS MINUS
%left MUL DIV
%nonassoc LT LTE GT GTE EQ NEQ
%nonassoc ELSE

%%

program:
    declaration_list statement_list
    ;

declaration_list:
    /* empty */
  | declaration_list declaration
    ;

declaration:
    type IDENTIFIER SEMICOLON
  | type IDENTIFIER LSQUARE INT_CONST RSQUARE SEMICOLON
    ;

type:
    INT
  | BOOL
  | CHAR
  | STRING
    ;

statement_list:
    /* empty */
  | statement_list statement
    ;

statement:
    assignment
  | io_statement
  | if_statement
  | while_statement
  | do_while_statement
  | for_statement
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
  | IDENTIFIER PLUSEQ expression SEMICOLON
  | IDENTIFIER MINUSEQ expression SEMICOLON
  | IDENTIFIER MULEQ expression SEMICOLON
  | IDENTIFIER DIVEQ expression SEMICOLON
    ;

io_statement:
    CIN LPAREN IDENTIFIER RPAREN SEMICOLON
  | COUT LPAREN IDENTIFIER RPAREN SEMICOLON
    ;

if_statement:
    IF LPAREN condition RPAREN LBRACE statement_list RBRACE
  | IF LPAREN condition RPAREN LBRACE statement_list RBRACE ELSE LBRACE statement_list RBRACE
    ;

while_statement:
    WHILE LPAREN condition RPAREN LBRACE statement_list RBRACE
    ;

do_while_statement:
    DO LBRACE statement_list RBRACE WHILE LPAREN condition RPAREN SEMICOLON
    ;

for_statement:
    FOR LPAREN assignment condition SEMICOLON assignment RPAREN LBRACE statement_list RBRACE
    ;

condition:
    expression
  | expression EQ expression
  | expression NEQ expression
  | expression LT expression
  | expression LTE expression
  | expression GT expression
  | expression GTE expression
    ;

expression:
    expression PLUS term
  | expression MINUS term
  | term
    ;

term:
    term MUL factor
  | term DIV factor
  | factor
    ;

factor:
    LPAREN expression RPAREN
  | IDENTIFIER
  | INT_CONST
  | STRING_LITERAL
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("fopen");
            return 1;
        }
    }

    if (yyparse() == 0) {
        printf("Program parsed successfully.\n");
    }

    return 0;
}
