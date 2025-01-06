%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int yydebug; // Declaration of yydebug

void yyerror(const char *s);

int productions_used[1000];
int prod_count = 0;

// Record a production number
#define RECORD_PRODUCTION(num) \
    do { \
        productions_used[prod_count++] = (num); \
    } while (0)
%}

/* Tokens */
%token IDENTIFIER INT_CONST STRING_LITERAL
%token PLUS MINUS MUL DIV MOD ASSIGN CIN COUT IF ELSE WHILE FOR DO RETURN CONST
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON
%token GT LT GTE LTE EQ NEQ
%token BOOL CHAR STRING INT TRUE FALSE
%token RSHIFT LSHIFT
%token MAIN

/* Precedence and associativity */
%left OR
%left AND
%left EQ NEQ
%left LT LTE GT GTE
%left PLUS MINUS
%left MUL DIV MOD
%right NOT
%nonassoc ELSE

%%
/* Production rules */

/* 1: program -> INT MAIN ( ) { stmt_list final_return } */
program: INT MAIN LPAREN RPAREN LBRACE stmt_list final_return RBRACE
        { RECORD_PRODUCTION(1); 
          printf("Program syntactic correct\n"); 
          printf("Productions used: ");
          for (int i = 0; i < prod_count; i++) {
              printf("%d ", productions_used[i]);
          }
          printf("\n");
        }
;

/* 2: final_return -> RETURN INT_CONST SEMICOLON */
final_return: RETURN INT_CONST SEMICOLON
            { RECORD_PRODUCTION(2); }
;

/* 3: stmt_list -> stmt_list stmt | ε (empty) */
stmt_list:
    /* empty */
  | stmt_list stmt
    { RECORD_PRODUCTION(3); }
;

/* 4: stmt -> stmt_simple SEMICOLON 
   5: stmt -> stmt_cmpd 
   6: stmt -> stmt_if 
   7: stmt -> stmt_while */
stmt: stmt_simple SEMICOLON
    { RECORD_PRODUCTION(4); }
  | stmt_cmpd
    { RECORD_PRODUCTION(5); }
  | stmt_if
    { RECORD_PRODUCTION(6); }
  | stmt_while
    { RECORD_PRODUCTION(7); }
;

/* 8: stmt_simple -> stmt_assign | stmt_io | DataType IDENTIFIER */
stmt_simple: stmt_assign
           { RECORD_PRODUCTION(8); }
         | stmt_io
           { RECORD_PRODUCTION(9); }
         | DataType IDENTIFIER
           { RECORD_PRODUCTION(10); }
;

/* 9: stmt_assign -> IDENTIFIER = expression */
stmt_assign: IDENTIFIER ASSIGN expression
    { RECORD_PRODUCTION(11); }
;

/* 10: stmt_io -> CIN >> IDENTIFIER
    11: stmt_io -> COUT << printable_list */
stmt_io: CIN RSHIFT IDENTIFIER
       { RECORD_PRODUCTION(12); }
     | COUT LSHIFT printable_list
       { RECORD_PRODUCTION(13); }
;

/* 12: printable_list -> factor | factor << printable_list */
printable_list: factor
              { RECORD_PRODUCTION(14); }
              | factor LSHIFT printable_list
              { RECORD_PRODUCTION(15); }
;

/* Factor rules:
   13: factor -> ( expression )
   14: factor -> IDENTIFIER
   15: factor -> INT_CONST
   16: factor -> STRING_LITERAL */
factor: LPAREN expression RPAREN
      { RECORD_PRODUCTION(16); }
      | IDENTIFIER
      { RECORD_PRODUCTION(17); }
      | INT_CONST
      { RECORD_PRODUCTION(18); }
      | STRING_LITERAL
      { RECORD_PRODUCTION(19); }
;

/* 17: stmt_cmpd -> { stmt_list } */
stmt_cmpd: LBRACE stmt_list RBRACE
    { RECORD_PRODUCTION(20); }
;

/* 18: stmt_if -> IF ( condition ) stmt | IF ( condition ) stmt ELSE stmt */
stmt_if: IF LPAREN condition RPAREN stmt %prec ELSE
       { RECORD_PRODUCTION(21); }
       | IF LPAREN condition RPAREN stmt ELSE stmt
       { RECORD_PRODUCTION(22); }
;

/* 19: stmt_while -> WHILE ( condition ) stmt */
stmt_while: WHILE LPAREN condition RPAREN stmt
    { RECORD_PRODUCTION(23); }
;

/* DataType: INT | BOOL | CHAR | STRING */
DataType: INT
        { RECORD_PRODUCTION(24); }
        | BOOL
        { RECORD_PRODUCTION(25); }
        | CHAR
        { RECORD_PRODUCTION(26); }
        | STRING
        { RECORD_PRODUCTION(27); }
;

/* 20: condition -> expression rel_op expression */
condition: expression rel_op expression
         { RECORD_PRODUCTION(28); }
;

/* Relational operators */
rel_op: LT { RECORD_PRODUCTION(29); }
      | LTE { RECORD_PRODUCTION(30); }
      | GT { RECORD_PRODUCTION(31); }
      | GTE { RECORD_PRODUCTION(32); }
      | EQ { RECORD_PRODUCTION(33); }
      | NEQ { RECORD_PRODUCTION(34); }
;

/* Expressions */
expression: term { RECORD_PRODUCTION(35); }
          | term PLUS expression { RECORD_PRODUCTION(36); }
          | term MINUS expression { RECORD_PRODUCTION(37); }
;

term: factor { RECORD_PRODUCTION(38); }
    | factor MUL term { RECORD_PRODUCTION(39); }
    | factor DIV term { RECORD_PRODUCTION(40); }
    | factor MOD term { RECORD_PRODUCTION(41); }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    if (prod_count > 0) {
        printf("Error at production %d\n", productions_used[prod_count - 1]);
    } else {
        printf("Error before any production was reduced.\n");
    }
    exit(1);
}

int main(int argc, char **argv) {
    yydebug = 0; 
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
        printf("Parsing complete.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}
