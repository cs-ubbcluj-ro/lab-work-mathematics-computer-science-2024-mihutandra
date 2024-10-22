/*** Definition Section ***/
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

/* Function prototypes */
int addToST(char* token);
void addToPIF(char* token, int stCode);
void showSymbolTable();
void showProgramInternalForm();

/* Functions */
int addToST(char* token) {
    for(int i = 0; i < stLength; i++) {
        if(strcmp(SymbolTable[i].token, token) == 0) {
            return SymbolTable[i].index;
        }
    }
    strcpy(SymbolTable[stLength].token, token);
    SymbolTable[stLength].index = stLength;
    stLength++;
    return stLength - 1;
}

void addToPIF(char* token, int stCode) {
    strcpy(ProgramInternalForm[pifLength].token, token);
    ProgramInternalForm[pifLength].symbolTableCode = stCode;
    pifLength++;
}

void showSymbolTable() {
    printf("~~~~~~~ Symbol Table ~~~~~~~\n");
    for(int i = 0; i < stLength; i++) {
        printf(" %s  %d\n", SymbolTable[i].token, SymbolTable[i].index);
    }
    printf("~~~~~~~ End Symbol Table ~~~~~~~\n\n");
}

void showProgramInternalForm() {
    printf("~~~~~~~ Program Internal Form ~~~~~~~\n");
    for(int i = 0; i < pifLength; i++) {
        printf(" %s  %d\n", ProgramInternalForm[i].token, ProgramInternalForm[i].symbolTableCode);
    }
    printf("~~~~~~~ End Program Internal Form ~~~~~~~\n\n");
}

%}

IDENTIFIER [a-zăîșțâ][a-z0-9_ăîșțâ]*
NUMBER     [+-]?(0|[1-9][0-9]*)
STRING     \"[^\"]*\"

/*** Rule Section ***/
%%
dacă                                     { addToPIF(yytext, -1); }
altfel                                   { addToPIF(yytext, -1); }
întreg                                   { addToPIF(yytext, -1); }
șir                                      { addToPIF(yytext, -1); }
bool                                     { addToPIF(yytext, -1); }
caracter                                 { addToPIF(yytext, -1); }
cât                                      { addToPIF(yytext, -1); }
pentru                                   { addToPIF(yytext, -1); }
execută                                  { addToPIF(yytext, -1); }
returnează                               { addToPIF(yytext, -1); }
afișează                                 { addToPIF(yytext, -1); }
citește                                  { addToPIF(yytext, -1); }
[=+\-*/%]                                { addToPIF(yytext, -1); }
[<>=!]=?                                 { addToPIF(yytext, -1); }
[\(\)\{\};,]                             { addToPIF(yytext, -1); }

{IDENTIFIER}                             { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{NUMBER}                                 { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{STRING}                                 { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
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
