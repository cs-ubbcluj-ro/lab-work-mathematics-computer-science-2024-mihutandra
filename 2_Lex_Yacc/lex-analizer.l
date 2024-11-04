%{
#include <string.h>
#include <stdio.h>

typedef struct {
    char token[257];
    int symbolTableCode;
} PIF;

typedef struct {
    char token[257];
    int index;
} ST;

ST SymbolTable[100];
int stLength = 0;

PIF ProgramInternalForm[300];
int pifLength = 0;

int errorFound = 0;
int lineNumber = 1;

/* Function Definition */
int addToSymbolTable(char* token);
void addToProgramInternalForm(char* token, int stCode);
void showSymbolTable();
void showProgramInternalForm();

/* Functions */

int addToSymbolTable(char* token) {
    for(int i = 0; i < stLength; i++) {
        if(strcmp(SymbolTable[i].token, token) == 0) {
            return SymbolTable[i].index;
        }
    }
    /* If the token is not found in the symbol table, the function adds the new token at the end of the table */

    strcpy(SymbolTable[stLength].token, token);
    SymbolTable[stLength].index = stLength;
    stLength++;
    return stLength - 1; /* returns the index of the newly added token */
}

void addToProgramInternalForm(char* token, int stCode) {
    strcpy(ProgramInternalForm[pifLength].token, token);
    ProgramInternalForm[pifLength].symbolTableCode = stCode;
    pifLength++;
}

void showSymbolTable() {
    printf("--------------- ST ---------------\n");
    for(int i = 0; i < stLength; i++) {
        printf(" %s  %d\n", SymbolTable[i].token, SymbolTable[i].index);
        printf("------------------------------\n");
    }
    printf("\n\n");
}

void showProgramInternalForm() {
    printf("--------------- PIF ----------------\n");
    for(int i = 0; i < pifLength; i++) {
        printf(" %s  %d\n", ProgramInternalForm[i].token, ProgramInternalForm[i].symbolTableCode);
        printf("------------------------------\n");
    }
}

%}

IDENTIFIER [a-zăîșțâ][a-z0-9_ăîșțâ]*
NUMBER     [+-]?(0|[1-9][0-9]*)
STRING     \"[^\"]*\"

/*** Rule Section ***/
%%
dacă                                     { addToProgramInternalForm(yytext, -1); }
altfel                                   { addToProgramInternalForm(yytext, -1); }
întreg                                   { addToProgramInternalForm(yytext, -1); }
șir                                      { addToProgramInternalForm(yytext, -1); }
bool                                     { addToProgramInternalForm(yytext, -1); }
caracter                                 { addToProgramInternalForm(yytext, -1); }
cât                                      { addToProgramInternalForm(yytext, -1); }
pentru                                   { addToProgramInternalForm(yytext, -1); }
execută                                  { addToProgramInternalForm(yytext, -1); }
returnează                               { addToProgramInternalForm(yytext, -1); }
afișează                                 { addToProgramInternalForm(yytext, -1); }
citește                                  { addToProgramInternalForm(yytext, -1); }
[=+\-*/%]                                { addToProgramInternalForm(yytext, -1); }
[<>=!]=?                                 { addToProgramInternalForm(yytext, -1); }
[\(\)\{\};,]                             { addToProgramInternalForm(yytext, -1); }

{IDENTIFIER}                             { int stCode = addToSymbolTable(yytext); addToProgramInternalForm(yytext, stCode); }
{NUMBER}                                 { int stCode = addToSymbolTable(yytext); addToProgramInternalForm(yytext, stCode); }
{STRING}                                 { int stCode = addToSymbolTable(yytext); addToProgramInternalForm(yytext, stCode); }
[\n]                                     { ++lineNumber; }
[ \t\n]+                                 { /* eat up whitespace */ }
.                                        { errorFound = 1; printf("Illegal token %s at line %d\n", yytext, lineNumber); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {}

int main(int argc, char** argv) {
    FILE *fp;
    if (argc < 2) {
        printf("Please provide an input file.\n");
        return 1;
    }

    fp = fopen(argv[1], "r");
    if (!fp) {
        printf("Failed to open the file %s.\n", argv[1]);
        return 1;
    }
    
    yyin = fp;
    yylex();

    if (errorFound == 0) {
        showSymbolTable();
        showProgramInternalForm();
    }

    fclose(fp);
    return 0;
}
