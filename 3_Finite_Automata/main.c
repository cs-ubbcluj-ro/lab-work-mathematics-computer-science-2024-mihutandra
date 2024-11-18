#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_STATES 100
#define MAX_SYMBOLS 100
#define MAX_TRANSITIONS 500

typedef struct {
    char from_state[20];
    char symbol[5];
    char to_state[20];
} Transition;

typedef struct {
    char states[MAX_STATES][20];
    int state_count;

    char alphabet[MAX_SYMBOLS][5];
    int alphabet_count;

    Transition transitions[MAX_TRANSITIONS];
    int transition_count;

    char initial_state[20];
    char final_states[MAX_STATES][20];
    int final_state_count;
} FiniteAutomaton;

char* trim(char* str) {
    char* end;
    while (isspace((unsigned char)*str)) str++;
    if (*str == 0) return str;
    end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    end[1] = '\0';
    return str;
}

void load_fa_from_file(const char *filename, FiniteAutomaton *fa) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Failed to open file");
        exit(1);
    }

    char line[256];
    char *token;

    // Read States
    if (fgets(line, sizeof(line), file)) {
        strtok(line, ":");
        token = strtok(NULL, ",");
        while (token) {
            strcpy(fa->states[fa->state_count++], trim(token));
            token = strtok(NULL, ",\n");
        }
    }

    // Read Alphabet
    if (fgets(line, sizeof(line), file)) {
        strtok(line, ":");
        token = strtok(NULL, ",");
        while (token) {
            strcpy(fa->alphabet[fa->alphabet_count++], trim(token));
            token = strtok(NULL, ",\n");
        }
    }

    // Read Transitions
    if (fgets(line, sizeof(line), file)) {
        strtok(line, ":");
        token = strtok(NULL, ";");
        while (token) {
            Transition t;
            sscanf(token, "%[^,],%[^,]->%s", t.from_state, t.symbol, t.to_state);
            fa->transitions[fa->transition_count++] = t;
            token = strtok(NULL, ";\n");
        }
    }

    // Read Initial State
    if (fgets(line, sizeof(line), file)) {
        strtok(line, ":");
        strcpy(fa->initial_state, trim(strtok(NULL, "\n")));
    }

    // Read Final States
    if (fgets(line, sizeof(line), file)) {
        strtok(line, ":");
        token = strtok(NULL, ",");
        while (token) {
            strcpy(fa->final_states[fa->final_state_count++], trim(token));
            token = strtok(NULL, ",\n");
        }
    }

    fclose(file);
}

void display_fa(const FiniteAutomaton *fa) {
    printf("\nSet of States: {");
    for (int i = 0; i < fa->state_count; i++) {
        printf("%s%s", fa->states[i], (i < fa->state_count - 1) ? ", " : "");
    }
    printf("}\n");

    printf("Alphabet: {");
    for (int i = 0; i < fa->alphabet_count; i++) {
        printf("%s%s", fa->alphabet[i], (i < fa->alphabet_count - 1) ? ", " : "");
    }
    printf("}\n");

    printf("Transitions:\n");
    for (int i = 0; i < fa->transition_count; i++) {
        printf("  %s -- %s --> %s\n",
               fa->transitions[i].from_state,
               fa->transitions[i].symbol,
               fa->transitions[i].to_state);
    }

    printf("Initial State: %s\n", fa->initial_state);

    printf("Final States: {");
    for (int i = 0; i < fa->final_state_count; i++) {
        printf("%s%s", fa->final_states[i], (i < fa->final_state_count - 1) ? ", " : "");
    }
    printf("}\n");
}

int is_valid_token(const FiniteAutomaton *fa, const char *token) {
    char current_state[20];
    strcpy(current_state, fa->initial_state);

    for (int i = 0; i < strlen(token); i++) {
        char symbol[5] = {token[i], '\0'};
        int found = 0;

        // Check if the symbol is in the alphabet
        int in_alphabet = 0;
        for (int k = 0; k < fa->alphabet_count; k++) {
            if (strcmp(symbol, fa->alphabet[k]) == 0) {
                in_alphabet = 1;
                break;
            }
        }
        if (!in_alphabet) return 0;

        for (int j = 0; j < fa->transition_count; j++) {
            if (strcmp(fa->transitions[j].from_state, current_state) == 0 &&
                strcmp(fa->transitions[j].symbol, symbol) == 0) {
                strcpy(current_state, fa->transitions[j].to_state);
                found = 1;
                break;
            }
        }

        if (!found) return 0;
    }

    for (int i = 0; i < fa->final_state_count; i++) {
        if (strcmp(current_state, fa->final_states[i]) == 0) {
            return 1;
        }
    }

    return 0;
}

int main() {
    FiniteAutomaton fa = {0};

    load_fa_from_file("FA.in", &fa);
    display_fa(&fa);

    char test_string[100];
    printf("\nEnter a string to check if it's a valid token: ");
    scanf("%s", test_string);

    if (is_valid_token(&fa, test_string)) {
        printf("The string '%s' is a valid token.\n", test_string);
    } else {
        printf("The string '%s' is NOT a valid token.\n", test_string);
    }

    return 0;
}
