%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int yydebug;

void yyerror(const char *s);

char *last_production = "None";
void record_production(const char *production_name) {
    last_production = production_name;
    printf("Production used: %s\n", production_name);
}
%}

/* Tokens */
%token INT BOOL CHAR STRING IF ELSE CONST DO WHILE CIN COUT RETURN FOR
%token IDENTIFIER INT_CONST STRING_LITERAL TRUE FALSE
%token PLUS MINUS MUL DIV ASSIGN EQ NEQ LT LTE GT GTE MOD AND OR NOT
%token SEMICOLON LBRACE RBRACE LPAREN RPAREN STREAMOUT STREAMIN MAIN
%token LSQUARE RSQUARE COMMA

/* Precedence and associativity */
%left OR
%left AND
%nonassoc LT LTE GT GTE EQ NEQ
%left PLUS MINUS
%left MUL DIV MOD
%nonassoc ELSE

%start program

%%

program:
    INT MAIN LPAREN RPAREN LBRACE statement_list RETURN INT_CONST SEMICOLON RBRACE {
        record_production("program");
        printf("Program parsed successfully. Last production: %s\n", last_production);
    }
    ;

statement_list:
    /* empty */
  | statement_list statement {
        record_production("statement_list");
    }
    ;

statement:
    declaration
  | assignment
  | io_statement
  | if_statement
  | while_statement
  | do_while_statement
  | for_statement
  | return_statement
  | compound_statement {
        record_production("statement");
    }
    ;

declaration:
    type IDENTIFIER SEMICOLON {
        record_production("declaration");
    }
  | type IDENTIFIER COMMA declaration_tail SEMICOLON {
        record_production("multiple_declaration");
    }
    ;

declaration_tail:
    IDENTIFIER
  | IDENTIFIER COMMA declaration_tail {
        record_production("declaration_tail");
    }
    ;

type:
    INT { record_production("type_INT"); }
  | BOOL { record_production("type_BOOL"); }
  | CHAR { record_production("type_CHAR"); }
  | STRING { record_production("type_STRING"); }
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        record_production("assignment");
    }
  | IDENTIFIER PLUS ASSIGN expression SEMICOLON {
        record_production("compound_assignment");
    }
  | IDENTIFIER MINUS ASSIGN expression SEMICOLON {
        record_production("compound_assignment");
    }
    ;

io_statement:
    CIN STREAMOUT IDENTIFIER SEMICOLON {  // Reading input
        record_production("cin_statement");
    }
  | COUT STREAMIN expression SEMICOLON {  // Output with expressions
        record_production("cout_statement");
    }
    ;


if_statement:
    IF LPAREN condition RPAREN LBRACE statement_list RBRACE {
        record_production("if_statement");
    }
  | IF LPAREN condition RPAREN LBRACE statement_list RBRACE ELSE LBRACE statement_list RBRACE {
        record_production("if_else_statement");
    }
    ;

while_statement:
    WHILE LPAREN condition RPAREN LBRACE statement_list RBRACE {
        record_production("while_statement");
    }
    ;

do_while_statement:
    DO LBRACE statement_list RBRACE WHILE LPAREN condition RPAREN SEMICOLON {
        record_production("do_while_statement");
    }
    ;

for_statement:
    FOR LPAREN assignment condition SEMICOLON assignment RPAREN LBRACE statement_list RBRACE {
        record_production("for_statement");
    }
    ;

return_statement:
    RETURN expression SEMICOLON {
        record_production("return_statement");
    }
    ;

compound_statement:
    LBRACE statement_list RBRACE {
        record_production("compound_statement");
    }
    ;

condition:
    expression
  | expression EQ expression
  | expression NEQ expression
  | expression LT expression
  | expression LTE expression
  | expression GT expression
  | expression GTE expression {
        record_production("condition");
    }
  | condition AND condition
  | condition OR condition
  | NOT condition {
        record_production("logical_condition");
    }
    ;

expression:
    expression PLUS term
  | expression MINUS term
  | term { record_production("expression"); }
    ;

term:
    term MUL factor
  | term DIV factor
  | term MOD factor
  | factor { record_production("term"); }
    ;

factor:
    LPAREN expression RPAREN
  | IDENTIFIER
  | INT_CONST
  | STRING_LITERAL
  | TRUE
  | FALSE { record_production("factor"); }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s. Last production: %s\n", s, last_production);
    exit(1);
}

int main(int argc, char **argv) {
    yydebug = 1; // Enable debug output
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("fopen");
            return 1;
        }
    } else {
        yyin = stdin;
    }

    if (yyparse() == 0) {
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }

    return 0;
}
